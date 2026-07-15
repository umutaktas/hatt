import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/core/gamification/hearts_policy.dart';
import 'package:hatt/core/gamification/lesson_result.dart';
import 'package:hatt/core/gamification/level_system.dart';
import 'package:hatt/core/gamification/streak_policy.dart';
import 'package:hatt/core/gamification/xp_calculator.dart';

void main() {
  group('XpCalculator', () {
    const calc = XpCalculator();

    test('base only for a lesson with mistakes and no combo', () {
      const r = LessonResult(
        totalExercises: 10,
        correctFirstTry: 6,
        wrongAnswers: 4,
        longestCombo: 3,
      );
      expect(calc.compute(r), 10);
    });

    test('adds flawless bonus and combo tiers', () {
      const r = LessonResult(
        totalExercises: 10,
        correctFirstTry: 10,
        wrongAnswers: 0,
        longestCombo: 10,
      );
      // base 10 + flawless 5 + 2 combo tiers * 2 = 19
      expect(calc.compute(r), 19);
    });

    test('applies premium multiplier', () {
      const r = LessonResult(
        totalExercises: 5,
        correctFirstTry: 5,
        wrongAnswers: 0,
        longestCombo: 5,
      );
      // base 10 + flawless 5 + 1 tier*2 = 17 -> *1.5 = 25.5 -> 26
      expect(calc.compute(r, multiplier: 1.5), 26);
    });
  });

  group('HeartsPolicy', () {
    const policy = HeartsPolicy();
    final t0 = DateTime.utc(2026, 1, 1, 12);

    test('spending a heart starts the regen timer', () {
      const full = HeartsState.full(5);
      final after = policy.spendOne(full, t0);
      expect(after.current, 4);
      expect(after.nextRegenAt, t0.add(const Duration(hours: 4)));
    });

    test('regenerates one heart per interval and carries remainder', () {
      final s = policy.spendOne(policy.spendOne(const HeartsState.full(5), t0), t0);
      // 3 hearts, next regen at t0+4h.
      final later = policy.regenerated(s, t0.add(const Duration(hours: 5)));
      expect(later.current, 4);
      expect(later.nextRegenAt, t0.add(const Duration(hours: 8)));
    });

    test('caps at max and clears timer', () {
      var s = const HeartsState(current: 1);
      s = policy.spendOne(s, t0); // 0 hearts, timer at +4h
      final full = policy.regenerated(s, t0.add(const Duration(hours: 40)));
      expect(full.current, 5);
      expect(full.nextRegenAt, isNull);
    });

    test('premium hearts are unlimited and never spent', () {
      const p = HeartsState.premium();
      expect(policy.spendOne(p, t0).current, 0);
      expect(policy.spendOne(p, t0).unlimited, isTrue);
      expect(p.canPlay, isTrue);
    });
  });

  group('LevelSystem', () {
    const levels = LevelSystem();

    test('thresholds are increasing', () {
      expect(levels.xpForLevel(1), 0);
      expect(levels.xpForLevel(2), 100);
      expect(levels.xpForLevel(3), 300);
      expect(levels.xpForLevel(4), 600);
    });

    test('maps xp to level', () {
      expect(levels.levelForXp(0), 1);
      expect(levels.levelForXp(99), 1);
      expect(levels.levelForXp(100), 2);
      expect(levels.levelForXp(299), 2);
      expect(levels.levelForXp(600), 4);
    });

    test('progress within level is bounded', () {
      expect(levels.progressWithinLevel(100), 0);
      expect(levels.progressWithinLevel(200), closeTo(0.5, 1e-9));
      expect(levels.xpToNextLevel(100), 200);
    });
  });

  group('StreakPolicy', () {
    const policy = StreakPolicy();
    final mon = DateTime(2026, 7, 13); // a Monday

    test('first activity sets streak to 1', () {
      final s = policy.registerActivity(const StreakState(), mon);
      expect(s.current, 1);
      expect(s.longest, 1);
    });

    test('consecutive days increment', () {
      var s = policy.registerActivity(const StreakState(), mon);
      s = policy.registerActivity(s, mon.add(const Duration(days: 1)));
      expect(s.current, 2);
      expect(s.longest, 2);
    });

    test('same day is idempotent', () {
      var s = policy.registerActivity(const StreakState(), mon);
      s = policy.registerActivity(s, mon.add(const Duration(hours: 6)));
      expect(s.current, 1);
    });

    test('one missed day breaks streak without a freeze', () {
      var s = policy.registerActivity(const StreakState(), mon);
      s = policy.registerActivity(s, mon.add(const Duration(days: 2)));
      expect(s.current, 1);
    });

    test('a freeze covers a single missed day', () {
      var s = policy.registerActivity(const StreakState(freezes: 1), mon);
      s = policy.registerActivity(s, mon.add(const Duration(days: 2)));
      expect(s.current, 2);
      expect(s.freezes, 0);
    });

    test('weekly freeze grant respects cap and week key', () {
      var s = const StreakState();
      s = policy.grantWeeklyFreeze(s, mon);
      expect(s.freezes, 1);
      // same week: no additional grant
      s = policy.grantWeeklyFreeze(s, mon.add(const Duration(days: 1)));
      expect(s.freezes, 1);
      // next week: grant again but free cap keeps it at 1
      s = policy.grantWeeklyFreeze(s, mon.add(const Duration(days: 8)));
      expect(s.freezes, 1);
    });
  });
}
