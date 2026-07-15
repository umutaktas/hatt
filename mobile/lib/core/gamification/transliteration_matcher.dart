/// Tolerant comparator for free-form transliteration answers (CLAUDE.md §4.2.4).
///
/// Pure Dart, no Flutter dependency, fully unit-testable. The matcher treats
/// Ottoman transliteration conventions leniently so the learner is not punished
/// for diacritics or spacing they cannot reasonably be expected to type:
///
///   * Long-vowel circumflexes are equivalent to their bare vowels
///     (â≈a, î≈i, û≈u, ā≈a, ī≈i, ū≈u, ô≈o, ê≈e).
///   * The ayn/hamza markers (ʿ ʾ ' ` ‛ ’) are ignored.
///   * Case, leading/trailing whitespace and repeated inner whitespace,
///     and connector punctuation (- _ ) are normalized.
///   * A tiny edit-distance tolerance forgives a single typo on longer answers.
class TransliterationMatcher {
  const TransliterationMatcher({this.typoToleranceThreshold = 6});

  /// Answers of at least this many normalized characters are allowed a single
  /// character of Levenshtein slack (one typo). Shorter answers must match
  /// exactly after normalization to avoid false positives on short words.
  final int typoToleranceThreshold;

  /// Characters that carry no meaning for comparison and are stripped entirely.
  static const _ignored = {
    'ʿ', 'ʾ', "'", '`', '‛', '’', '‘', 'ʼ', '´', 'ʻ',
  };

  /// Diacritic / long-vowel folding map applied after lowercasing.
  static const _fold = <String, String>{
    'â': 'a', 'ā': 'a', 'ä': 'a', 'à': 'a', 'á': 'a',
    'î': 'i', 'ī': 'i', 'ï': 'i', 'ì': 'i', 'í': 'i',
    'û': 'u', 'ū': 'u', 'ü': 'u', 'ù': 'u', 'ú': 'u',
    'ô': 'o', 'ō': 'o', 'ö': 'o', 'ò': 'o', 'ó': 'o',
    'ê': 'e', 'ē': 'e', 'ë': 'e', 'è': 'e', 'é': 'e',
    'ĝ': 'g', 'ğ': 'g',
    'ş': 's', 'ś': 's',
    'ç': 'c',
    'ñ': 'n',
    // Turkish dotless/dotted i already handled by lowercasing + fold of i.
    'ı': 'i',
  };

  /// Returns `true` when [answer] is an acceptable transliteration of [expected].
  bool matches(String answer, String expected) {
    final a = normalize(answer);
    final e = normalize(expected);
    if (a.isEmpty) return false;
    if (a == e) return true;
    if (e.length >= typoToleranceThreshold &&
        _levenshtein(a, e) <= 1) {
      return true;
    }
    return false;
  }

  /// Normalizes a transliteration string for comparison. Exposed for tests.
  String normalize(String input) {
    final lowered = input.toLowerCase().trim();
    final buffer = StringBuffer();
    for (final rune in lowered.runes) {
      final ch = String.fromCharCode(rune);
      if (_ignored.contains(ch)) continue;
      if (ch == '-' || ch == '_') {
        buffer.write(' ');
        continue;
      }
      buffer.write(_fold[ch] ?? ch);
    }
    // Collapse runs of whitespace to a single space.
    return buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static int _levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    final prev = List<int>.generate(b.length + 1, (i) => i);
    final curr = List<int>.filled(b.length + 1, 0);
    for (var i = 0; i < a.length; i++) {
      curr[0] = i + 1;
      for (var j = 0; j < b.length; j++) {
        final cost = a.codeUnitAt(i) == b.codeUnitAt(j) ? 0 : 1;
        curr[j + 1] = _min3(curr[j] + 1, prev[j + 1] + 1, prev[j] + cost);
      }
      for (var j = 0; j <= b.length; j++) {
        prev[j] = curr[j];
      }
    }
    return prev[b.length];
  }

  static int _min3(int a, int b, int c) =>
      a < b ? (a < c ? a : c) : (b < c ? b : c);
}
