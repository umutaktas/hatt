import 'dart:math';

import 'exercise.dart';

/// A single learnable atom (a letter or a word) normalized so the builder can
/// treat both uniformly. `key` is the FSRS review key (`letter:be`, `word:kitap`).
class LearnItem {
  const LearnItem({
    required this.key,
    required this.ottoman,
    required this.gloss,
    required this.transliteration,
    required this.isLetter,
    this.similarGroup,
  });

  final String key;

  /// Ottoman script (letter isolated form or word).
  final String ottoman;

  /// Turkish side: word meaning, or the letter's Turkish name.
  final String gloss;

  /// Expected typed transliteration (word translit or letter sound value).
  final String transliteration;
  final bool isLetter;
  final String? similarGroup;
}

/// Builds a lesson's exercise list from its target items and a distractor pool
/// (CLAUDE.md §4.1: 8–12 egzersizlik oturum, §4.2 altı tip). Pure Dart with an
/// injected [Random] so ordering is testable/deterministic under a seeded RNG.
class ExerciseBuilder {
  const ExerciseBuilder({this.minExercises = 8, this.maxExercises = 12});

  final int minExercises;
  final int maxExercises;

  List<Exercise> build({
    required List<LearnItem> targets,
    required List<LearnItem> pool,
    required Random rng,
    bool includeMatch = true,
  }) {
    final exercises = <Exercise>[];
    if (targets.isEmpty) return exercises;

    // A matching round up front when we have enough distinct pairs.
    final wordTargets = targets.where((t) => !t.isLetter).toList();
    if (includeMatch && wordTargets.length >= 3) {
      exercises.add(_buildMatch(wordTargets, pool, rng));
    }

    // Cycle each target through a couple of kinds until we hit the cap.
    final ordered = [...targets]..shuffle(rng);
    for (final item in ordered) {
      final kinds = _kindsFor(item);
      for (final kind in kinds) {
        if (exercises.length >= maxExercises) break;
        exercises.add(_buildFor(kind, item, pool, rng));
      }
      if (exercises.length >= maxExercises) break;
    }

    // Ensure a minimum length by repeating varied kinds over targets.
    var i = 0;
    while (exercises.length < minExercises && ordered.isNotEmpty) {
      final item = ordered[i % ordered.length];
      final kinds = _kindsFor(item);
      exercises.add(_buildFor(kinds[i % kinds.length], item, pool, rng));
      i++;
    }
    return exercises;
  }

  List<ExerciseKind> _kindsFor(LearnItem item) {
    if (item.isLetter) {
      return [ExerciseKind.distinguishLetter, ExerciseKind.chooseMeaning];
    }
    return [
      ExerciseKind.chooseMeaning,
      ExerciseKind.typeTransliteration,
      ExerciseKind.chooseOttoman,
    ];
  }

  Exercise _buildFor(
    ExerciseKind kind,
    LearnItem item,
    List<LearnItem> pool,
    Random rng,
  ) {
    switch (kind) {
      case ExerciseKind.typeTransliteration:
        return TypingExercise(
          kind: ExerciseKind.typeTransliteration,
          reviewKeys: [item.key],
          promptOttoman: item.ottoman,
          expected: item.transliteration,
        );
      case ExerciseKind.chooseOttoman:
        final distractors = _pick(pool, item, 3, rng);
        final options = [item, ...distractors]..shuffle(rng);
        return ChoiceExercise(
          kind: ExerciseKind.chooseOttoman,
          reviewKeys: [item.key],
          prompt: item.gloss,
          promptIsOttoman: false,
          options: options
              .map((o) => ChoiceOption(text: o.ottoman, isOttoman: true))
              .toList(),
          correctIndex: options.indexOf(item),
        );
      case ExerciseKind.distinguishLetter:
        final group = pool
            .where((p) =>
                p.isLetter &&
                p.similarGroup != null &&
                p.similarGroup == item.similarGroup &&
                p.key != item.key,)
            .toList();
        final distractors = group.length >= 3
            ? (group..shuffle(rng)).take(3).toList()
            : _pick(pool.where((p) => p.isLetter).toList(), item, 3, rng);
        final options = [item, ...distractors]..shuffle(rng);
        return ChoiceExercise(
          kind: ExerciseKind.distinguishLetter,
          reviewKeys: [item.key],
          prompt: item.ottoman,
          promptIsOttoman: true,
          options: options
              .map((o) => ChoiceOption(text: o.transliteration, isOttoman: false))
              .toList(),
          correctIndex: options.indexOf(item),
        );
      case ExerciseKind.chooseMeaning:
      case ExerciseKind.matchPairs:
      case ExerciseKind.readLine:
        final distractors = _pick(pool, item, 3, rng);
        final options = [item, ...distractors]..shuffle(rng);
        return ChoiceExercise(
          kind: ExerciseKind.chooseMeaning,
          reviewKeys: [item.key],
          prompt: item.ottoman,
          promptIsOttoman: true,
          options: options
              .map((o) => ChoiceOption(text: o.gloss, isOttoman: false))
              .toList(),
          correctIndex: options.indexOf(item),
        );
    }
  }

  MatchExercise _buildMatch(
    List<LearnItem> wordTargets,
    List<LearnItem> pool,
    Random rng,
  ) {
    final chosen = ([...wordTargets]..shuffle(rng)).take(5).toList();
    final pairs = chosen
        .map((w) => MatchPair(ottoman: w.ottoman, tr: w.gloss, key: w.key))
        .toList();
    return MatchExercise(
      reviewKeys: chosen.map((w) => w.key).toList(),
      pairs: pairs,
    );
  }

  List<LearnItem> _pick(
    List<LearnItem> pool,
    LearnItem exclude,
    int n,
    Random rng,
  ) {
    final candidates = pool
        .where((p) => p.key != exclude.key && p.isLetter == exclude.isLetter)
        .toList()
      ..shuffle(rng);
    if (candidates.length < n) {
      // Fall back to the whole pool if the same-category set is too small.
      final extra = pool.where((p) => p.key != exclude.key).toList()
        ..shuffle(rng);
      for (final e in extra) {
        if (candidates.length >= n) break;
        if (!candidates.contains(e)) candidates.add(e);
      }
    }
    return candidates.take(n).toList();
  }
}
