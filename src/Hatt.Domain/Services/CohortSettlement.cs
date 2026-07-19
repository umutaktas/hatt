using Hatt.Domain.Entities;

namespace Hatt.Domain.Services;

public record MemberStanding(Guid UserId, int WeeklyXp, LeagueTier Tier);

public record SettledStanding(
    Guid UserId,
    int Rank,
    LeagueOutcome Outcome,
    LeagueTier NextTier);

public static class CohortSettlement
{
    public const int PromoteCount = 5;
    public const int RelegateCount = 5;

    public static List<SettledStanding> Settle(IReadOnlyCollection<MemberStanding> members)
    {
        var ordered = members
            .OrderByDescending(m => m.WeeklyXp)
            .ThenBy(m => m.UserId)
            .ToList();

        var total = ordered.Count;
        var result = new List<SettledStanding>(total);

        for (var i = 0; i < total; i++)
        {
            var m = ordered[i];
            var rank = i + 1;

            LeagueOutcome outcome;
            if (rank <= PromoteCount)
            {
                outcome = LeagueOutcome.Promoted;
            }
            else if (total > PromoteCount && rank > total - RelegateCount)
            {
                outcome = LeagueOutcome.Relegated;
            }
            else
            {
                outcome = LeagueOutcome.Stayed;
            }

            var nextTier = outcome switch
            {
                LeagueOutcome.Promoted => (LeagueTier)Math.Min((int)m.Tier + 1, (int)LeagueTier.Diamond),
                LeagueOutcome.Relegated => (LeagueTier)Math.Max((int)m.Tier - 1, (int)LeagueTier.Bronze),
                _ => m.Tier,
            };

            result.Add(new SettledStanding(m.UserId, rank, outcome, nextTier));
        }

        return result;
    }
}
