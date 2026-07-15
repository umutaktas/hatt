/// Compile-time / runtime feature flags (CLAUDE.md §2, §9).
///
/// The backend (Firebase) and in-app purchases (RevenueCat) are gated so the
/// app boots and is fully usable offline. When [firebaseEnabled] is false the
/// League tab shows a "bağlantı yok" state and progress stays local-only.
class FeatureFlags {
  const FeatureFlags({
    this.firebaseEnabled = false,
    this.purchasesEnabled = false,
    this.localNotificationsEnabled = true,
  });

  /// Enable once `flutterfire configure` has produced firebase_options.dart and
  /// the guarded Firebase implementations are wired in (see
  /// lib/features/league/data/firestore_league_service.dart).
  final bool firebaseEnabled;

  /// Enable once RevenueCat products are configured. Paywall is visible either
  /// way; only the purchase call is gated.
  final bool purchasesEnabled;

  final bool localNotificationsEnabled;

  static const FeatureFlags defaults = FeatureFlags();
}
