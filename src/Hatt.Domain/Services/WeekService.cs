using System.Globalization;

namespace Hatt.Domain.Services;

public static class WeekService
{
    public static DateTimeOffset WeekStart(DateTimeOffset timestamp)
    {
        var utc = timestamp.UtcDateTime;
        var diff = (7 + (utc.DayOfWeek - DayOfWeek.Monday)) % 7;
        var monday = utc.Date.AddDays(-diff);
        return new DateTimeOffset(monday, TimeSpan.Zero);
    }

    public static DateTimeOffset WeekEnd(DateTimeOffset timestamp) =>
        WeekStart(timestamp).AddDays(7);

    public static string WeekId(DateTimeOffset timestamp)
    {
        var start = WeekStart(timestamp);
        var weekNum = ISOWeek.GetWeekOfYear(start.DateTime);
        var year = ISOWeek.GetYear(start.DateTime);
        return $"{year}-W{weekNum:D2}";
    }

    public static string PreviousWeekId(DateTimeOffset timestamp) =>
        WeekId(WeekStart(timestamp).AddDays(-7));
}
