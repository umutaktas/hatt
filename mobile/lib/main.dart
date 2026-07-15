import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/db/database.dart';
import 'core/providers/app_providers.dart';
import 'core/seed/content_seeder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local-first: open the DB and seed bundled content on first launch
  // (CLAUDE.md §2). Firebase is intentionally NOT initialized here — it lives
  // behind a feature flag so the app boots fully offline (§9).
  final db = AppDatabase();
  await ContentSeeder(db).seedIfNeeded();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const HattApp(),
    ),
  );
}
