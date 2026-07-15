import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'mascot_state.dart';

/// Renders the mascot for a given [MascotState]. Falls back to a colored circle
/// if the SVG asset is missing so the UI never breaks during art iteration.
class MascotView extends StatelessWidget {
  const MascotView({
    super.key,
    this.state = MascotState.normal,
    this.size = 120,
  });

  final MascotState state;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        state.asset,
        semanticsLabel: 'Kamış',
        placeholderBuilder: (_) => const SizedBox.shrink(),
      ),
    );
  }
}
