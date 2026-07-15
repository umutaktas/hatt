import 'dart:math';

import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../path/data/path_models.dart';
import '../../review/data/review_repository.dart';
import '../domain/exercise.dart';
import '../domain/exercise_builder.dart';

/// Turns a path node into a concrete list of exercises, pulling content and
/// distractors from the local DB (CLAUDE.md §4.1, §4.2).
class LessonRepository {
  LessonRepository(
    this.db,
    this.reviewRepo, {
    this.builder = const ExerciseBuilder(),
  });

  final AppDatabase db;
  final ReviewRepository reviewRepo;
  final ExerciseBuilder builder;

  Future<List<Exercise>> buildForNode(
    PathNode node, {
    Random? rng,
    DateTime? now,
  }) async {
    final random = rng ?? Random();
    switch (node.type) {
      case NodeType.letter:
        final targets = await _lettersByIds(node.contentRefs);
        final pool = (await _allLetters());
        return builder.build(
            targets: targets, pool: pool, rng: random, includeMatch: false,);
      case NodeType.vocab:
        final targets = await _wordsByIds(node.contentRefs);
        final pool = await _allWords();
        return builder.build(targets: targets, pool: pool, rng: random);
      case NodeType.reading:
        return _buildReading(node.contentRefs);
      case NodeType.review:
        final targets =
            await reviewRepo.dueItems(now: now ?? DateTime.now(), limit: 8);
        final pool = [...await _allWords(), ...await _allLetters()];
        return builder.build(targets: targets, pool: pool, rng: random);
      case NodeType.checkpoint:
        final letters = await _lettersByIds(node.contentRefs);
        final words = await _wordsByIds(node.contentRefs);
        final targets = [...letters, ...words]..shuffle(random);
        final pool = [...await _allWords(), ...await _allLetters()];
        return builder.build(
            targets: targets, pool: pool, rng: random, includeMatch: words.length >= 3,);
    }
  }

  Future<List<Exercise>> _buildReading(List<String> passageIds) async {
    final exercises = <Exercise>[];
    for (final pid in passageIds) {
      final lines = await (db.select(db.passageLines)
            ..where((t) => t.passageId.equals(pid))
            ..orderBy([(t) => OrderingTerm.asc(t.ordinal)]))
          .get();
      for (final line in lines) {
        exercises.add(TypingExercise(
          kind: ExerciseKind.readLine,
          reviewKeys: const [],
          promptOttoman: line.ottoman,
          expected: line.transliteration,
          simplifiedTr: line.simplifiedTr,
        ),);
      }
    }
    return exercises;
  }

  Future<void> logAnswer({
    required String? nodeId,
    required ExerciseKind kind,
    required bool correct,
    required DateTime now,
  }) async {
    await db.into(db.exerciseLog).insert(
          ExerciseLogCompanion.insert(
            nodeId: Value(nodeId),
            exerciseType: kind.name,
            correct: correct,
            timestamp: now,
          ),
        );
  }

  Future<List<LearnItem>> _lettersByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final rows = await (db.select(db.letters)..where((t) => t.id.isIn(ids))).get();
    final byId = {for (final r in rows) r.id: r};
    return ids
        .where(byId.containsKey)
        .map((id) => ReviewRepository.letterToItem(byId[id]!))
        .toList();
  }

  Future<List<LearnItem>> _wordsByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final rows = await (db.select(db.words)..where((t) => t.id.isIn(ids))).get();
    final byId = {for (final r in rows) r.id: r};
    return ids
        .where(byId.containsKey)
        .map((id) => ReviewRepository.wordToItem(byId[id]!))
        .toList();
  }

  Future<List<LearnItem>> _allLetters() async {
    final rows = await db.select(db.letters).get();
    return rows.map(ReviewRepository.letterToItem).toList();
  }

  Future<List<LearnItem>> _allWords() async {
    final rows = await db.select(db.words).get();
    return rows.map(ReviewRepository.wordToItem).toList();
  }
}
