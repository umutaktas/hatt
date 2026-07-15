/// The MVP exercise set (CLAUDE.md §4.2). Each concrete [Exercise] carries the
/// FSRS review keys (`word:<id>` / `letter:<id>`) it exercises so the lesson
/// controller can schedule spaced repetition after grading.
library;

enum ExerciseKind {
  /// 1. Osmanlıca → Türkçe çoktan seçmeli
  chooseMeaning,

  /// 2. Türkçe → Osmanlıca çoktan seçmeli
  chooseOttoman,

  /// 3. Benzer harf ayrımı (ب/ت/ث)
  distinguishLetter,

  /// 4. Serbest transliterasyon yazma
  typeTransliteration,

  /// 5. Eşleştirme (5 çift)
  matchPairs,

  /// 6. Satır okuma → transliterasyon yaz
  readLine,
}

sealed class Exercise {
  const Exercise({required this.kind, required this.reviewKeys});

  final ExerciseKind kind;
  final List<String> reviewKeys;
}

class ChoiceOption {
  const ChoiceOption({required this.text, required this.isOttoman});
  final String text;
  final bool isOttoman;
}

/// Covers kinds 1, 2 and 3 (single-correct multiple choice).
class ChoiceExercise extends Exercise {
  const ChoiceExercise({
    required super.kind,
    required super.reviewKeys,
    required this.prompt,
    required this.promptIsOttoman,
    required this.options,
    required this.correctIndex,
  });

  /// The stem shown to the learner (Ottoman or Turkish depending on kind).
  final String prompt;
  final bool promptIsOttoman;
  final List<ChoiceOption> options;
  final int correctIndex;
}

class MatchPair {
  const MatchPair({required this.ottoman, required this.tr, required this.key});
  final String ottoman;
  final String tr;
  final String key;
}

/// Kind 5 — match 5 Ottoman ↔ Turkish pairs.
class MatchExercise extends Exercise {
  const MatchExercise({required super.reviewKeys, required this.pairs})
      : super(kind: ExerciseKind.matchPairs);

  final List<MatchPair> pairs;
}

/// Kinds 4 and 6 — type the transliteration of an Ottoman prompt/line.
class TypingExercise extends Exercise {
  const TypingExercise({
    required super.kind,
    required super.reviewKeys,
    required this.promptOttoman,
    required this.expected,
    this.simplifiedTr,
  });

  final String promptOttoman;
  final String expected;

  /// For [ExerciseKind.readLine]: the modern-Turkish gloss shown after answering.
  final String? simplifiedTr;
}
