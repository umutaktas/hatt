namespace Hatt.Domain.Entities;

public enum AccountType
{
    Anonymous = 0,
    Registered = 1,
}

public enum LeagueTier
{
    Bronze = 0,
    Silver = 1,
    Gold = 2,
    Platinum = 3,
    Diamond = 4,
}

public enum AuthProvider
{
    Email = 0,
    Apple = 1,
    Google = 2,
}

public class User
{
    public Guid Id { get; set; }
    public AccountType AccountType { get; set; } = AccountType.Anonymous;

    /// <summary>Self-chosen display name; the only user-provided field.</summary>
    public string? Nickname { get; set; }

    public LeagueTier CurrentTier { get; set; } = LeagueTier.Bronze;
    public DateTimeOffset CreatedAt { get; set; }

    public List<UserDevice> Devices { get; set; } = [];
    public List<RefreshSession> RefreshSessions { get; set; } = [];
    public List<UserIdentity> Identities { get; set; } = [];
    public UserProgressSnapshot? ProgressSnapshot { get; set; }
}
