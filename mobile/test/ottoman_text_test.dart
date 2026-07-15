import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/core/widgets/ottoman_text.dart';

void main() {
  testWidgets('enforces the 28sp minimum for every size (CLAUDE.md §3)',
      (tester) async {
    for (final size in OttomanTextSize.values) {
      expect(size.sp, greaterThanOrEqualTo(OttomanText.minFontSize));
    }
    expect(OttomanTextSize.reading.sp, inInclusiveRange(34, 40));
  });

  testWidgets('renders Ottoman text at the configured size, RTL', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OttomanText('كتاب', size: OttomanTextSize.reading),
        ),
      ),
    );
    final text = tester.widget<Text>(find.text('كتاب'));
    expect(text.style!.fontSize, OttomanTextSize.reading.sp);

    final dir = tester.widget<Directionality>(
      find.ancestor(
        of: find.text('كتاب'),
        matching: find.byType(Directionality),
      ).first,
    );
    expect(dir.textDirection, TextDirection.rtl);
  });

  test('stripHarakat removes combining vowel marks', () {
    const withMarks = 'كِتَاب';
    final stripped = OttomanText.stripHarakat(withMarks);
    expect(stripped, 'كتاب');
    expect(stripped.length, lessThan(withMarks.length));
  });
}
