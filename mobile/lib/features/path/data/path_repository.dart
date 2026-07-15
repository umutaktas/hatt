import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/db/database.dart';
import 'path_models.dart';

/// Reads the curriculum + progress into path view models and applies node
/// unlock rules (CLAUDE.md §4.1: a node completing unlocks the next one).
class PathRepository {
  PathRepository(this.db);

  final AppDatabase db;

  Stream<List<PathUnit>> watchPath() {
    final query = db.select(db.curriculumNodes).join([
      leftOuterJoin(
        db.nodeProgress,
        db.nodeProgress.nodeId.equalsExp(db.curriculumNodes.id),
      ),
    ])
      ..orderBy([OrderingTerm.asc(db.curriculumNodes.ordinal)]);

    return query.watch().map((rows) {
      final units = <String, List<PathNode>>{};
      final titles = <String, String>{};
      for (final row in rows) {
        final node = row.readTable(db.curriculumNodes);
        final progress = row.readTableOrNull(db.nodeProgress);
        titles[node.unitId] = node.unitTitle;
        (units[node.unitId] ??= []).add(
          PathNode(
            id: node.id,
            type: nodeTypeFromString(node.type),
            title: node.title,
            contentRefs:
                (jsonDecode(node.contentRefs) as List).cast<String>(),
            status: nodeStatusFromString(progress?.status ?? 'locked'),
            stars: progress?.stars ?? 0,
            ordinal: node.ordinal,
          ),
        );
      }
      return units.entries
          .map((e) => PathUnit(id: e.key, title: titles[e.key]!, nodes: e.value))
          .toList();
    });
  }

  /// Marks [nodeId] completed and unlocks the next node by ordinal.
  Future<void> completeNode(
    String nodeId, {
    required int stars,
    required int score,
  }) async {
    await db.transaction(() async {
      final node = await (db.select(db.curriculumNodes)
            ..where((t) => t.id.equals(nodeId)))
          .getSingle();

      final existing = await (db.select(db.nodeProgress)
            ..where((t) => t.nodeId.equals(nodeId)))
          .getSingleOrNull();
      final bestStars = existing == null ? stars : (stars > existing.stars ? stars : existing.stars);
      final bestScore = existing == null ? score : (score > existing.bestScore ? score : existing.bestScore);

      await db.into(db.nodeProgress).insertOnConflictUpdate(
            NodeProgressCompanion.insert(
              nodeId: nodeId,
              status: 'completed',
              stars: Value(bestStars),
              bestScore: Value(bestScore),
            ),
          );

      // Unlock the next node in path order if still locked.
      final next = await (db.select(db.curriculumNodes)
            ..where((t) => t.ordinal.isBiggerThanValue(node.ordinal))
            ..orderBy([(t) => OrderingTerm.asc(t.ordinal)])
            ..limit(1))
          .getSingleOrNull();
      if (next != null) {
        final nextProgress = await (db.select(db.nodeProgress)
              ..where((t) => t.nodeId.equals(next.id)))
            .getSingleOrNull();
        if (nextProgress == null || nextProgress.status == 'locked') {
          await db.into(db.nodeProgress).insertOnConflictUpdate(
                NodeProgressCompanion.insert(nodeId: next.id, status: 'available'),
              );
        }
      }
    });
  }
}
