import '../../../core/config/feature_flags.dart';

/// Single source of truth for the free/premium split (CLAUDE.md §6). Every
/// gated feature checks here; UI shows lock icons based on [isPremium].
///
/// The real implementation is backed by RevenueCat (behind
/// [FeatureFlags.purchasesEnabled]). This offline default reads the locally
/// persisted premium flag so the app is fully functional without the store.
abstract interface class EntitlementService {
  bool get isPremium;

  /// Unlimited hearts (§6).
  bool get unlimitedHearts;

  /// Unlimited streak freezes (§6).
  bool get unlimitedStreakFreezes;

  /// Access to the weak-point analysis screen (§6).
  bool get weakPointAnalysis;

  /// Launches the purchase flow. No-op when [FeatureFlags.purchasesEnabled] is
  /// false; returns whether premium is now active.
  Future<bool> purchasePremium();

  /// For local testing / restore. Persisted by the caller.
  Future<void> setPremium(bool value);
}

/// Local, store-free entitlement used when purchases are disabled. Premium can
/// still be toggled (e.g. debug menu, restore) and is persisted by the caller.
class LocalEntitlementService implements EntitlementService {
  LocalEntitlementService({
    bool premium = false,
    this.flags = FeatureFlags.defaults,
    this.onChanged,
  }) : _premium = premium;

  bool _premium;
  final FeatureFlags flags;
  final Future<void> Function(bool premium)? onChanged;

  @override
  bool get isPremium => _premium;

  @override
  bool get unlimitedHearts => _premium;

  @override
  bool get unlimitedStreakFreezes => _premium;

  @override
  bool get weakPointAnalysis => _premium;

  @override
  Future<bool> purchasePremium() async {
    if (!flags.purchasesEnabled) {
      // Purchases disabled: paywall is a skeleton (§2). Nothing to buy yet.
      return _premium;
    }
    // TODO(revenuecat): call Purchases.purchasePackage(...) here.
    await setPremium(true);
    return _premium;
  }

  @override
  Future<void> setPremium(bool value) async {
    _premium = value;
    await onChanged?.call(value);
  }
}
