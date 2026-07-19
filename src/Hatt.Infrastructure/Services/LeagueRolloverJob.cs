using Hatt.Domain.Entities;
using Hatt.Domain.Services;
using Hatt.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hatt.Infrastructure.Services;

public class LeagueRolloverJob(
    HattDbContext db,
    TimeProvider clock,
    ILogger<LeagueRolloverJob> logger)
{
    public async Task RunAsync(CancellationToken ct = default)
    {
        var now = clock.GetUtcNow();
        var endedWeekId = WeekService.PreviousWeekId(now);
        await SettleWeekAsync(endedWeekId, ct);
    }

    public async Task SettleWeekAsync(string weekId, CancellationToken ct)
    {
        await using var tx = await db.Database.BeginTransactionAsync(ct);
        await db.Database.ExecuteSqlAsync(
            $"SELECT pg_advisory_xact_lock(hashtextextended({weekId}, 11))", ct);

        var week = await db.LeagueWeeks.FindAsync([weekId], ct);
        if (week is null)
        {
            logger.LogInformation("Rollover: week {WeekId} had no activity — nothing to settle.", weekId);
            await tx.CommitAsync(ct);
            return;
        }
        if (week.Status == LeagueWeekStatus.Settled)
        {
            logger.LogInformation("Rollover: week {WeekId} already settled — skipping.", weekId);
            await tx.CommitAsync(ct);
            return;
        }

        var cohortIds = await db.LeagueCohorts
            .Where(c => c.WeekId == weekId)
            .Select(c => c.Id)
            .ToListAsync(ct);

        var settledMembers = 0;
        foreach (var cohortId in cohortIds)
        {
            var members = await db.LeagueMembers
                .Include(m => m.User)
                .Where(m => m.CohortId == cohortId)
                .ToListAsync(ct);

            var standings = members
                .Select(m => new MemberStanding(m.UserId, m.WeeklyXp, m.User.CurrentTier))
                .ToList();
            var settled = CohortSettlement.Settle(standings);

            var byUser = members.ToDictionary(m => m.UserId);
            foreach (var s in settled)
            {
                var member = byUser[s.UserId];
                member.FinalRank = s.Rank;
                member.Outcome = s.Outcome;
                member.User.CurrentTier = s.NextTier;
                settledMembers++;
            }
        }

        week.Status = LeagueWeekStatus.Settled;
        await db.SaveChangesAsync(ct);
        await tx.CommitAsync(ct);

        logger.LogInformation(
            "Rollover: settled week {WeekId} — {Cohorts} cohorts, {Members} members.",
            weekId, cohortIds.Count, settledMembers);
    }
}
