import 'dart:math' as math;

/// Grades a review answer, mapped from lesson correctness (CLAUDE.md §5, §8.4).
///
/// The lesson engine only knows "correct" / "wrong", so we map:
///   wrong            -> again
///   correct (slow)   -> hard   (optional; not wired by default)
///   correct          -> good
///   correct (streak) -> easy   (optional)
enum FsrsRating {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const FsrsRating(this.value);
  final int value;
}

enum FsrsPhase { newCard, learning, review, relearning }

/// Immutable per-item memory state persisted in the `review_states` table.
class FsrsCard {
  const FsrsCard({
    this.stability = 0,
    this.difficulty = 0,
    this.due,
    this.lastReview,
    this.reps = 0,
    this.lapses = 0,
    this.phase = FsrsPhase.newCard,
  });

  final double stability;
  final double difficulty;
  final DateTime? due;
  final DateTime? lastReview;
  final int reps;
  final int lapses;
  final FsrsPhase phase;

  bool get isNew => phase == FsrsPhase.newCard;

  bool isDue(DateTime now) => due == null || !due!.isAfter(now);

  FsrsCard copyWith({
    double? stability,
    double? difficulty,
    DateTime? due,
    DateTime? lastReview,
    int? reps,
    int? lapses,
    FsrsPhase? phase,
  }) {
    return FsrsCard(
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      due: due ?? this.due,
      lastReview: lastReview ?? this.lastReview,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      phase: phase ?? this.phase,
    );
  }
}

/// A minimal, self-contained FSRS-5 scheduler (CLAUDE.md §2: "fsrs paketi varsa
/// kullan, yoksa sade bir FSRS implementasyonu yaz"). Uses the power
/// forgetting curve with the published default weights. Pure Dart, deterministic
/// given an injected `now`, so scheduling is fully unit-testable.
class Fsrs {
  const Fsrs({
    this.requestRetention = 0.9,
    this.maximumInterval = 36500,
    this.weights = _defaultWeights,
  });

  final double requestRetention;
  final int maximumInterval;
  final List<double> weights;

  static const double _decay = -0.5;
  // FACTOR = 0.9^(1/decay) - 1
  static final double _factor = math.pow(0.9, 1 / _decay).toDouble() - 1;

  static const List<double> _defaultWeights = [
    0.40255, 1.18385, 3.173, 15.69105, 7.1949, 0.5345, 1.4604, 0.0046,
    1.54575, 0.1192, 1.01925, 1.9395, 0.11, 0.29605, 2.2698, 0.2315,
    2.9898, 0.51655, 0.6621,
  ];

  /// Probability of recall for a card with [stability] after [elapsedDays].
  double retrievability(double elapsedDays, double stability) {
    if (stability <= 0) return 0;
    return math.pow(1 + _factor * elapsedDays / stability, _decay).toDouble();
  }

  /// Interval (in whole days) until the card should next be reviewed.
  int nextIntervalDays(double stability) {
    final raw =
        (stability / _factor) * (math.pow(requestRetention, 1 / _decay) - 1);
    return raw.round().clamp(1, maximumInterval);
  }

  /// Schedules [card] after being answered with [rating] at [now].
  FsrsCard schedule(FsrsCard card, FsrsRating rating, DateTime now) {
    if (card.isNew) {
      final s = _initialStability(rating);
      final d = _initialDifficulty(rating);
      return _finalize(card, rating, now, s, d, isLapse: false);
    }

    final elapsed = card.lastReview == null
        ? 0.0
        : now.difference(card.lastReview!).inMicroseconds /
            Duration.microsecondsPerDay;
    final r = retrievability(elapsed < 0 ? 0 : elapsed, card.stability);
    final d = _nextDifficulty(card.difficulty, rating);
    final double s;
    final bool isLapse;
    if (rating == FsrsRating.again) {
      s = _nextForgetStability(card.difficulty, card.stability, r);
      isLapse = true;
    } else {
      s = _nextRecallStability(card.difficulty, card.stability, r, rating);
      isLapse = false;
    }
    return _finalize(card, rating, now, s, d, isLapse: isLapse);
  }

  FsrsCard _finalize(
    FsrsCard card,
    FsrsRating rating,
    DateTime now,
    double stability,
    double difficulty,
    {required bool isLapse,}) {
    final clampedS = stability.clamp(0.1, double.maxFinite).toDouble();
    final intervalDays = rating == FsrsRating.again
        ? 1
        : nextIntervalDays(clampedS);
    return card.copyWith(
      stability: clampedS,
      difficulty: difficulty.clamp(1, 10).toDouble(),
      lastReview: now,
      due: now.add(Duration(days: intervalDays)),
      reps: card.reps + 1,
      lapses: card.lapses + (isLapse ? 1 : 0),
      phase: rating == FsrsRating.again ? FsrsPhase.relearning : FsrsPhase.review,
    );
  }

  double _initialStability(FsrsRating rating) =>
      math.max(weights[rating.value - 1], 0.1);

  double _initialDifficulty(FsrsRating rating) {
    final d = weights[4] - math.exp(weights[5] * (rating.value - 1)) + 1;
    return d.clamp(1, 10).toDouble();
  }

  double _nextDifficulty(double difficulty, FsrsRating rating) {
    final deltaD = -weights[6] * (rating.value - 3);
    final damped = difficulty + (10 - difficulty) * deltaD / 9;
    final reverted =
        weights[7] * _initialDifficulty(FsrsRating.easy) + (1 - weights[7]) * damped;
    return reverted.clamp(1, 10).toDouble();
  }

  double _nextRecallStability(
      double d, double s, double r, FsrsRating rating,) {
    final hardPenalty = rating == FsrsRating.hard ? weights[15] : 1.0;
    final easyBonus = rating == FsrsRating.easy ? weights[16] : 1.0;
    return s *
        (1 +
            math.exp(weights[8]) *
                (11 - d) *
                math.pow(s, -weights[9]) *
                (math.exp((1 - r) * weights[10]) - 1) *
                hardPenalty *
                easyBonus);
  }

  double _nextForgetStability(double d, double s, double r) {
    return weights[11] *
        math.pow(d, -weights[12]) *
        (math.pow(s + 1, weights[13]) - 1) *
        math.exp((1 - r) * weights[14]);
  }
}
