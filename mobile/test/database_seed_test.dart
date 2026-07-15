import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatt/core/db/database.dart';
import 'package:hatt/core/seed/content_seeder.dart';

/// AssetBundle that reads the real bundled content files from disk so the seed
/// pipeline is exercised end-to-end against the shipping JSON.
class _DiskBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    final bytes = await File(key).readAsBytes();
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) =>
      File(key).readAsString();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting());
  tearDown(() => db.close());

  test('seeds letters, words, passages and curriculum from bundled JSON',
      () async {
    await ContentSeeder(db, bundle: _DiskBundle()).seed();

    final letters = await db.select(db.letters).get();
    final words = await db.select(db.words).get();
    final nodes = await db.select(db.curriculumNodes).get();
    final progress = await db.select(db.nodeProgress).get();

    expect(letters, isNotEmpty);
    expect(words, isNotEmpty);
    expect(nodes.length, greaterThanOrEqualTo(12));

    // Exactly one node is unlocked initially (the first by ordinal).
    final available =
        progress.where((p) => p.status == 'available').toList();
    expect(available.length, 1);
    final firstNode = (nodes..sort((a, b) => a.ordinal.compareTo(b.ordinal))).first;
    expect(available.single.nodeId, firstNode.id);
  });

  test('seedIfNeeded is idempotent', () async {
    final seeder = ContentSeeder(db, bundle: _DiskBundle());
    await seeder.seedIfNeeded();
    final before = (await db.select(db.words).get()).length;
    await seeder.seedIfNeeded();
    final after = (await db.select(db.words).get()).length;
    expect(after, before);
  });
}
