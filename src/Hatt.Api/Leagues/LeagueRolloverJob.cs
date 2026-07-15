using Hatt.Api.Data;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Leagues;

/// <summary>
/// Settles the previous league week: ranks every cohort, applies
/// promotion/relegation, writes new tiers onto users. Runs Monday 00:00 UTC
/// via Hangfire. Idempotent: a Postgres advisory lock serializes concurrent
/// runs and the week's status flag prevents double settlement. New-week
/// cohorts are NOT pre-built — membership is lazy (see LeagueService), so the
/// job's cost scales with active players only.
/// </summary>
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
        if (week.Status == WeekStatus.Settled)
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

        week.Status = WeekStatus.Settled;
        week.SettledAt = clock.GetUtcNow();
        await db.SaveChangesAsync(ct);
        await tx.CommitAsync(ct);

        logger.LogInformation(
            "Rollover: settled week {WeekId} — {Cohorts} cohorts, {Members} members.",
            weekId, cohortIds.Count, settledMembers);
    }
}
