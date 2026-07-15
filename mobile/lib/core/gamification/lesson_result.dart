/// Immutable summary of a completed lesson session, consumed by [XpCalculator]
/// and the lesson-completion UI. Pure data, no Flutter dependency.
class LessonResult {
  const LessonResult({
    required this.totalExercises,
    required this.correctFirstTry,
    required this.wrongAnswers,
    required this.longestCombo,
  });

  final int totalExercises;

  /// Exercises answered correctly on the first attempt.
  final int correctFirstTry;

  /// Total wrong answers across the session (each costs a heart).
  final int wrongAnswers;

  /// Longest run of consecutive correct answers.
  final int longestCombo;

  bool get isFlawless => wrongAnswers == 0 && totalExercises > 0;

  double get accuracy =>
      totalExercises == 0 ? 0 : correctFirstTry / totalExercises;
}
