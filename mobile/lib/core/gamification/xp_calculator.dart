import 'lesson_result.dart';

/// Pure XP computation for a finished lesson (CLAUDE.md §4.3).
///
/// Base reward is 10 XP. A flawless lesson (no wrong answers) grants a bonus,
/// and a combo bonus rewards long streaks of correct answers within the
/// session. Premium users optionally earn a configurable multiplier — kept here
/// so the rule is testable independent of the entitlement layer.
class XpCalculator {
  const XpCalculator({
    this.baseXp = 10,
    this.flawlessBonus = 5,
    this.comboBonusPerTier = 2,
    this.exercisesPerComboTier = 5,
  });

  final int baseXp;
  final int flawlessBonus;

  /// Extra XP granted for every [exercisesPerComboTier] answers in the longest
  /// unbroken correct streak of the session.
  final int comboBonusPerTier;
  final int exercisesPerComboTier;

  int compute(LessonResult result, {double multiplier = 1.0}) {
    if (result.totalExercises <= 0) return 0;
    var xp = baseXp;
    if (result.isFlawless) xp += flawlessBonus;
    xp += (result.longestCombo ~/ exercisesPerComboTier) * comboBonusPerTier;
    return (xp * multiplier).round();
  }
}
