using System.Security.Claims;
using Hatt.Application.DTOs;
using Hatt.Domain.Services;
using Hatt.Infrastructure.Persistence;
using Hatt.Infrastructure.Services;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Endpoints;

public static class LeagueEndpoints
{
    public static IEndpointRouteBuilder MapLeagueEndpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/v1").RequireAuthorization();

        group.MapPost("/lessons/complete", async (
            CompleteLessonRequest request,
            ClaimsPrincipal principal,
            HattDbContext db,
            LeagueService league,
            HttpContext httpContext,
            CancellationToken ct) =>
        {
            var idempotencyKey = httpContext.Request.Headers["Idempotency-Key"].ToString();
            if (string.IsNullOrWhiteSpace(idempotencyKey) || idempotencyKey.Length > 64)
            {
                return Results.BadRequest(new { error = "missing_or_invalid_idempotency_key" });
            }

            var calculated = VerifiedXpCalculator.Compute(new LessonMetrics(
                request.TotalExercises,
                request.CorrectFirstTry,
                request.TotalWrong,
                request.MaxCombo));

            if (calculated is null)
            {
                return Results.BadRequest(new { error = "implausible_lesson_metrics" });
            }

            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var result = await league.RecordVerifiedXpAsync(
                user, idempotencyKey, request.NodeId, calculated.Value, ct);

            return Results.Ok(new
            {
                awardedXp = result.AwardedXp,
                weeklyXp = result.WeeklyXp,
                weekId = result.WeekId,
                alreadyProcessed = result.AlreadyProcessed,
            });
        });

        group.MapGet("/leagues/current", async (
            ClaimsPrincipal principal,
            HattDbContext db,
            LeagueService league,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var now = clock.GetUtcNow();
            var weekId = WeekService.WeekId(now);
            var member = await league.EnsureMembershipAsync(user, weekId, now, ct);

            var standings = await db.LeagueMembers
                .Where(m => m.CohortId == member.CohortId)
                .OrderByDescending(m => m.WeeklyXp)
                .ThenBy(m => m.UserId)
                .Select(m => new { m.UserId, m.User.Nickname, m.WeeklyXp })
                .ToListAsync(ct);

            var result = new List<LeagueStandingDto>(standings.Count);
            for (var i = 0; i < standings.Count; i++)
            {
                var s = standings[i];
                result.Add(new LeagueStandingDto(
                    Rank: i + 1,
                    Nickname: s.Nickname ?? "Anonim",
                    WeeklyXp: s.WeeklyXp,
                    IsMe: s.UserId == user.Id));
            }

            return Results.Ok(new LeagueCurrentResponse(
                WeekId: weekId,
                Tier: user.CurrentTier.ToString().ToLowerInvariant(),
                WeekEnd: WeekService.WeekEnd(now),
                PromoteCount: CohortSettlement.PromoteCount,
                RelegateCount: CohortSettlement.RelegateCount,
                Standings: result));
        });

        group.MapGet("/leagues/last-result", async (
            ClaimsPrincipal principal,
            HattDbContext db,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var lastWeekId = WeekService.PreviousWeekId(clock.GetUtcNow());
            var member = await db.LeagueMembers
                .Include(m => m.Cohort)
                .FirstOrDefaultAsync(m => m.WeekId == lastWeekId && m.UserId == user.Id, ct);

            if (member is null || member.FinalRank is null || member.Outcome is null)
            {
                return Results.NotFound(new { error = "no_result_for_previous_week" });
            }

            return Results.Ok(new LeagueLastResultResponse(
                WeekId: lastWeekId,
                Tier: member.Cohort.Tier.ToString().ToLowerInvariant(),
                FinalRank: member.FinalRank.Value,
                Outcome: member.Outcome.Value.ToString().ToLowerInvariant(),
                NextTier: user.CurrentTier.ToString().ToLowerInvariant()));
        });

        return app;
    }
}
