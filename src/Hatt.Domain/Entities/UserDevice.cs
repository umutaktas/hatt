namespace Hatt.Domain.Entities;

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
