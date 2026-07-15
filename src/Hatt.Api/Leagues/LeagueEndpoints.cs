using System.Security.Claims;
using Hatt.Api.Data;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Leagues;

public record CompleteLessonRequest(
    string NodeId,
    int TotalExercises,
    int CorrectFirstTry,
    int WrongAnswers,
    int LongestCombo);

public record CompleteLessonResponse(
    int VerifiedXp,
    int WeeklyXp,
    string WeekId,
    bool AlreadyProcessed);

public record StandingDto(int Rank, string Nickname, int WeeklyXp, bool IsMe);

public record LeagueSnapshotDto(
    string WeekId,
    DateTimeOffset WeekEndsAt,
    string Tier,
    int PromoteCount,
    int RelegateCount,
    List<StandingDto> Standings);

public static class LeagueEndpoints
{
    public static IEndpointRouteBuilder MapLeagueEndpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/v1").RequireAuthorization();

        // Verified lesson completion → server-calculated league XP.
        // The client never submits an XP total (server-authoritative).
        group.MapPost("/lessons/complete", async (
            CompleteLessonRequest request,
            HttpRequest http,
            ClaimsPrincipal principal,
            HattDbContext db,
            LeagueService league,
            CancellationToken ct) =>
        {
            var user = await FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var idempotencyKey = http.Headers["Idempotency-Key"].FirstOrDefault();
            if (string.IsNullOrWhiteSpace(idempotencyKey) ||
                idempotencyKey.Length is < 8 or > 64)
            {
                return Results.BadRequest(new { error = "missing_idempotency_key" });
            }
            if (string.IsNullOrWhiteSpace(request.NodeId) || request.NodeId.Length > 64)
            {
                return Results.BadRequest(new { error = "invalid_node_id" });
            }

            var xp = VerifiedXpCalculator.Compute(new LessonMetrics(
                request.TotalExercises,
                request.CorrectFirstTry,
                request.WrongAnswers,
                request.LongestCombo));
            if (xp is null)
            {
                return Results.BadRequest(new { error = "implausible_metrics" });
            }

            var result = await league.RecordVerifiedXpAsync(
                user, idempotencyKey, request.NodeId, xp.Value, ct);
            return Results.Ok(new CompleteLessonResponse(
                result.AwardedXp, result.WeeklyXp, result.WeekId, result.AlreadyProcessed));
        });

        // Current cohort standings. 404 = not in a league yet this week
        // (client shows "complete a lesson to join").
        group.MapGet("/leagues/current", async (
            ClaimsPrincipal principal,
            HattDbContext db,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            var user = await FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var now = clock.GetUtcNow();
            var weekId = WeekService.WeekId(now);
            var membership = await db.LeagueMembers
                .FirstOrDefaultAsync(m => m.WeekId == weekId && m.UserId == user.Id, ct);
            if (membership is null)
            {
                return Results.NotFound(new { error = "not_in_league" });
            }

            var standings = await db.LeagueMembers
                .Where(m => m.CohortId == membership.CohortId)
                .OrderByDescending(m => m.WeeklyXp)
                .ThenBy(m => m.UserId)
                .Select(m => new { m.UserId, m.User.Nickname, m.WeeklyXp })
                .ToListAsync(ct);

            var dto = new LeagueSnapshotDto(
                weekId,
                WeekService.WeekEnd(now),
                user.CurrentTier.ToString().ToLowerInvariant(),
                CohortSettlement.PromoteCount,
                CohortSettlement.RelegateCount,
                standings.Select((s, i) => new StandingDto(
                    i + 1,
                    s.Nickname ?? "Öğrenci",
                    s.WeeklyXp,
                    s.UserId == user.Id)).ToList());
            return Results.Ok(dto);
        });

        // Last settled week's personal result (rank + promotion outcome).
        group.MapGet("/leagues/last-result", async (
            ClaimsPrincipal principal,
            HattDbContext db,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            var user = await FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var previousWeek = WeekService.PreviousWeekId(clock.GetUtcNow());
            var member = await db.LeagueMembers
                .FirstOrDefaultAsync(
                    m => m.WeekId == previousWeek && m.UserId == user.Id && m.FinalRank != null, ct);
            return member is null
                ? Results.NotFound(new { error = "no_result" })
                : Results.Ok(new
                {
                    weekId = previousWeek,
                    rank = member.FinalRank,
                    outcome = member.Outcome?.ToString().ToLowerInvariant(),
                    weeklyXp = member.WeeklyXp,
                    tier = user.CurrentTier.ToString().ToLowerInvariant(),
                });
        });

        return app;
    }

    private static async Task<User?> FindUserAsync(
        ClaimsPrincipal principal, HattDbContext db, CancellationToken ct)
    {
        var sub = principal.FindFirstValue(ClaimTypes.NameIdentifier)
            ?? principal.FindFirstValue("sub");
        return Guid.TryParse(sub, out var id)
            ? await db.Users.FirstOrDefaultAsync(u => u.Id == id, ct)
            : null;
    }
}
