import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/feature_flags.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';

/// Premium paywall skeleton (CLAUDE.md §2, §6). The purchase call is gated
/// behind [FeatureFlags.purchasesEnabled]; product IDs are placeholders.
class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  static const _benefits = [
    (Icons.favorite, 'Sınırsız can'),
    (Icons.ac_unit, 'Sınırsız seri dondurucu'),
    (Icons.workspace_premium, 'Sınırsız checkpoint ile ünite atlama'),
    (Icons.insights, 'Zayıf nokta analizi'),
    (Icons.auto_awesome, 'Yakında: AI kitabe çözücü'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(featureFlagsProvider);
    final entitlement = ref.watch(entitlementProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hatt Premium')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.workspace_premium, size: 64, color: AppColors.gold),
          const SizedBox(height: 16),
          Text('Daha hızlı öğren',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: 24),
          ..._benefits.map(
            (b) => ListTile(
              leading: Icon(b.$1, color: AppColors.teal),
              title: Text(b.$2),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: entitlement.isPremium
                ? null
                : () async {
                    await entitlement.purchasePremium();
                    if (context.mounted) Navigator.of(context).maybePop();
                  },
            child: Text(entitlement.isPremium
                ? 'Zaten Premium'
                : flags.purchasesEnabled
                    ? 'Premium\'a Geç'
                    : 'Yakında',),
          ),
          if (!flags.purchasesEnabled)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                'Satın alma yakında etkinleştirilecek. Şimdilik Premium\'u '
                'Ayarlar\'dan test edebilirsin.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.locked),
              ),
            ),
        ],
      ),
    );
  }
}
