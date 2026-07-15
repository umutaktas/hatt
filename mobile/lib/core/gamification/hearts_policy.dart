/// Heart (can) regeneration and spending rules (CLAUDE.md §4.3).
///
/// 5 hearts max. A wrong answer costs one heart. Hearts regenerate one every
/// [regenInterval] (default 4 hours). Premium users have unlimited hearts, which
/// is expressed by [HeartsState.unlimited] so the UI never needs to special-case
/// entitlement here — the [EntitlementService] decides which state to build.
///
/// Pure Dart + injectable clock, so every branch is unit-testable without
/// waiting on wall-clock time.
class HeartsPolicy {
  const HeartsPolicy({
    this.maxHearts = 5,
    this.regenInterval = const Duration(hours: 4),
  });

  final int maxHearts;
  final Duration regenInterval;

  /// Applies elapsed-time regeneration to [state] as observed at [now].
  HeartsState regenerated(HeartsState state, DateTime now) {
    if (state.unlimited || state.current >= maxHearts) {
      return state.copyWith(nextRegenAt: null);
    }
    final anchor = state.nextRegenAt;
    if (anchor == null || now.isBefore(anchor)) {
      // No pending regen anchor yet, or not due — start/keep the timer.
      return state.copyWith(
        nextRegenAt: anchor ?? now.add(regenInterval),
      );
    }
    // How many full intervals have elapsed since the anchor became due.
    final elapsed = now.difference(anchor);
    final regenerated = 1 + elapsed.inMicroseconds ~/ regenInterval.inMicroseconds;
    final restored = (state.current + regenerated).clamp(0, maxHearts);
    if (restored >= maxHearts) {
      return state.copyWith(current: maxHearts, nextRegenAt: null);
    }
    // Carry the remainder forward so partial progress is not lost.
    final consumedIntervals = restored - state.current;
    final nextAnchor = anchor.add(regenInterval * consumedIntervals);
    return state.copyWith(current: restored, nextRegenAt: nextAnchor);
  }

  /// Spends one heart for a wrong answer. Unlimited hearts are untouched.
  HeartsState spendOne(HeartsState state, DateTime now) {
    if (state.unlimited || state.current <= 0) return state;
    final next = state.current - 1;
    // Starting to lose hearts kicks off the regen timer if it wasn't running.
    final anchor = state.nextRegenAt ?? now.add(regenInterval);
    return state.copyWith(current: next, nextRegenAt: anchor);
  }

  /// Refills to full (e.g. after completing a practice/review lesson).
  HeartsState refill(HeartsState state) =>
      state.copyWith(current: maxHearts, nextRegenAt: null);
}

class HeartsState {
  const HeartsState({
    required this.current,
    this.nextRegenAt,
    this.unlimited = false,
  });

  const HeartsState.full(int max)
      : current = max,
        nextRegenAt = null,
        unlimited = false;

  const HeartsState.premium()
      : current = 0,
        nextRegenAt = null,
        unlimited = true;

  final int current;

  /// When the next heart will regenerate; null when full or unlimited.
  final DateTime? nextRegenAt;
  final bool unlimited;

  bool get canPlay => unlimited || current > 0;

  HeartsState copyWith({
    int? current,
    Object? nextRegenAt = _sentinel,
    bool? unlimited,
  }) {
    return HeartsState(
      current: current ?? this.current,
      nextRegenAt: identical(nextRegenAt, _sentinel)
          ? this.nextRegenAt
          : nextRegenAt as DateTime?,
      unlimited: unlimited ?? this.unlimited,
    );
  }

  static const _sentinel = Object();
}
