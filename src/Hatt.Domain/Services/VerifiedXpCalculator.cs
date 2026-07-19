namespace Hatt.Domain.Services;

public record LessonMetrics(
    int TotalExercises,
    int CorrectFirstTry,
    int WrongAnswers,
    int LongestCombo);

/// <summary>
/// Server-side XP formula for verified league XP. Mirrors the mobile
/// XpCalculator's base rules but is authoritative: inputs are validated and
/// the result is bounded, and — deliberately — no premium multiplier (league
/// fairness; the mobile multiplier only affects local XP).
/// </summary>
public static class VerifiedXpCalculator
{
    public const int BaseXp = 10;
    public const int FlawlessBonus = 5;
    public const int ComboBonusPerTier = 2;
    public const int ExercisesPerComboTier = 5;

    /// <summary>Absolute per-lesson ceiling, whatever the inputs claim.</summary>
    public const int MaxPerLesson = 30;

    /// <summary>Daily verified-XP ceiling per user (damage limiting).</summary>
    public const int DailyCap = 400;

    /// <summary>
    /// Returns the verified XP for the lesson, or null when the metrics are
    /// not plausible (out of range / internally inconsistent).
    /// </summary>
    public static int? Compute(LessonMetrics m)
    {
        if (m.TotalExercises is < 1 or > 40) return null;
        if (m.CorrectFirstTry < 0 || m.CorrectFirstTry > m.TotalExercises) return null;
        if (m.WrongAnswers < 0 || m.WrongAnswers > 3 * m.TotalExercises) return null;
        if (m.LongestCombo < 0 || m.LongestCombo > m.TotalExercises) return null;
        // A flawless claim must be internally consistent.
        if (m.WrongAnswers == 0 && m.CorrectFirstTry != m.TotalExercises) return null;

        var xp = BaseXp;
        if (m.WrongAnswers == 0) xp += FlawlessBonus;
        xp += m.LongestCombo / ExercisesPerComboTier * ComboBonusPerTier;
        return Math.Min(xp, MaxPerLesson);
    }
}
