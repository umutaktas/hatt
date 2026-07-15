import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mascot/mascot_state.dart';
import '../../../core/mascot/mascot_view.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../data/firestore_league_service.dart';
import '../data/league_service.dart';

final leagueServiceProvider = Provider<LeagueService>((ref) {
  final flags = ref.watch(featureFlagsProvider);
  return flags.firebaseEnabled
      ? FirestoreLeagueService()
      : const OfflineLeagueService();
});

final leagueSnapshotProvider = FutureProvider<LeagueSnapshot?>(
  (ref) => ref.watch(leagueServiceProvider).currentSnapshot(),
);

class LeagueScreen extends ConsumerWidget {
  const LeagueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final flags = ref.watch(featureFlagsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.leagueTitle)),
      body: !flags.firebaseEnabled
          ? _OfflineState(l10n: l10n)
          : ref.watch(leagueSnapshotProvider).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => _OfflineState(l10n: l10n),
                data: (snap) => snap == null
                    ? _OfflineState(l10n: l10n)
                    : _Standings(snapshot: snap),
              ),
    );
  }
}

class _OfflineState extends StatelessWidget {
  const _OfflineState({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MascotView(state: MascotState.sleeping, size: 120),
            const SizedBox(height: 16),
            Text(l10n.leagueOffline,
                style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: 8),
            Text(l10n.leagueOfflineBody, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _Standings extends StatelessWidget {
  const _Standings({required this.snapshot});
  final LeagueSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: AppColors.ink,
          child: Text('${snapshot.tier.trName} Ligi',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.goldLight),),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.standings.length,
            itemBuilder: (context, i) {
              final s = snapshot.standings[i];
              final promote = s.rank <= snapshot.promoteCount;
              final relegate = s.rank >
                  snapshot.standings.length - snapshot.relegateCount;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: promote
                      ? AppColors.success
                      : relegate
                          ? AppColors.error
                          : AppColors.locked,
                  child: Text('${s.rank}',
                      style: const TextStyle(color: Colors.white),),
                ),
                title: Text(s.nickname,
                    style: TextStyle(
                        fontWeight:
                            s.isMe ? FontWeight.w800 : FontWeight.w500,),),
                trailing: Text('${s.weeklyXp} XP'),
                tileColor:
                    s.isMe ? AppColors.gold.withValues(alpha: 0.12) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
