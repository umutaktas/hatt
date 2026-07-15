import '../domain/league_logic.dart';

/// One row on the weekly leaderboard.
class LeagueStanding {
  const LeagueStanding({
    required this.rank,
    required this.nickname,
    required this.weeklyXp,
    required this.isMe,
  });

  final int rank;
  final String nickname;
  final int weeklyXp;
  final bool isMe;
}

/// A snapshot of the caller's current league cohort.
class LeagueSnapshot {
  const LeagueSnapshot({
    required this.tier,
    required this.weekId,
    required this.weekEnd,
    required this.standings,
    required this.promoteCount,
    required this.relegateCount,
  });

  final LeagueTier tier;
  final String weekId;
  final DateTime weekEnd;
  final List<LeagueStanding> standings;
  final int promoteCount;
  final int relegateCount;
}

/// Backend-agnostic league API (CLAUDE.md §4.3, §5). Implemented offline by
/// [OfflineLeagueService] and (when [FeatureFlags.firebaseEnabled]) by the
/// Firestore-backed service. A `null` snapshot means "no connection / no
/// account" — the UI shows the "bağlantı yok" state.
abstract interface class LeagueService {
  Future<LeagueSnapshot?> currentSnapshot();

  /// Pushes the user's accumulated weekly XP to the backend (device → cloud,
  /// one-way; CLAUDE.md §2). No-op offline.
  Future<void> submitWeeklyXp(int weeklyXp);
}

/// Default implementation: the backend is disabled, so there is no league.
class OfflineLeagueService implements LeagueService {
  const OfflineLeagueService();

  @override
  Future<LeagueSnapshot?> currentSnapshot() async => null;

  @override
  Future<void> submitWeeklyXp(int weeklyXp) async {}
}
