namespace Hatt.Domain.Services;

public static class TelemetryValidator
{
    public static readonly HashSet<string> AllowedEvents = new(StringComparer.OrdinalIgnoreCase)
    {
        "app_launch",
        "lesson_started",
        "lesson_completed",
        "review_session_completed",
        "streak_milestone",
        "paywall_viewed",
        "account_linked",
    };

    public static bool IsAllowed(string eventName) =>
        !string.IsNullOrWhiteSpace(eventName) && AllowedEvents.Contains(eventName.Trim());
}
