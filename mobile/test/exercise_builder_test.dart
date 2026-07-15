import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/features/lesson/domain/exercise.dart';
import 'package:hatt/features/lesson/domain/exercise_builder.dart';

void main() {
  const builder = ExerciseBuilder();

  List<LearnItem> words(int n) => List.generate(
        n,
        (i) => LearnItem(
          key: 'word:w$i',
          ottoman: 'او$i',
          gloss: 'anlam$i',
          transliteration: 'kelime$i',
          isLetter: false,
        ),
      );

  test('produces between min and max exercises', () {
    final pool = words(10);
    final ex = builder.build(
        targets: pool.take(4).toList(), pool: pool, rng: Random(1),);
    expect(ex.length, inInclusiveRange(8, 12));
  });

  test('every exercise carries at least one review key', () {
    final pool = words(8);
    final ex = builder.build(
        targets: pool.take(4).toList(), pool: pool, rng: Random(2),);
    expect(ex.every((e) => e.reviewKeys.isNotEmpty), isTrue);
  });

  test('choice exercises have a valid correct index within options', () {
    final pool = words(8);
    final ex = builder.build(
        targets: pool.take(4).toList(), pool: pool, rng: Random(3),);
    for (final e in ex.whereType<ChoiceExercise>()) {
      expect(e.correctIndex, inInclusiveRange(0, e.options.length - 1));
      expect(e.options.length, greaterThanOrEqualTo(2));
    }
  });

  test('a match exercise is included when enough word pairs exist', () {
    final pool = words(6);
    final ex = builder.build(
        targets: pool.take(5).toList(), pool: pool, rng: Random(4),);
    final match = ex.whereType<MatchExercise>();
    expect(match.length, 1);
    expect(match.first.pairs.length, inInclusiveRange(3, 5));
  });

  test('letter targets never yield a match exercise (includeMatch=false)', () {
    final letters = List.generate(
      4,
      (i) => LearnItem(
        key: 'letter:l$i',
        ottoman: 'ب',
        gloss: 'Be$i',
        transliteration: 'b$i',
        isLetter: true,
        similarGroup: 'g',
      ),
    );
    final ex = builder.build(
        targets: letters, pool: letters, rng: Random(5), includeMatch: false,);
    expect(ex.whereType<MatchExercise>(), isEmpty);
  });
}
