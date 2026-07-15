/// Parsed representations of the bundled content JSON (assets/content/*).
/// Kept as plain Dart so the seed pipeline and tests need no Flutter/Drift deps.
library;

class CurriculumDoc {
  const CurriculumDoc({required this.version, required this.units});

  final int version;
  final List<CurriculumUnit> units;

  factory CurriculumDoc.fromJson(Map<String, dynamic> json) {
    return CurriculumDoc(
      version: (json['version'] as num).toInt(),
      units: (json['units'] as List)
          .map((u) => CurriculumUnit.fromJson(u as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CurriculumUnit {
  const CurriculumUnit({
    required this.id,
    required this.title,
    required this.nodes,
  });

  final String id;
  final String title;
  final List<CurriculumNode> nodes;

  factory CurriculumUnit.fromJson(Map<String, dynamic> json) {
    return CurriculumUnit(
      id: json['id'] as String,
      title: json['title'] as String,
      nodes: (json['nodes'] as List)
          .map((n) => CurriculumNode.fromJson(n as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CurriculumNode {
  const CurriculumNode({
    required this.id,
    required this.type,
    required this.title,
    required this.contentRefs,
  });

  final String id;
  final String type; // letter | vocab | reading | review | checkpoint
  final String title;
  final List<String> contentRefs;

  factory CurriculumNode.fromJson(Map<String, dynamic> json) {
    return CurriculumNode(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      contentRefs:
          (json['contentRefs'] as List? ?? const []).map((e) => e as String).toList(),
    );
  }
}

class LetterDto {
  const LetterDto({
    required this.id,
    required this.name,
    required this.isolated,
    required this.initialForm,
    required this.medialForm,
    required this.finalForm,
    required this.soundValue,
    this.similarGroup,
    this.exampleWord,
  });

  final String id;
  final String name;
  final String isolated;
  final String initialForm;
  final String medialForm;
  final String finalForm;
  final String soundValue;
  final String? similarGroup;
  final String? exampleWord;

  factory LetterDto.fromJson(Map<String, dynamic> json) {
    return LetterDto(
      id: json['id'] as String,
      name: json['name'] as String,
      isolated: json['isolated'] as String,
      initialForm: json['initial'] as String,
      medialForm: json['medial'] as String,
      finalForm: json['final'] as String,
      soundValue: json['soundValue'] as String,
      similarGroup: json['similarGroup'] as String?,
      exampleWord: json['exampleWord'] as String?,
    );
  }
}

class WordDto {
  const WordDto({
    required this.id,
    required this.ottoman,
    required this.transliteration,
    required this.meaningTr,
    required this.frequencyRank,
    required this.level,
    this.root,
    this.exampleSentence,
  });

  final String id;
  final String ottoman;
  final String transliteration;
  final String meaningTr;
  final int frequencyRank;
  final int level;
  final String? root;
  final String? exampleSentence;

  factory WordDto.fromJson(Map<String, dynamic> json) {
    return WordDto(
      id: json['id'] as String,
      ottoman: json['ottoman'] as String,
      transliteration: json['transliteration'] as String,
      meaningTr: json['meaningTr'] as String,
      frequencyRank: (json['frequencyRank'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      root: json['root'] as String?,
      exampleSentence: json['exampleSentence'] as String?,
    );
  }
}

class PassageDto {
  const PassageDto({
    required this.id,
    required this.title,
    required this.level,
    required this.genre,
    required this.lines,
    this.imageAssetPath,
  });

  final String id;
  final String title;
  final int level;
  final String genre;
  final String? imageAssetPath;
  final List<PassageLineDto> lines;

  factory PassageDto.fromJson(Map<String, dynamic> json) {
    return PassageDto(
      id: json['id'] as String,
      title: json['title'] as String,
      level: (json['level'] as num).toInt(),
      genre: json['genre'] as String,
      imageAssetPath: json['imageAssetPath'] as String?,
      lines: (json['lines'] as List)
          .map((l) => PassageLineDto.fromJson(l as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PassageLineDto {
  const PassageLineDto({
    required this.id,
    required this.ordinal,
    required this.ottoman,
    required this.transliteration,
    required this.simplifiedTr,
  });

  final String id;
  final int ordinal;
  final String ottoman;
  final String transliteration;
  final String simplifiedTr;

  factory PassageLineDto.fromJson(Map<String, dynamic> json) {
    return PassageLineDto(
      id: json['id'] as String,
      ordinal: (json['ordinal'] as num).toInt(),
      ottoman: json['ottoman'] as String,
      transliteration: json['transliteration'] as String,
      simplifiedTr: json['simplifiedTr'] as String,
    );
  }
}
