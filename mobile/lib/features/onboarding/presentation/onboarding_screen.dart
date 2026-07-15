import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mascot/mascot_state.dart';
import '../../../core/mascot/mascot_view.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/ottoman_text.dart';

/// First-run onboarding with the KVKK/GDPR explicit-consent screen
/// (CLAUDE.md §2, Phase 6). Anonymous by default; no personal data collected.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  bool _consent = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(userRepositoryProvider).setOnboarded(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (p) => setState(() => _page = p),
                children: [
                  _Intro(),
                  _ConsentPage(
                    consent: _consent,
                    onChanged: (v) => setState(() => _consent = v),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: FilledButton(
                onPressed: _page == 0
                    ? () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                    : (_consent ? _finish : null),
                child: Text(_page == 0 ? 'Devam' : 'Başla'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MascotView(state: MascotState.normal, size: 160),
          const SizedBox(height: 24),
          const OttomanText('خط', size: OttomanTextSize.reading,
              color: AppColors.gold,),
          const SizedBox(height: 12),
          Text('Hatt', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 8),
          Text(
            'Osmanlıca okumayı adım adım, gerçek tarihi metinlerle öğren.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _ConsentPage extends StatelessWidget {
  const _ConsentPage({required this.consent, required this.onChanged});
  final bool consent;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text('Gizlilik ve Rıza',
              style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: 16),
          const Text(
            'Hatt varsayılan olarak anonim çalışır. Kişisel veri toplanmaz. '
            'İlerlemen cihazında saklanır. İstersen daha sonra hesabını '
            'e-posta ile yedekleyebilirsin; o durumda yalnızca e-posta adresin '
            'saklanır.\n\n'
            'Verilerini dilediğin an Ayarlar → "Hesabımı ve verilerimi sil" '
            'ile tamamen silebilirsin.',
          ),
          const SizedBox(height: 24),
          CheckboxListTile(
            value: consent,
            onChanged: (v) => onChanged(v ?? false),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text(
                'Gizlilik politikasını okudum ve anonim kullanımı kabul ediyorum.',),
          ),
        ],
      ),
    );
  }
}
