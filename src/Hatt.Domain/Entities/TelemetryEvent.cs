namespace Hatt.Domain.Entities;

public class TelemetryEvent
{
    public Guid Id { get; set; }
    public Guid? UserId { get; set; }
    public User? User { get; set; }

    public string EventName { get; set; } = null!;
    public string? PropertiesJson { get; set; }
    public DateTimeOffset Timestamp { get; set; }
}
