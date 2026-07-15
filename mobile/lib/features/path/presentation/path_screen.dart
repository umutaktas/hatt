import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/stat_header.dart';
import '../../lesson/presentation/lesson_screen.dart';
import '../data/path_models.dart';
import 'path_providers.dart';

/// The vertical learning path (CLAUDE.md §4.1).
class PathScreen extends ConsumerWidget {
  const PathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathAsync = ref.watch(pathProvider);
    return Column(
      children: [
        const StatHeader(),
        Expanded(
          child: pathAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Hata: $e')),
            data: (units) => ListView.builder(
              padding: const EdgeInsets.only(bottom: 32),
              itemCount: units.length,
              itemBuilder: (context, i) => _UnitSection(unit: units[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class _UnitSection extends StatelessWidget {
  const _UnitSection({required this.unit});
  final PathUnit unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(unit.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.parchment, fontWeight: FontWeight.w700,),),
              const SizedBox(height: 4),
              Text('${unit.completedCount}/${unit.nodes.length} ders',
                  style: const TextStyle(color: AppColors.goldLight),),
            ],
          ),
        ),
        ...unit.nodes.asMap().entries.map(
              (e) => _NodeRow(node: e.value, indexInUnit: e.key),
            ),
      ],
    );
  }
}

class _NodeRow extends StatelessWidget {
  const _NodeRow({required this.node, required this.indexInUnit});
  final PathNode node;
  final int indexInUnit;

  @override
  Widget build(BuildContext context) {
    // Gentle serpentine offset like a real path.
    final offset = [0.0, 48.0, 72.0, 48.0, 0.0, -48.0, -72.0, -48.0][
        indexInUnit % 8];
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0),
      child: Transform.translate(
        offset: Offset(offset, 0),
        child: Center(child: _NodeBubble(node: node)),
      ),
    );
  }
}

class _NodeBubble extends StatelessWidget {
  const _NodeBubble({required this.node});
  final PathNode node;

  @override
  Widget build(BuildContext context) {
    final locked = node.status == NodeStatus.locked;
    final completed = node.status == NodeStatus.completed;
    final color = locked
        ? AppColors.locked
        : completed
            ? AppColors.success
            : AppColors.gold;

    return Column(
      children: [
        Semantics(
          button: !locked,
          label: '${node.title} — ${_statusLabel(node.status)}',
          child: InkWell(
            onTap: locked
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LessonScreen(node: node),
                      ),
                    ),
            customBorder: const CircleBorder(),
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(_iconFor(node.type),
                  color: Colors.white, size: 32,),
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 140,
          child: Text(
            node.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: locked ? AppColors.locked : null,
                ),
          ),
        ),
        if (completed && node.stars > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3,
              (i) => Icon(
                i < node.stars ? Icons.star : Icons.star_border,
                size: 16,
                color: AppColors.gold,
              ),
            ),
          ),
      ],
    );
  }

  static String _statusLabel(NodeStatus s) => switch (s) {
        NodeStatus.locked => 'kilitli',
        NodeStatus.available => 'açık',
        NodeStatus.completed => 'tamamlandı',
      };

  static IconData _iconFor(NodeType t) => switch (t) {
        NodeType.letter => Icons.abc,
        NodeType.vocab => Icons.menu_book,
        NodeType.reading => Icons.article,
        NodeType.review => Icons.refresh,
        NodeType.checkpoint => Icons.workspace_premium,
      };
}
