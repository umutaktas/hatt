namespace Hatt.Domain.Entities;

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
