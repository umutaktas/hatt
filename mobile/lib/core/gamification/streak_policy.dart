/// Daily streak logic with freeze ("seri dondurucu") protection
/// (CLAUDE.md §4.3). Free users get 1 freeze per week; Premium unlimited.
///
/// Days are compared at date granularity (local calendar day). Pure Dart with
/// injected "today" so it is fully unit-testable.
class StreakPolicy {
  const StreakPolicy();

  /// Registers activity on [today] given the prior [state]. Returns the updated
  /// state. Multiple activities on the same day are idempotent.
  StreakState registerActivity(StreakState state, DateTime today) {
    final t = _dateOnly(today);
    final last = state.lastActiveDay == null ? null : _dateOnly(state.lastActiveDay!);
    if (last == null) {
      return state.copyWith(current: 1, longest: _max(state.longest, 1), lastActiveDay: t);
    }
    final gap = t.difference(last).inDays;
    if (gap <= 0) return state; // same day (or clock skew) — no change
    if (gap == 1) {
      final next = state.current + 1;
      return state.copyWith(current: next, longest: _max(state.longest, next), lastActiveDay: t);
    }
    // gap >= 2: a full day (or more) was missed while inactive.
    final missed = gap - 1;
    if (state.freezes >= missed && missed <= 1) {
      // A single missed day can be covered by one freeze, preserving the streak.
      final next = state.current + 1;
      return state.copyWith(
        current: next,
        longest: _max(state.longest, next),
        lastActiveDay: t,
        freezes: state.freezes - missed,
      );
    }
    // Streak broken.
    return state.copyWith(current: 1, longest: _max(state.longest, 1), lastActiveDay: t);
  }

  /// Grants the weekly free freeze if the user is below the cap and a new ISO
  /// week has started since [state.lastFreezeGrantWeek].
  StreakState grantWeeklyFreeze(
    StreakState state,
    DateTime today, {
    int freeCap = 1,
    bool premium = false,
  }) {
    final week = _isoWeekKey(today);
    if (state.lastFreezeGrantWeek == week) return state;
    final cap = premium ? 7 : freeCap;
    final granted = (state.freezes + 1).clamp(0, cap);
    return state.copyWith(freezes: granted, lastFreezeGrantWeek: week);
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
  static int _max(int a, int b) => a > b ? a : b;

  /// ISO-8601 week key "YYYY-Www". Shared with league week rollover.
  static String _isoWeekKey(DateTime date) {
    final d = _dateOnly(date);
    final dayOfWeek = d.weekday; // Mon=1..Sun=7
    final thursday = d.add(Duration(days: 4 - dayOfWeek));
    final firstDay = DateTime(thursday.year, 1, 1);
    final week = 1 + (thursday.difference(firstDay).inDays / 7).floor();
    return '${thursday.year}-W${week.toString().padLeft(2, '0')}';
  }
}

class StreakState {
  const StreakState({
    this.current = 0,
    this.longest = 0,
    this.freezes = 0,
    this.lastActiveDay,
    this.lastFreezeGrantWeek,
  });

  final int current;
  final int longest;
  final int freezes;
  final DateTime? lastActiveDay;
  final String? lastFreezeGrantWeek;

  StreakState copyWith({
    int? current,
    int? longest,
    int? freezes,
    Object? lastActiveDay = _sentinel,
    Object? lastFreezeGrantWeek = _sentinel,
  }) {
    return StreakState(
      current: current ?? this.current,
      longest: longest ?? this.longest,
      freezes: freezes ?? this.freezes,
      lastActiveDay: identical(lastActiveDay, _sentinel)
          ? this.lastActiveDay
          : lastActiveDay as DateTime?,
      lastFreezeGrantWeek: identical(lastFreezeGrantWeek, _sentinel)
          ? this.lastFreezeGrantWeek
          : lastFreezeGrantWeek as String?,
    );
  }

  static const _sentinel = Object();
}
