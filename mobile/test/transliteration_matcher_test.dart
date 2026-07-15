import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/core/gamification/transliteration_matcher.dart';

void main() {
  const matcher = TransliterationMatcher();

  group('normalize', () {
    test('folds long vowels and ayn markers', () {
      expect(matcher.normalize('kâtib'), 'katib');
      expect(matcher.normalize('maʿnâ'), 'mana');
      expect(matcher.normalize("kadı'"), 'kadi');
    });

    test('collapses whitespace and connectors, trims, lowercases', () {
      expect(matcher.normalize('  Bism-i   Allah '), 'bism i allah');
      expect(matcher.normalize('KİTAP'), 'kitap');
    });
  });

  group('matches', () {
    test('accepts exact and diacritic-insensitive answers', () {
      expect(matcher.matches('katib', 'kâtib'), isTrue);
      expect(matcher.matches('KÂTİB', 'katib'), isTrue);
      expect(matcher.matches('mana', 'maʿnâ'), isTrue);
    });

    test('forgives a single typo on longer answers', () {
      expect(matcher.matches('istanbol', 'istanbul'), isTrue); // 1 edit, len>=6
    });

    test('rejects short answers with a typo', () {
      expect(matcher.matches('kop', 'kap'), isFalse); // len 3, no slack
    });

    test('rejects clearly wrong answers', () {
      expect(matcher.matches('deniz', 'kitap'), isFalse);
      expect(matcher.matches('', 'kitap'), isFalse);
    });
  });
}
