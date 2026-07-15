import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/gamification/level_system.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../paywall/presentation/paywall_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const _levels = LevelSystem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(userStateProvider).value;
    final xp = user?.xp ?? 0;
    final level = _levels.levelForXp(xp);
    final progress = _levels.progressWithinLevel(xp);
    final premium = user?.premium ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.ink,
                child: Text('$level',
                    style: const TextStyle(
                        color: AppColors.goldLight,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,),),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user?.nickname ?? 'Öğrenci',
                        style: Theme.of(context).textTheme.titleLarge,),
                    Text('Seviye $level',
                        style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
              ),
              if (premium)
                const Chip(
                  avatar: Icon(Icons.workspace_premium,
                      color: AppColors.gold, size: 18,),
                  label: Text('Premium'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              valueColor: const AlwaysStoppedAnimation(AppColors.gold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('Sonraki seviyeye ${_levels.xpToNextLevel(xp)} XP'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _StatCard(
                  icon: Icons.local_fire_department,
                  color: AppColors.gold,
                  value: '${user?.streakCurrent ?? 0}',
                  label: 'Seri',),
              _StatCard(
                  icon: Icons.star,
                  color: AppColors.teal,
                  value: '$xp',
                  label: 'Toplam XP',),
              _StatCard(
                  icon: Icons.ac_unit,
                  color: AppColors.locked,
                  value: '${user?.streakFreezes ?? 0}',
                  label: 'Dondurucu',),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.insights, color: AppColors.teal),
              title: const Text('Zayıf Nokta Analizi'),
              subtitle: Text(premium ? 'Görüntüle' : 'Premium özelliği'),
              trailing:
                  premium ? const Icon(Icons.chevron_right) : const Icon(Icons.lock),
              onTap: premium
                  ? () {}
                  : () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PaywallScreen()),
                      ),
            ),
          ),
          if (!premium)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: FilledButton.icon(
                icon: const Icon(Icons.workspace_premium),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PaywallScreen()),
                ),
                label: const Text('Premium\'a Geç'),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(
      {required this.icon,
      required this.color,
      required this.value,
      required this.label,});
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 6),
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
