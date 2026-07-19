using Hatt.Domain.Entities;
using Hatt.Domain.Services;
using Hatt.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Infrastructure.Services;

public record XpResult(int AwardedXp, int WeeklyXp, string WeekId, bool AlreadyProcessed);

public class LeagueService(HattDbContext db, TimeProvider clock)
{
    public const int CohortCapacity = 30;

    public async Task<XpResult> RecordVerifiedXpAsync(
        User user, string idempotencyKey, string? nodeId, int amount, CancellationToken ct)
    {
        var now = clock.GetUtcNow();
        var weekId = WeekService.WeekId(now);

        await using var tx = await db.Database.BeginTransactionAsync(ct);

        await db.Database.ExecuteSqlAsync(
            $"SELECT pg_advisory_xact_lock(hashtextextended({user.Id.ToString()}, 7))", ct);

        var existing = await db.XpEvents.FirstOrDefaultAsync(
            x => x.UserId == user.Id && x.IdempotencyKey == idempotencyKey, ct);
        if (existing is not null)
        {
            var currentXp = await WeeklyXpAsync(user.Id, existing.WeekId, ct);
            await tx.CommitAsync(ct);
            return new XpResult(existing.Amount, currentXp, existing.WeekId, AlreadyProcessed: true);
        }

        var dayStart = new DateTimeOffset(now.UtcDateTime.Date, TimeSpan.Zero);
        var awardedToday = await db.XpEvents
            .Where(x => x.UserId == user.Id && x.CreatedAt >= dayStart)
            .SumAsync(x => (int?)x.Amount, ct) ?? 0;
        var granted = Math.Clamp(VerifiedXpCalculator.DailyCap - awardedToday, 0, amount);

        db.XpEvents.Add(new XpEvent
        {
            UserId = user.Id,
            WeekId = weekId,
            IdempotencyKey = idempotencyKey,
            NodeId = nodeId ?? "",
            Amount = granted,
            CreatedAt = now,
        });

        var member = await EnsureMembershipAsync(user, weekId, now, ct);
        member.WeeklyXp += granted;
        await db.SaveChangesAsync(ct);
        await tx.CommitAsync(ct);

        return new XpResult(granted, member.WeeklyXp, weekId, AlreadyProcessed: false);
    }

    public async Task<LeagueMember> EnsureMembershipAsync(
        User user, string weekId, DateTimeOffset now, CancellationToken ct)
    {
        var member = await db.LeagueMembers
            .FirstOrDefaultAsync(m => m.WeekId == weekId && m.UserId == user.Id, ct);
        if (member is not null)
        {
            return member;
        }

        var week = await db.LeagueWeeks.FindAsync([weekId], ct);
        if (week is null)
        {
            week = new LeagueWeek
            {
                Id = weekId,
                StartsAt = WeekService.WeekStart(now),
                EndsAt = WeekService.WeekEnd(now),
            };
            db.LeagueWeeks.Add(week);
        }

        var cohort = await db.LeagueCohorts
            .Where(c => c.WeekId == weekId && c.Tier == user.CurrentTier)
            .FirstOrDefaultAsync(ct);
        if (cohort is null)
        {
            cohort = new LeagueCohort
            {
                Id = Guid.NewGuid(),
                WeekId = weekId,
                Week = week,
                Tier = user.CurrentTier,
                CreatedAt = now,
            };
            db.LeagueCohorts.Add(cohort);
        }

        member = new LeagueMember
        {
            CohortId = cohort.Id,
            Cohort = cohort,
            UserId = user.Id,
            User = user,
            WeekId = weekId,
            WeeklyXp = 0,
            JoinedAt = now,
        };
        db.LeagueMembers.Add(member);
        return member;
    }

    private Task<int> WeeklyXpAsync(Guid userId, string weekId, CancellationToken ct) =>
        db.LeagueMembers
            .Where(m => m.WeekId == weekId && m.UserId == userId)
            .Select(m => m.WeeklyXp)
            .FirstOrDefaultAsync(ct);
}
