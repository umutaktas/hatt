namespace Hatt.Domain.Entities;

public enum LeagueWeekStatus
{
    Active = 0,
    Settling = 1,
    Settled = 2,
}

public enum LeagueOutcome
{
    Promoted = 0,
    Stayed = 1,
    Relegated = 2,
}

public class LeagueWeek
{
    public string Id { get; set; } = null!; // "2026-W29"
    public DateTimeOffset StartsAt { get; set; }
    public DateTimeOffset EndsAt { get; set; }
    public LeagueWeekStatus Status { get; set; } = LeagueWeekStatus.Active;
    public DateTimeOffset? SettledAt { get; set; }
}

public class LeagueCohort
{
    public Guid Id { get; set; }
    public string WeekId { get; set; } = null!;
    public LeagueWeek Week { get; set; } = null!;
    public LeagueTier Tier { get; set; }
    public int MemberCount { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}

public class LeagueMember
{
    public Guid CohortId { get; set; }
    public LeagueCohort Cohort { get; set; } = null!;
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string WeekId { get; set; } = null!;

    public int WeeklyXp { get; set; }
    public DateTimeOffset JoinedAt { get; set; }
    public DateTimeOffset LastXpAt { get; set; }

    public int? FinalRank { get; set; }
    public LeagueOutcome? Outcome { get; set; }
}

public class XpEvent
{
    public long Id { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string WeekId { get; set; } = null!;

    public string SourceType { get; set; } = null!;
    public string IdempotencyKey { get; set; } = null!;
    public string? NodeId { get; set; }

    public int Amount { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}
