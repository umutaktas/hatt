import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/fsrs/fsrs.dart';
import '../../lesson/domain/exercise_builder.dart';

/// Persists FSRS memory state and produces the due queue that feeds dynamic
/// `review` nodes (CLAUDE.md §4.1, §5, Phase 4).
class ReviewRepository {
  ReviewRepository(this.db, {this.fsrs = const Fsrs()});

  final AppDatabase db;
  final Fsrs fsrs;

  /// Records the answer for [reviewKey] (`word:<id>` / `letter:<id>`) and
  /// reschedules it. Correct → good, wrong → again.
  Future<void> recordAnswer(
    String reviewKey, {
    required bool correct,
    required DateTime now,
  }) async {
    final parts = reviewKey.split(':');
    if (parts.length != 2) return;
    final type = parts.first;

    final existing = await (db.select(db.reviewStates)
          ..where((t) => t.itemKey.equals(reviewKey)))
        .getSingleOrNull();

    final card = existing == null
        ? const FsrsCard()
        : FsrsCard(
            stability: existing.stability,
            difficulty: existing.difficulty,
            due: existing.due,
            lastReview: existing.lastReview,
            reps: existing.reps,
            lapses: existing.lapses,
            phase: _phaseFrom(existing.phase),
          );

    final scheduled =
        fsrs.schedule(card, correct ? FsrsRating.good : FsrsRating.again, now);

    await db.into(db.reviewStates).insertOnConflictUpdate(
          ReviewStatesCompanion.insert(
            itemKey: reviewKey,
            itemType: type,
            stability: Value(scheduled.stability),
            difficulty: Value(scheduled.difficulty),
            due: Value(scheduled.due),
            lastReview: Value(scheduled.lastReview),
            reps: Value(scheduled.reps),
            lapses: Value(scheduled.lapses),
            phase: Value(scheduled.phase.name),
          ),
        );
  }

  /// Items whose review is due at [now], most overdue first. When the queue is
  /// empty, falls back to the weakest items (most lapses) then to unseen words,
  /// so a `review` node always has content (CLAUDE.md §4.1).
  Future<List<LearnItem>> dueItems({
    required DateTime now,
    int limit = 8,
  }) async {
    final due = await (db.select(db.reviewStates)
          ..where((t) => t.due.isSmallerOrEqualValue(now))
          ..orderBy([(t) => OrderingTerm.asc(t.due)])
          ..limit(limit))
        .get();

    final keys = due.map((e) => e.itemKey).toList();
    if (keys.length < limit) {
      // Top up with weakest reviewed items not already included.
      final weak = await (db.select(db.reviewStates)
            ..where((t) => t.itemKey.isNotIn(keys))
            ..orderBy([(t) => OrderingTerm.desc(t.lapses)])
            ..limit(limit - keys.length))
          .get();
      keys.addAll(weak.map((e) => e.itemKey));
    }

    final items = <LearnItem>[];
    for (final key in keys) {
      final item = await _learnItemForKey(key);
      if (item != null) items.add(item);
    }

    if (items.isEmpty) {
      // No FSRS history yet — practice the most frequent words.
      final words = await (db.select(db.words)
            ..orderBy([(t) => OrderingTerm.asc(t.frequencyRank)])
            ..limit(limit))
          .get();
      items.addAll(words.map(wordToItem));
    }
    return items;
  }

  Future<LearnItem?> _learnItemForKey(String key) async {
    final parts = key.split(':');
    if (parts.length != 2) return null;
    final id = parts[1];
    if (parts[0] == 'word') {
      final w = await (db.select(db.words)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      return w == null ? null : wordToItem(w);
    }
    final l = await (db.select(db.letters)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return l == null ? null : letterToItem(l);
  }

  static LearnItem wordToItem(WordRow w) => LearnItem(
        key: 'word:${w.id}',
        ottoman: w.ottoman,
        gloss: w.meaningTr,
        transliteration: w.transliteration,
        isLetter: false,
      );

  static LearnItem letterToItem(LetterRow l) => LearnItem(
        key: 'letter:${l.id}',
        ottoman: l.isolated,
        gloss: l.name,
        transliteration: l.soundValue,
        isLetter: true,
        similarGroup: l.similarGroup,
      );

  static FsrsPhase _phaseFrom(String s) =>
      FsrsPhase.values.firstWhere((p) => p.name == s,
          orElse: () => FsrsPhase.newCard,);
}
