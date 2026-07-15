import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/core/fsrs/fsrs.dart';

void main() {
  const fsrs = Fsrs();
  final now = DateTime.utc(2026, 1, 1, 8);

  test('new card gains stability, difficulty and a future due date', () {
    const card = FsrsCard();
    final scheduled = fsrs.schedule(card, FsrsRating.good, now);
    expect(scheduled.reps, 1);
    expect(scheduled.phase, FsrsPhase.review);
    expect(scheduled.stability, greaterThan(0));
    expect(scheduled.difficulty, inInclusiveRange(1, 10));
    expect(scheduled.due!.isAfter(now), isTrue);
    expect(scheduled.lastReview, now);
  });

  test('"again" on a review card records a lapse and short interval', () {
    final good = fsrs.schedule(const FsrsCard(), FsrsRating.good, now);
    final laterDue = good.due!;
    final again = fsrs.schedule(good, FsrsRating.again, laterDue);
    expect(again.lapses, 1);
    expect(again.phase, FsrsPhase.relearning);
    // relearning re-shows the card within a day
    expect(again.due!.difference(laterDue).inDays, 1);
  });

  test('easy grows the interval faster than good', () {
    final good = fsrs.schedule(const FsrsCard(), FsrsRating.good, now);
    final easy = fsrs.schedule(const FsrsCard(), FsrsRating.easy, now);
    expect(easy.due!.isAfter(good.due!), isTrue);
  });

  test('repeated good reviews lengthen the interval (stability grows)', () {
    var card = fsrs.schedule(const FsrsCard(), FsrsRating.good, now);
    final firstInterval = card.due!.difference(now).inDays;
    // Review again exactly when due.
    final due1 = card.due!;
    card = fsrs.schedule(card, FsrsRating.good, due1);
    final secondInterval = card.due!.difference(due1).inDays;
    expect(secondInterval, greaterThanOrEqualTo(firstInterval));
  });

  test('retrievability decays from ~1 toward 0 as time passes', () {
    const s = 10.0;
    expect(fsrs.retrievability(0, s), closeTo(1.0, 1e-9));
    final rNow = fsrs.retrievability(5, s);
    final rLater = fsrs.retrievability(50, s);
    expect(rNow, greaterThan(rLater));
    expect(rLater, inInclusiveRange(0, 1));
  });

  test('isDue respects the due date', () {
    final card = fsrs.schedule(const FsrsCard(), FsrsRating.good, now);
    expect(card.isDue(now), isFalse);
    expect(card.isDue(card.due!.add(const Duration(minutes: 1))), isTrue);
    expect(const FsrsCard().isDue(now), isTrue); // new cards are always due
  });
}
