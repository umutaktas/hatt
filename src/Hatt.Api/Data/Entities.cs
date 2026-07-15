namespace Hatt.Api.Data;

/// <summary>
/// Account lifecycle: anonymous by default (KVKK: no personal data), upgraded
/// to registered via account linking (P2).
/// </summary>
public enum AccountType
{
    Anonymous = 0,
    Registered = 1,
}

/// <summary>League tiers, Bronz → Elmas (5 kademe).</summary>
public enum LeagueTier
{
    Bronze = 0,
    Silver = 1,
    Gold = 2,
    Platinum = 3,
    Diamond = 4,
}

public class User
{
    public Guid Id { get; set; }
    public AccountType AccountType { get; set; } = AccountType.Anonymous;

    /// <summary>Self-chosen display name; the only user-provided field (§5).</summary>
    public string? Nickname { get; set; }

    public LeagueTier CurrentTier { get; set; } = LeagueTier.Bronze;
    public DateTimeOffset CreatedAt { get; set; }

    public List<UserDevice> Devices { get; set; } = [];
    public List<RefreshSession> RefreshSessions { get; set; } = [];
}

/// <summary>
/// A device installation. The client generates a random installation id and
/// stores it in secure storage; only its SHA-256 hash is persisted here.
/// </summary>
public class UserDevice
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public string InstallationIdHash { get; set; } = null!;
    public string? Platform { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset LastSeenAt { get; set; }
    public DateTimeOffset? RevokedAt { get; set; }
}

/// <summary>
/// Rotating refresh token session. Only the token hash is stored. When a token
/// that was already replaced is presented again (reuse), the whole family is
/// revoked (stolen-token defence).
/// </summary>
public class RefreshSession
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid DeviceId { get; set; }
    public UserDevice Device { get; set; } = null!;

    public string TokenHash { get; set; } = null!;
    public Guid TokenFamilyId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset ExpiresAt { get; set; }
    public Guid? ReplacedById { get; set; }
    public DateTimeOffset? RevokedAt { get; set; }

    public bool IsActive(DateTimeOffset now) =>
        RevokedAt is null && ReplacedById is null && ExpiresAt > now;
}
