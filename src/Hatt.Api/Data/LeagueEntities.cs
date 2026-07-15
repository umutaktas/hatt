namespace Hatt.Api.Data;

public enum WeekStatus
{
    Open = 0,
    Settled = 1,
}

public enum LeagueOutcome
{
    Stayed = 0,
    Promoted = 1,
    Relegated = 2,
}

/// <summary>A league week, Monday 00:00 UTC anchored (id like "2026-W29").</summary>
public class LeagueWeek
{
    public string Id { get; set; } = null!;
    public DateTimeOffset StartsAt { get; set; }
    public DateTimeOffset EndsAt { get; set; }
    public WeekStatus Status { get; set; } = WeekStatus.Open;
    public DateTimeOffset? SettledAt { get; set; }
}

/// <summary>
/// A 20–30 person competition group within a tier. Cohorts are created lazily
/// when a user earns their first verified XP of the week — mid-week joiners
/// enter immediately and inactive users never occupy slots.
/// </summary>
public class LeagueCohort
{
    public Guid Id { get; set; }
    public string WeekId { get; set; } = null!;
    public LeagueWeek Week { get; set; } = null!;
    public LeagueTier Tier { get; set; }
    public int MemberCount { get; set; }
}

public class LeagueMember
{
    public Guid CohortId { get; set; }
    public LeagueCohort Cohort { get; set; } = null!;
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    /// <summary>Denormalized for the one-cohort-per-week constraint.</summary>
    public string WeekId { get; set; } = null!;

    public int WeeklyXp { get; set; }
    public DateTimeOffset JoinedAt { get; set; }

    // Written once by the rollover job when the week settles.
    public int? FinalRank { get; set; }
    public LeagueOutcome? Outcome { get; set; }
}

/// <summary>
/// Auditable, idempotent XP ledger. League XP is only ever derived from these
/// events — never accepted as a client-provided total (server-authoritative).
/// </summary>
public class XpEvent
{
    public long Id { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string WeekId { get; set; } = null!;
    public string SourceType { get; set; } = "lesson_completion";
    public string IdempotencyKey { get; set; } = null!;
    public string? NodeId { get; set; }
    public int Amount { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}
