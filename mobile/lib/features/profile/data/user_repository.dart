import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import '../../../core/gamification/hearts_policy.dart';
import '../../../core/gamification/level_system.dart';
import '../../../core/gamification/streak_policy.dart';

/// Reads and mutates the singleton user_state row by applying the pure
/// gamification policies (CLAUDE.md §4.3). All wall-clock time is injected.
class UserRepository {
  UserRepository(
    this.db, {
    this.hearts = const HeartsPolicy(),
    this.streaks = const StreakPolicy(),
    this.levels = const LevelSystem(),
  });

  final AppDatabase db;
  final HeartsPolicy hearts;
  final StreakPolicy streaks;
  final LevelSystem levels;

  Future<UserStateRow> current() => db.userState();

  HeartsState _heartsStateOf(UserStateRow row) => HeartsState(
        current: row.hearts,
        nextRegenAt: row.heartsNextRegen,
        unlimited: row.premium,
      );

  /// Applies elapsed-time heart regeneration and persists if it changed.
  Future<HeartsState> regenHearts(DateTime now) async {
    final row = await current();
    final state = _heartsStateOf(row);
    final next = hearts.regenerated(state, now);
    if (next.current != state.current || next.nextRegenAt != state.nextRegenAt) {
      await db.updateUserState(UserStateTableCompanion(
        hearts: Value(next.current),
        heartsNextRegen: Value(next.nextRegenAt),
      ),);
    }
    return next;
  }

  /// Spends one heart on a wrong answer; returns the new hearts state.
  Future<HeartsState> spendHeart(DateTime now) async {
    final row = await current();
    final next = hearts.spendOne(_heartsStateOf(row), now);
    await db.updateUserState(UserStateTableCompanion(
      hearts: Value(next.current),
      heartsNextRegen: Value(next.nextRegenAt),
    ),);
    return next;
  }

  /// Refills hearts to full — used after a review/practice lesson (§4.3).
  Future<void> refillHearts() async {
    final row = await current();
    final next = hearts.refill(_heartsStateOf(row));
    await db.updateUserState(UserStateTableCompanion(
      hearts: Value(next.current),
      heartsNextRegen: Value(next.nextRegenAt),
    ),);
  }

  /// Applies XP + streak progression at lesson completion. Returns whether the
  /// user leveled up.
  Future<CompletionOutcome> applyCompletion({
    required int xpGained,
    required DateTime now,
  }) async {
    final row = await current();
    final newXp = row.xp + xpGained;
    final oldLevel = levels.levelForXp(row.xp);
    final newLevel = levels.levelForXp(newXp);

    var streak = StreakState(
      current: row.streakCurrent,
      longest: row.streakLongest,
      freezes: row.streakFreezes,
      lastActiveDay: row.lastActiveDay,
      lastFreezeGrantWeek: row.lastFreezeWeek,
    );
    streak = streaks.grantWeeklyFreeze(streak, now, premium: row.premium);
    streak = streaks.registerActivity(streak, now);

    await db.updateUserState(UserStateTableCompanion(
      xp: Value(newXp),
      level: Value(newLevel),
      streakCurrent: Value(streak.current),
      streakLongest: Value(streak.longest),
      streakFreezes: Value(streak.freezes),
      lastActiveDay: Value(streak.lastActiveDay),
      lastFreezeWeek: Value(streak.lastFreezeGrantWeek),
    ),);

    return CompletionOutcome(
      leveledUp: newLevel > oldLevel,
      newLevel: newLevel,
      streak: streak.current,
    );
  }

  Future<void> setSoundEnabled(bool value) =>
      db.updateUserState(UserStateTableCompanion(soundEnabled: Value(value)));

  Future<void> setShowHarakat(bool value) =>
      db.updateUserState(UserStateTableCompanion(showHarakat: Value(value)));

  Future<void> setNickname(String value) =>
      db.updateUserState(UserStateTableCompanion(nickname: Value(value)));

  Future<void> setPremium(bool value) =>
      db.updateUserState(UserStateTableCompanion(premium: Value(value)));

  Future<void> setOnboarded(bool value) =>
      db.updateUserState(UserStateTableCompanion(onboarded: Value(value)));

  /// Full local data wipe for "hesabımı ve verilerimi sil" (CLAUDE.md §2, §6).
  /// Content tables are left intact (re-seeded on next launch); all progress and
  /// personal fields are cleared.
  Future<void> deleteAllUserData() async {
    await db.transaction(() async {
      await db.delete(db.reviewStates).go();
      await db.delete(db.exerciseLog).go();

      // Reset path progress to the initial lock state: everything locked except
      // the first node by ordinal (mirrors the seed).
      await db.delete(db.nodeProgress).go();
      final ordered = await (db.select(db.curriculumNodes)
            ..orderBy([(t) => OrderingTerm.asc(t.ordinal)]))
          .get();
      for (var i = 0; i < ordered.length; i++) {
        await db.into(db.nodeProgress).insert(
              NodeProgressCompanion.insert(
                nodeId: ordered[i].id,
                status: i == 0 ? 'available' : 'locked',
              ),
            );
      }

      // Reset the user_state singleton to defaults.
      await db.updateUserState(const UserStateTableCompanion(
        hearts: Value(5),
        heartsNextRegen: Value(null),
        xp: Value(0),
        level: Value(1),
        streakCurrent: Value(0),
        streakLongest: Value(0),
        streakFreezes: Value(0),
        lastActiveDay: Value(null),
        lastFreezeWeek: Value(null),
        premium: Value(false),
        onboarded: Value(false),
        nickname: Value(null),
      ),);
    });
  }
}

class CompletionOutcome {
  const CompletionOutcome({
    required this.leveledUp,
    required this.newLevel,
    required this.streak,
  });

  final bool leveledUp;
  final int newLevel;
  final int streak;
}
