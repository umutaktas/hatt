namespace Hatt.Domain.Entities;

public class UserIdentity
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public AuthProvider Provider { get; set; }
    public string Subject { get; set; } = null!;
    public string? PasswordHash { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}

public class UserProgressSnapshot
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public long Version { get; set; } = 1;
    public string DataJson { get; set; } = "{}";
    public DateTimeOffset ClientUpdatedAt { get; set; }
    public DateTimeOffset ServerUpdatedAt { get; set; }
}
