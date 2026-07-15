import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/features/league/domain/league_logic.dart';

void main() {
  const logic = LeagueLogic(promoteCount: 2, relegateCount: 2);

  test('weekId is stable across a Monday-anchored week (UTC)', () {
    final mon = DateTime.utc(2026, 7, 13, 0, 0); // Monday
    final sun = DateTime.utc(2026, 7, 19, 23, 59); // Sunday same week
    final nextMon = DateTime.utc(2026, 7, 20, 0, 0);
    expect(logic.weekId(mon), logic.weekId(sun));
    expect(logic.weekId(mon), isNot(logic.weekId(nextMon)));
  });

  test('weekEnd is the next Monday 00:00 UTC', () {
    final wed = DateTime.utc(2026, 7, 15, 10);
    expect(logic.weekEnd(wed), DateTime.utc(2026, 7, 20, 0, 0));
  });

  test('settleWeek ranks by xp and assigns promotion/relegation', () {
    final members = [
      const LeagueMember(uid: 'a', nickname: 'A', weeklyXp: 50, tier: LeagueTier.silver),
      const LeagueMember(uid: 'b', nickname: 'B', weeklyXp: 90, tier: LeagueTier.silver),
      const LeagueMember(uid: 'c', nickname: 'C', weeklyXp: 70, tier: LeagueTier.silver),
      const LeagueMember(uid: 'd', nickname: 'D', weeklyXp: 10, tier: LeagueTier.silver),
      const LeagueMember(uid: 'e', nickname: 'E', weeklyXp: 30, tier: LeagueTier.silver),
    ];
    final ranked = logic.settleWeek(members);
    expect(ranked.map((r) => r.member.uid).toList(), ['b', 'c', 'a', 'e', 'd']);
    expect(ranked[0].outcome, LeagueOutcome.promoted);
    expect(ranked[1].outcome, LeagueOutcome.promoted);
    expect(ranked[0].nextTier, LeagueTier.gold);
    expect(ranked[2].outcome, LeagueOutcome.stayed);
    expect(ranked[3].outcome, LeagueOutcome.relegated);
    expect(ranked[4].outcome, LeagueOutcome.relegated);
    expect(ranked[4].nextTier, LeagueTier.bronze);
  });

  test('tie-break is deterministic by uid', () {
    final members = [
      const LeagueMember(uid: 'z', nickname: 'Z', weeklyXp: 40, tier: LeagueTier.bronze),
      const LeagueMember(uid: 'a', nickname: 'A', weeklyXp: 40, tier: LeagueTier.bronze),
    ];
    final ranked = logic.settleWeek(members);
    expect(ranked.first.member.uid, 'a');
  });

  test('bronze never relegates below bronze, diamond never promotes above', () {
    expect(LeagueTier.bronze.relegated, LeagueTier.bronze);
    expect(LeagueTier.diamond.promoted, LeagueTier.diamond);
  });
}
