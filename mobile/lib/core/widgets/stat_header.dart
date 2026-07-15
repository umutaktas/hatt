import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import '../theme/app_colors.dart';

/// The top status strip: hearts, streak, XP (CLAUDE.md §4.3). Reads the live
/// user_state.
class StatHeader extends ConsumerWidget {
  const StatHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider).value;
    final hearts = user?.premium == true ? '∞' : '${user?.hearts ?? 0}';
    final streak = user?.streakCurrent ?? 0;
    final xp = user?.xp ?? 0;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Chip(icon: Icons.favorite, color: AppColors.heart, label: hearts),
            _Chip(
                icon: Icons.local_fire_department,
                color: AppColors.gold,
                label: '$streak',),
            _Chip(icon: Icons.star, color: AppColors.teal, label: '$xp'),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.color, required this.label});

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 4),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),),
      ],
    );
  }
}
