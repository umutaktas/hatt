/// League tiers (Bronz → Elmas), 5 kademe (CLAUDE.md §4.3).
enum LeagueTier {
  bronze(0, 'Bronz'),
  silver(1, 'Gümüş'),
  gold(2, 'Altın'),
  platinum(3, 'Platin'),
  diamond(4, 'Elmas');

  const LeagueTier(this.rank, this.trName);
  final int rank;
  final String trName;

  LeagueTier get promoted =>
      rank >= diamond.rank ? diamond : LeagueTier.values[rank + 1];
  LeagueTier get relegated =>
      rank <= bronze.rank ? bronze : LeagueTier.values[rank - 1];
}

/// Outcome of a finished league week for a single member.
enum LeagueOutcome { promoted, stayed, relegated }

/// Pure league mechanics: week identification and weekly promotion/relegation.
///
/// A "week" begins Monday 00:00 UTC (CLAUDE.md §4.3: Cloud Function pazartesi
/// 00:00 UTC'de kümeleri yeniler). The same week key is produced on device and
/// in the Cloud Function so cohorts line up. Pure Dart, injected clock.
class LeagueLogic {
  const LeagueLogic({
    this.cohortSize = 25,
    this.promoteCount = 5,
    this.relegateCount = 5,
  });

  /// Target members per cohort (spec: 20–30).
  final int cohortSize;

  /// Top N ranks promote; bottom N relegate.
  final int promoteCount;
  final int relegateCount;

  /// Week key like `2026-W29`, anchored to Monday 00:00 UTC.
  String weekId(DateTime instant) {
    final utc = instant.toUtc();
    final midnight = DateTime.utc(utc.year, utc.month, utc.day);
    // Monday of this week (weekday: Mon=1..Sun=7).
    final monday = midnight.subtract(Duration(days: utc.weekday - 1));
    // ISO week number derived from the Thursday of the same week.
    final thursday = monday.add(const Duration(days: 3));
    final firstDay = DateTime.utc(thursday.year, 1, 1);
    final week = 1 + (thursday.difference(firstDay).inDays / 7).floor();
    return '${thursday.year}-W${week.toString().padLeft(2, '0')}';
  }

  /// The UTC instant the current league week ends (next Monday 00:00 UTC).
  DateTime weekEnd(DateTime instant) {
    final utc = instant.toUtc();
    final midnight = DateTime.utc(utc.year, utc.month, utc.day);
    final daysUntilNextMonday = (8 - utc.weekday) % 7;
    final delta = daysUntilNextMonday == 0 ? 7 : daysUntilNextMonday;
    return midnight.add(Duration(days: delta));
  }

  /// Ranks [members] by weekly XP (desc, stable) and assigns each an outcome.
  /// Returns entries in ranked order (rank 1 first).
  List<RankedMember> settleWeek(List<LeagueMember> members) {
    final sorted = [...members]
      ..sort((a, b) {
        final byXp = b.weeklyXp.compareTo(a.weeklyXp);
        if (byXp != 0) return byXp;
        return a.uid.compareTo(b.uid); // deterministic tie-break
      });
    final total = sorted.length;
    final result = <RankedMember>[];
    for (var i = 0; i < total; i++) {
      final rank = i + 1;
      final LeagueOutcome outcome;
      if (rank <= promoteCount) {
        outcome = LeagueOutcome.promoted;
      } else if (rank > total - relegateCount && total > promoteCount) {
        outcome = LeagueOutcome.relegated;
      } else {
        outcome = LeagueOutcome.stayed;
      }
      final member = sorted[i];
      final nextTier = switch (outcome) {
        LeagueOutcome.promoted => member.tier.promoted,
        LeagueOutcome.relegated => member.tier.relegated,
        LeagueOutcome.stayed => member.tier,
      };
      result.add(RankedMember(
        member: member,
        rank: rank,
        outcome: outcome,
        nextTier: nextTier,
      ),);
    }
    return result;
  }
}

class LeagueMember {
  const LeagueMember({
    required this.uid,
    required this.nickname,
    required this.weeklyXp,
    required this.tier,
  });

  final String uid;
  final String nickname;
  final int weeklyXp;
  final LeagueTier tier;
}

class RankedMember {
  const RankedMember({
    required this.member,
    required this.rank,
    required this.outcome,
    required this.nextTier,
  });

  final LeagueMember member;
  final int rank;
  final LeagueOutcome outcome;
  final LeagueTier nextTier;
}
