/**
 * Week identification shared by the app and the backend (CLAUDE.md §4.3).
 *
 * A league week begins Monday 00:00 UTC. This MUST match the Dart
 * `LeagueLogic.weekId` in the mobile app so cohorts line up on both sides.
 */

/** ISO-8601 week key anchored to Monday 00:00 UTC, e.g. `2026-W29`. */
export function weekId(instant: Date): string {
  const utc = new Date(
    Date.UTC(
      instant.getUTCFullYear(),
      instant.getUTCMonth(),
      instant.getUTCDate()
    )
  );
  // JS getUTCDay: Sun=0..Sat=6 -> convert to Mon=1..Sun=7.
  const dayOfWeek = utc.getUTCDay() === 0 ? 7 : utc.getUTCDay();
  const monday = new Date(utc);
  monday.setUTCDate(utc.getUTCDate() - (dayOfWeek - 1));
  const thursday = new Date(monday);
  thursday.setUTCDate(monday.getUTCDate() + 3);
  const firstDay = new Date(Date.UTC(thursday.getUTCFullYear(), 0, 1));
  const week =
    1 +
    Math.floor(
      (thursday.getTime() - firstDay.getTime()) / (7 * 24 * 3600 * 1000)
    );
  return `${thursday.getUTCFullYear()}-W${String(week).padStart(2, "0")}`;
}

/** The week key for the week immediately before the one containing [instant]. */
export function previousWeekId(instant: Date): string {
  const sevenDaysAgo = new Date(instant.getTime() - 7 * 24 * 3600 * 1000);
  return weekId(sevenDaysAgo);
}
