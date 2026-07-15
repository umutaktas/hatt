import '../domain/league_logic.dart';
import 'league_service.dart';

/// Firestore-backed league service (CLAUDE.md §5, Phase 5).
///
/// This is a GUARDED STUB. The real implementation depends on `firebase_core`,
/// `firebase_auth` and `cloud_firestore`, which are intentionally not in
/// pubspec.yaml so the app builds/runs fully offline (§2, §9). To activate:
///
///   1. Add the firebase packages and run `flutterfire configure`.
///   2. Uncomment the Firestore calls sketched below.
///   3. Flip [FeatureFlags.firebaseEnabled] to true; the provider will select
///      this service instead of [OfflineLeagueService].
///
/// Firestore layout (§5):
///   users/{uid}                                → { nickname, totalXp, streak, tier }
///   leagues/{weekId}/{cohortId}/members/{uid}  → { nickname, weeklyXp, tier }
///
/// The weekly rollover (promotion/relegation, new cohorts) runs in the Cloud
/// Function `rolloverLeagues` (see the backend repo), scheduled Monday 00:00 UTC.
class FirestoreLeagueService implements LeagueService {
  FirestoreLeagueService({this.logic = const LeagueLogic()});

  final LeagueLogic logic;

  @override
  Future<LeagueSnapshot?> currentSnapshot() async {
    // final uid = FirebaseAuth.instance.currentUser?.uid;
    // if (uid == null) return null;
    // final weekId = logic.weekId(DateTime.now().toUtc());
    // final cohortId = await _resolveCohort(uid, weekId);
    // final members = await FirebaseFirestore.instance
    //     .collection('leagues/$weekId/$cohortId/members')
    //     .orderBy('weeklyXp', descending: true)
    //     .get();
    // return _toSnapshot(uid, weekId, members);
    throw UnimplementedError(
        'Enable Firebase and wire FirestoreLeagueService (see class docs).',);
  }

  @override
  Future<void> submitWeeklyXp(int weeklyXp) async {
    // final uid = FirebaseAuth.instance.currentUser?.uid;
    // if (uid == null) return;
    // final weekId = logic.weekId(DateTime.now().toUtc());
    // Security rules validate: only own doc, serverTimestamp, weeklyXp within a
    // sane upper bound (§5).
    // await FirebaseFirestore.instance
    //     .doc('leagues/$weekId/${await _resolveCohort(uid, weekId)}/members/$uid')
    //     .set({'weeklyXp': weeklyXp, 'updatedAt': FieldValue.serverTimestamp()},
    //         SetOptions(merge: true));
    throw UnimplementedError('Enable Firebase to submit weekly XP.');
  }
}
