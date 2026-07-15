using Hatt.Api.Data;

namespace Hatt.Api.Leagues;

public record MemberStanding(Guid UserId, int WeeklyXp, LeagueTier Tier);

public record SettledMember(
    Guid UserId,
    int Rank,
    LeagueOutcome Outcome,
    LeagueTier NextTier);

/// <summary>
/// Pure promotion/relegation mechanics — mirrors the mobile LeagueLogic
/// (top N promote, bottom N relegate, deterministic uid tie-break).
/// </summary>
public static class CohortSettlement
{
    public const int PromoteCount = 5;
    public const int RelegateCount = 5;

    public static List<SettledMember> Settle(IReadOnlyList<MemberStanding> members)
    {
        var sorted = members
            .OrderByDescending(m => m.WeeklyXp)
            .ThenBy(m => m.UserId)
            .ToList();

        var total = sorted.Count;
        var result = new List<SettledMember>(total);
        for (var i = 0; i < total; i++)
        {
            var rank = i + 1;
            var member = sorted[i];
            LeagueOutcome outcome;
            if (rank <= PromoteCount)
            {
                outcome = LeagueOutcome.Promoted;
            }
            else if (rank > total - RelegateCount && total > PromoteCount)
            {
                outcome = LeagueOutcome.Relegated;
            }
            else
            {
                outcome = LeagueOutcome.Stayed;
            }

            var nextTier = outcome switch
            {
                LeagueOutcome.Promoted =>
                    (LeagueTier)Math.Min((int)member.Tier + 1, (int)LeagueTier.Diamond),
                LeagueOutcome.Relegated =>
                    (LeagueTier)Math.Max((int)member.Tier - 1, (int)LeagueTier.Bronze),
                _ => member.Tier,
            };
            result.Add(new SettledMember(member.UserId, rank, outcome, nextTier));
        }
        return result;
    }
}
