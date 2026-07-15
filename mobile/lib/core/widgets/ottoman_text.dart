import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reading contexts that set the minimum font size for Ottoman/Arabic script.
///
/// CLAUDE.md §3 (tartışmaya kapalı / non-negotiable accessibility rule):
///   * Everywhere: minimum 28sp.
///   * Reading exercises: 34–40sp.
enum OttomanTextSize {
  /// Inline / option chips — the hard floor, 28sp.
  standard(28),

  /// Prompts and headings, 32sp.
  prompt(32),

  /// Reading-exercise lines, 38sp (within the 34–40 band).
  reading(38);

  const OttomanTextSize(this.sp);
  final double sp;
}

/// The single widget through which ALL Ottoman/Arabic script is rendered so the
/// large-type rule is enforced in one place (CLAUDE.md §3). Never render Arabic
/// script with a raw [Text]; use this.
///
/// * Direction is forced RTL.
/// * Font is Noto Naskh Arabic (via google_fonts).
/// * Harakat (vowel marks) can be stripped for the "harekesiz" toggle.
/// * The 28sp floor is asserted in debug and clamped in release.
class OttomanText extends StatelessWidget {
  const OttomanText(
    this.text, {
    super.key,
    this.size = OttomanTextSize.standard,
    this.showHarakat = true,
    this.color,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w500,
  });

  final String text;
  final OttomanTextSize size;

  /// When false, Arabic combining vowel marks are removed (harekesiz gösterim).
  final bool showHarakat;
  final Color? color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  /// Absolute minimum permitted font size for Ottoman script, in logical px.
  static const double minFontSize = 28;

  /// Unicode ranges for Arabic harakat / combining marks removed by the toggle.
  static final RegExp _harakat = RegExp(
    '[ؐ-ًؚ-ٰٟۖ-ۜ۟-۪ۨ-ۭ]',
  );

  static String stripHarakat(String input) => input.replaceAll(_harakat, '');

  @override
  Widget build(BuildContext context) {
    assert(
      size.sp >= minFontSize,
      'Ottoman script must be at least ${minFontSize}sp (CLAUDE.md §3).',
    );
    final effectiveSize = size.sp < minFontSize ? minFontSize : size.sp;
    final content = showHarakat ? text : stripHarakat(text);
    final resolvedColor = color ?? Theme.of(context).colorScheme.onSurface;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        content,
        textAlign: textAlign,
        style: GoogleFonts.notoNaskhArabic(
          fontSize: effectiveSize,
          height: 1.6,
          fontWeight: fontWeight,
          color: resolvedColor,
        ),
      ),
    );
  }
}
