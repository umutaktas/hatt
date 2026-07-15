import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../content/content_models.dart';
import '../db/database.dart';

/// Seeds the local database from bundled JSON assets on first launch
/// (CLAUDE.md §2: "içerik, uygulama paketiyle gelen JSON + görsel asset'lerden
/// seed edilir"). Idempotent: does nothing if already seeded.
class ContentSeeder {
  ContentSeeder(this.db, {AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AppDatabase db;
  final AssetBundle _bundle;

  Future<void> seedIfNeeded() async {
    if (await db.isSeeded) return;
    await seed();
  }

  Future<void> seed() async {
    final letters = await _loadList('assets/content/letters.json')
        .then((l) => l.map((e) => LetterDto.fromJson(e)).toList());
    final words = await _loadList('assets/content/words.json')
        .then((l) => l.map((e) => WordDto.fromJson(e)).toList());
    final passages = await _loadList('assets/content/passages.json')
        .then((l) => l.map((e) => PassageDto.fromJson(e)).toList());
    final curriculumJson = jsonDecode(
      await _bundle.loadString('assets/content/curriculum.json'),
    ) as Map<String, dynamic>;
    final curriculum = CurriculumDoc.fromJson(curriculumJson);

    await db.transaction(() async {
      await db.batch((b) {
        b.insertAll(
          db.letters,
          letters.map(
            (d) => LettersCompanion.insert(
              id: d.id,
              name: d.name,
              isolated: d.isolated,
              initialForm: d.initialForm,
              medialForm: d.medialForm,
              finalForm: d.finalForm,
              soundValue: d.soundValue,
              similarGroup: Value(d.similarGroup),
              exampleWord: Value(d.exampleWord),
            ),
          ),
        );
        b.insertAll(
          db.words,
          words.map(
            (d) => WordsCompanion.insert(
              id: d.id,
              ottoman: d.ottoman,
              transliteration: d.transliteration,
              meaningTr: d.meaningTr,
              frequencyRank: d.frequencyRank,
              level: d.level,
              root: Value(d.root),
              exampleSentence: Value(d.exampleSentence),
            ),
          ),
        );
        for (final p in passages) {
          b.insert(
            db.readingPassages,
            ReadingPassagesCompanion.insert(
              id: p.id,
              title: p.title,
              level: p.level,
              genre: p.genre,
              imageAssetPath: Value(p.imageAssetPath),
            ),
          );
          b.insertAll(
            db.passageLines,
            p.lines.map(
              (l) => PassageLinesCompanion.insert(
                id: l.id,
                passageId: p.id,
                ordinal: l.ordinal,
                ottoman: l.ottoman,
                transliteration: l.transliteration,
                simplifiedTr: l.simplifiedTr,
              ),
            ),
          );
        }

        var globalOrdinal = 0;
        var isFirstNode = true;
        for (final unit in curriculum.units) {
          for (final node in unit.nodes) {
            b.insert(
              db.curriculumNodes,
              CurriculumNodesCompanion.insert(
                id: node.id,
                type: node.type,
                unitId: unit.id,
                unitTitle: unit.title,
                ordinal: globalOrdinal,
                title: node.title,
                contentRefs: jsonEncode(node.contentRefs),
              ),
            );
            b.insert(
              db.nodeProgress,
              NodeProgressCompanion.insert(
                nodeId: node.id,
                status: isFirstNode ? 'available' : 'locked',
              ),
            );
            globalOrdinal++;
            isFirstNode = false;
          }
        }
      });
    });
  }

  Future<List<Map<String, dynamic>>> _loadList(String path) async {
    final raw = await _bundle.loadString(path);
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }
}
