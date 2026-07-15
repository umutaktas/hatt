using Hatt.Api.Data;
using Hatt.Api.Leagues;

namespace Hatt.Api.Tests;

public class WeekServiceTests
{
    [Fact]
    public void WeekId_is_stable_within_a_monday_anchored_week()
    {
        var monday = new DateTimeOffset(2026, 7, 13, 0, 0, 0, TimeSpan.Zero);
        var sunday = new DateTimeOffset(2026, 7, 19, 23, 59, 0, TimeSpan.Zero);
        var nextMonday = new DateTimeOffset(2026, 7, 20, 0, 0, 0, TimeSpan.Zero);

        Assert.Equal(WeekService.WeekId(monday), WeekService.WeekId(sunday));
        Assert.NotEqual(WeekService.WeekId(monday), WeekService.WeekId(nextMonday));
        Assert.Equal("2026-W29", WeekService.WeekId(monday));
    }

    [Fact]
    public void WeekEnd_is_next_monday_midnight_utc()
    {
        var wednesday = new DateTimeOffset(2026, 7, 15, 10, 0, 0, TimeSpan.Zero);
        Assert.Equal(
            new DateTimeOffset(2026, 7, 20, 0, 0, 0, TimeSpan.Zero),
            WeekService.WeekEnd(wednesday));
        Assert.Equal(
            new DateTimeOffset(2026, 7, 13, 0, 0, 0, TimeSpan.Zero),
            WeekService.WeekStart(wednesday));
    }

    [Fact]
    public void PreviousWeekId_steps_back_one_week()
    {
        var monday = new DateTimeOffset(2026, 7, 20, 0, 0, 0, TimeSpan.Zero);
        Assert.Equal("2026-W29", WeekService.PreviousWeekId(monday));
    }
}

public class VerifiedXpCalculatorTests
{
    [Fact]
    public void Base_lesson_earns_base_xp()
    {
        var xp = VerifiedXpCalculator.Compute(new LessonMetrics(10, 6, 4, 3));
        Assert.Equal(10, xp);
    }

    [Fact]
    public void Flawless_with_full_combo_earns_bonus()
    {
        // base 10 + flawless 5 + 2 combo tiers * 2 = 19 (mirrors mobile).
        var xp = VerifiedXpCalculator.Compute(new LessonMetrics(10, 10, 0, 10));
        Assert.Equal(19, xp);
    }

    [Theory]
    [InlineData(0, 0, 0, 0)]      // no exercises
    [InlineData(50, 10, 0, 5)]    // too many exercises
    [InlineData(10, 11, 2, 3)]    // correct > total
    [InlineData(10, 5, 2, 11)]    // combo > total
    [InlineData(10, 5, 0, 5)]     // "flawless" but not all correct first try
    public void Implausible_metrics_are_rejected(
        int total, int correct, int wrong, int combo)
    {
        Assert.Null(VerifiedXpCalculator.Compute(
            new LessonMetrics(total, correct, wrong, combo)));
    }

    [Fact]
    public void Result_never_exceeds_per_lesson_ceiling()
    {
        var xp = VerifiedXpCalculator.Compute(new LessonMetrics(40, 40, 0, 40));
        Assert.NotNull(xp);
        Assert.True(xp <= VerifiedXpCalculator.MaxPerLesson);
    }
}

public class CohortSettlementTests
{
    private static MemberStanding Member(string seed, int xp, LeagueTier tier = LeagueTier.Silver)
    {
        var bytes = new byte[16];
        seed.Select(c => (byte)c).ToArray().CopyTo(bytes, 0);
        return new MemberStanding(new Guid(bytes), xp, tier);
    }

    [Fact]
    public void Ranks_by_xp_and_applies_promotion_relegation()
    {
        var members = Enumerable.Range(0, 12)
            .Select(i => Member($"u{i:D2}", xp: i * 10))
            .ToList();

        var settled = CohortSettlement.Settle(members);

        Assert.Equal(12, settled.Count);
        // Highest XP is rank 1 and promoted.
        var first = settled.First(s => s.Rank == 1);
        Assert.Equal(members.Last().UserId, first.UserId);
        Assert.Equal(LeagueOutcome.Promoted, first.Outcome);
        Assert.Equal(LeagueTier.Gold, first.NextTier);
        // Bottom 5 relegated.
        Assert.All(settled.Where(s => s.Rank > 7),
            s => Assert.Equal(LeagueOutcome.Relegated, s.Outcome));
        // Middle stays.
        Assert.Equal(LeagueOutcome.Stayed, settled.Single(s => s.Rank == 6).Outcome);
    }

    [Fact]
    public void Bronze_cannot_relegate_and_diamond_cannot_promote()
    {
        var bronze = CohortSettlement.Settle(
            Enumerable.Range(0, 12)
                .Select(i => Member($"b{i:D2}", i, LeagueTier.Bronze)).ToList());
        Assert.All(bronze.Where(s => s.Outcome == LeagueOutcome.Relegated),
            s => Assert.Equal(LeagueTier.Bronze, s.NextTier));

        var diamond = CohortSettlement.Settle(
            Enumerable.Range(0, 12)
                .Select(i => Member($"d{i:D2}", i, LeagueTier.Diamond)).ToList());
        Assert.All(diamond.Where(s => s.Outcome == LeagueOutcome.Promoted),
            s => Assert.Equal(LeagueTier.Diamond, s.NextTier));
    }

    [Fact]
    public void Small_cohort_only_promotes()
    {
        // With <= PromoteCount members nobody should relegate.
        var settled = CohortSettlement.Settle(
            Enumerable.Range(0, 4).Select(i => Member($"s{i:D2}", i)).ToList());
        Assert.DoesNotContain(settled, s => s.Outcome == LeagueOutcome.Relegated);
    }

    [Fact]
    public void Ties_break_deterministically_by_user_id()
    {
        var a = Member("aa", 50);
        var z = Member("zz", 50);
        var settled = CohortSettlement.Settle([z, a]);
        Assert.Equal(a.UserId, settled.Single(s => s.Rank == 1).UserId);
    }
}
