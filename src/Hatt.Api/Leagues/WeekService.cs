using System.Globalization;

namespace Hatt.Api.Leagues;

/// <summary>
/// Week identity, Monday 00:00 UTC anchored. MUST stay in lockstep with the
/// mobile app's Dart LeagueLogic.weekId so both sides name weeks identically.
/// </summary>
public static class WeekService
{
    /// <summary>ISO-8601 week key like "2026-W29" for the given instant.</summary>
    public static string WeekId(DateTimeOffset instant)
    {
        var utc = instant.UtcDateTime;
        var year = ISOWeek.GetYear(utc);
        var week = ISOWeek.GetWeekOfYear(utc);
        return $"{year}-W{week:D2}";
    }

    /// <summary>Monday 00:00 UTC of the week containing the instant.</summary>
    public static DateTimeOffset WeekStart(DateTimeOffset instant)
    {
        var date = instant.UtcDateTime.Date;
        var daysSinceMonday = ((int)date.DayOfWeek + 6) % 7; // Mon=0..Sun=6
        return new DateTimeOffset(date.AddDays(-daysSinceMonday), TimeSpan.Zero);
    }

    /// <summary>Next Monday 00:00 UTC — the instant the week ends.</summary>
    public static DateTimeOffset WeekEnd(DateTimeOffset instant) =>
        WeekStart(instant).AddDays(7);

    /// <summary>The week key immediately before the one containing the instant.</summary>
    public static string PreviousWeekId(DateTimeOffset instant) =>
        WeekId(instant.AddDays(-7));
}
