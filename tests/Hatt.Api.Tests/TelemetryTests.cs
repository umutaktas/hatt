using Hatt.Domain.Services;

namespace Hatt.Api.Tests;

public class TelemetryTests
{
    [Theory]
    [InlineData("app_launch")]
    [InlineData("lesson_started")]
    [InlineData("lesson_completed")]
    [InlineData("review_session_completed")]
    [InlineData("streak_milestone")]
    [InlineData("paywall_viewed")]
    [InlineData("account_linked")]
    public void Allowed_telemetry_events_are_accepted(string eventName)
    {
        Assert.True(TelemetryValidator.IsAllowed(eventName));
    }

    [Theory]
    [InlineData("custom_unauthorized_event")]
    [InlineData("user_password_entered")]
    [InlineData("pii_data")]
    [InlineData("")]
    [InlineData(null)]
    public void Disallowed_telemetry_events_are_rejected(string? eventName)
    {
        Assert.False(TelemetryValidator.IsAllowed(eventName!));
    }
}
