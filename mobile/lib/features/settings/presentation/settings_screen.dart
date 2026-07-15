import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(userStateProvider).value;
    final repo = ref.read(userRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(l10n.settingsSound),
            secondary: const Icon(Icons.volume_up),
            value: user?.soundEnabled ?? true,
            onChanged: (v) => repo.setSoundEnabled(v),
          ),
          SwitchListTile(
            title: Text(l10n.settingsHarakat),
            secondary: const Icon(Icons.text_fields),
            value: user?.showHarakat ?? true,
            onChanged: (v) => repo.setShowHarakat(v),
          ),
          const Divider(),
          // Debug/dev toggle for premium while purchases are behind a flag (§2).
          SwitchListTile(
            title: const Text('Premium (geliştirici)'),
            subtitle: const Text('Satın alma akışı feature flag arkasında'),
            secondary: const Icon(Icons.workspace_premium, color: AppColors.gold),
            value: user?.premium ?? false,
            onChanged: (v) => repo.setPremium(v),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: AppColors.error),
            title: Text(l10n.settingsDeleteAccount,
                style: const TextStyle(color: AppColors.error),),
            onTap: () => _confirmDelete(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsDeleteAccount),
        content: const Text(
            'Tüm ilerlemen ve kişisel verilerin kalıcı olarak silinecek. '
            'Bu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(userRepositoryProvider).deleteAllUserData();
    if (context.mounted) {
      // Onboarding gate will re-appear because onboarded was reset.
      Navigator.of(context).popUntil((r) => r.isFirst);
    }
  }
}
