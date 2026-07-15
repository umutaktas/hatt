import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/paywall/domain/entitlement_service.dart';
import '../../features/profile/data/user_repository.dart';
import '../audio/sound_service.dart';
import '../config/feature_flags.dart';
import '../db/database.dart';

/// The Drift database. Overridden in tests with [AppDatabase.forTesting].
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final featureFlagsProvider = Provider<FeatureFlags>(
  (ref) => FeatureFlags.defaults,
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(ref.watch(databaseProvider)),
);

final soundServiceProvider = Provider<SoundService>((ref) {
  final service = SoundService();
  ref.onDispose(service.dispose);
  return service;
});

/// Streams the singleton user_state row.
final userStateProvider = StreamProvider<UserStateRow>((ref) {
  return ref.watch(databaseProvider).watchUserState();
});

/// Entitlement derived from the persisted premium flag. Wraps
/// [LocalEntitlementService]; persists changes back to the DB.
final entitlementProvider = Provider<EntitlementService>((ref) {
  final db = ref.watch(databaseProvider);
  final flags = ref.watch(featureFlagsProvider);
  final premium =
      ref.watch(userStateProvider).value?.premium ?? false;
  final service = LocalEntitlementService(
    premium: premium,
    flags: flags,
    onChanged: (value) =>
        db.updateUserState(UserStateTableCompanion(premium: Value(value))),
  );
  // Keep the sound service in sync with the user's toggle.
  final soundEnabled = ref.watch(userStateProvider).value?.soundEnabled ?? true;
  ref.watch(soundServiceProvider).enabled = soundEnabled;
  return service;
});
