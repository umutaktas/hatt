import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

/// The single local-first Drift database (CLAUDE.md §2, §5). Content is seeded
/// from bundled JSON assets on first launch; progress is written here and later
/// mirrored to Firestore (one-way, device wins) when the backend is enabled.
@DriftDatabase(
  tables: [
    Letters,
    Words,
    ReadingPassages,
    PassageLines,
    CurriculumNodes,
    NodeProgress,
    ReviewStates,
    UserStateTable,
    ExerciseLog,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  /// In-memory database for tests.
  AppDatabase.forTesting() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          if (details.wasCreated) {
            await into(userStateTable).insert(
              UserStateTableCompanion.insert(id: const Value(1)),
            );
          } else {
            // Ensure the singleton user_state row always exists.
            final existing = await (select(userStateTable)
                  ..where((t) => t.id.equals(1)))
                .getSingleOrNull();
            existing ??
                await into(userStateTable).insert(
                  UserStateTableCompanion.insert(id: const Value(1)),
                );
          }
        },
      );

  Future<UserStateRow> userState() => (select(userStateTable)
        ..where((t) => t.id.equals(1)))
      .getSingle();

  Stream<UserStateRow> watchUserState() => (select(userStateTable)
        ..where((t) => t.id.equals(1)))
      .watchSingle();

  Future<void> updateUserState(UserStateTableCompanion companion) =>
      (update(userStateTable)..where((t) => t.id.equals(1))).write(companion);

  Future<bool> get isSeeded async {
    final count = await (selectOnly(curriculumNodes)
          ..addColumns([curriculumNodes.id.count()]))
        .map((r) => r.read(curriculumNodes.id.count()) ?? 0)
        .getSingle();
    return count > 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'hatt.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
