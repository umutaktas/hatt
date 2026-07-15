// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LettersTable extends Letters with TableInfo<$LettersTable, LetterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LettersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isolatedMeta =
      const VerificationMeta('isolated');
  @override
  late final GeneratedColumn<String> isolated = GeneratedColumn<String>(
      'isolated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _initialFormMeta =
      const VerificationMeta('initialForm');
  @override
  late final GeneratedColumn<String> initialForm = GeneratedColumn<String>(
      'initial_form', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medialFormMeta =
      const VerificationMeta('medialForm');
  @override
  late final GeneratedColumn<String> medialForm = GeneratedColumn<String>(
      'medial_form', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finalFormMeta =
      const VerificationMeta('finalForm');
  @override
  late final GeneratedColumn<String> finalForm = GeneratedColumn<String>(
      'final_form', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _similarGroupMeta =
      const VerificationMeta('similarGroup');
  @override
  late final GeneratedColumn<String> similarGroup = GeneratedColumn<String>(
      'similar_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _soundValueMeta =
      const VerificationMeta('soundValue');
  @override
  late final GeneratedColumn<String> soundValue = GeneratedColumn<String>(
      'sound_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exampleWordMeta =
      const VerificationMeta('exampleWord');
  @override
  late final GeneratedColumn<String> exampleWord = GeneratedColumn<String>(
      'example_word', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        isolated,
        initialForm,
        medialForm,
        finalForm,
        similarGroup,
        soundValue,
        exampleWord
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'letters';
  @override
  VerificationContext validateIntegrity(Insertable<LetterRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('isolated')) {
      context.handle(_isolatedMeta,
          isolated.isAcceptableOrUnknown(data['isolated']!, _isolatedMeta));
    } else if (isInserting) {
      context.missing(_isolatedMeta);
    }
    if (data.containsKey('initial_form')) {
      context.handle(
          _initialFormMeta,
          initialForm.isAcceptableOrUnknown(
              data['initial_form']!, _initialFormMeta));
    } else if (isInserting) {
      context.missing(_initialFormMeta);
    }
    if (data.containsKey('medial_form')) {
      context.handle(
          _medialFormMeta,
          medialForm.isAcceptableOrUnknown(
              data['medial_form']!, _medialFormMeta));
    } else if (isInserting) {
      context.missing(_medialFormMeta);
    }
    if (data.containsKey('final_form')) {
      context.handle(_finalFormMeta,
          finalForm.isAcceptableOrUnknown(data['final_form']!, _finalFormMeta));
    } else if (isInserting) {
      context.missing(_finalFormMeta);
    }
    if (data.containsKey('similar_group')) {
      context.handle(
          _similarGroupMeta,
          similarGroup.isAcceptableOrUnknown(
              data['similar_group']!, _similarGroupMeta));
    }
    if (data.containsKey('sound_value')) {
      context.handle(
          _soundValueMeta,
          soundValue.isAcceptableOrUnknown(
              data['sound_value']!, _soundValueMeta));
    } else if (isInserting) {
      context.missing(_soundValueMeta);
    }
    if (data.containsKey('example_word')) {
      context.handle(
          _exampleWordMeta,
          exampleWord.isAcceptableOrUnknown(
              data['example_word']!, _exampleWordMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LetterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LetterRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isolated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isolated'])!,
      initialForm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}initial_form'])!,
      medialForm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medial_form'])!,
      finalForm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}final_form'])!,
      similarGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}similar_group']),
      soundValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sound_value'])!,
      exampleWord: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example_word']),
    );
  }

  @override
  $LettersTable createAlias(String alias) {
    return $LettersTable(attachedDatabase, alias);
  }
}

class LetterRow extends DataClass implements Insertable<LetterRow> {
  final String id;
  final String name;
  final String isolated;
  final String initialForm;
  final String medialForm;
  final String finalForm;
  final String? similarGroup;
  final String soundValue;
  final String? exampleWord;
  const LetterRow(
      {required this.id,
      required this.name,
      required this.isolated,
      required this.initialForm,
      required this.medialForm,
      required this.finalForm,
      this.similarGroup,
      required this.soundValue,
      this.exampleWord});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['isolated'] = Variable<String>(isolated);
    map['initial_form'] = Variable<String>(initialForm);
    map['medial_form'] = Variable<String>(medialForm);
    map['final_form'] = Variable<String>(finalForm);
    if (!nullToAbsent || similarGroup != null) {
      map['similar_group'] = Variable<String>(similarGroup);
    }
    map['sound_value'] = Variable<String>(soundValue);
    if (!nullToAbsent || exampleWord != null) {
      map['example_word'] = Variable<String>(exampleWord);
    }
    return map;
  }

  LettersCompanion toCompanion(bool nullToAbsent) {
    return LettersCompanion(
      id: Value(id),
      name: Value(name),
      isolated: Value(isolated),
      initialForm: Value(initialForm),
      medialForm: Value(medialForm),
      finalForm: Value(finalForm),
      similarGroup: similarGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(similarGroup),
      soundValue: Value(soundValue),
      exampleWord: exampleWord == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleWord),
    );
  }

  factory LetterRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LetterRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isolated: serializer.fromJson<String>(json['isolated']),
      initialForm: serializer.fromJson<String>(json['initialForm']),
      medialForm: serializer.fromJson<String>(json['medialForm']),
      finalForm: serializer.fromJson<String>(json['finalForm']),
      similarGroup: serializer.fromJson<String?>(json['similarGroup']),
      soundValue: serializer.fromJson<String>(json['soundValue']),
      exampleWord: serializer.fromJson<String?>(json['exampleWord']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isolated': serializer.toJson<String>(isolated),
      'initialForm': serializer.toJson<String>(initialForm),
      'medialForm': serializer.toJson<String>(medialForm),
      'finalForm': serializer.toJson<String>(finalForm),
      'similarGroup': serializer.toJson<String?>(similarGroup),
      'soundValue': serializer.toJson<String>(soundValue),
      'exampleWord': serializer.toJson<String?>(exampleWord),
    };
  }

  LetterRow copyWith(
          {String? id,
          String? name,
          String? isolated,
          String? initialForm,
          String? medialForm,
          String? finalForm,
          Value<String?> similarGroup = const Value.absent(),
          String? soundValue,
          Value<String?> exampleWord = const Value.absent()}) =>
      LetterRow(
        id: id ?? this.id,
        name: name ?? this.name,
        isolated: isolated ?? this.isolated,
        initialForm: initialForm ?? this.initialForm,
        medialForm: medialForm ?? this.medialForm,
        finalForm: finalForm ?? this.finalForm,
        similarGroup:
            similarGroup.present ? similarGroup.value : this.similarGroup,
        soundValue: soundValue ?? this.soundValue,
        exampleWord: exampleWord.present ? exampleWord.value : this.exampleWord,
      );
  LetterRow copyWithCompanion(LettersCompanion data) {
    return LetterRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isolated: data.isolated.present ? data.isolated.value : this.isolated,
      initialForm:
          data.initialForm.present ? data.initialForm.value : this.initialForm,
      medialForm:
          data.medialForm.present ? data.medialForm.value : this.medialForm,
      finalForm: data.finalForm.present ? data.finalForm.value : this.finalForm,
      similarGroup: data.similarGroup.present
          ? data.similarGroup.value
          : this.similarGroup,
      soundValue:
          data.soundValue.present ? data.soundValue.value : this.soundValue,
      exampleWord:
          data.exampleWord.present ? data.exampleWord.value : this.exampleWord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LetterRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isolated: $isolated, ')
          ..write('initialForm: $initialForm, ')
          ..write('medialForm: $medialForm, ')
          ..write('finalForm: $finalForm, ')
          ..write('similarGroup: $similarGroup, ')
          ..write('soundValue: $soundValue, ')
          ..write('exampleWord: $exampleWord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isolated, initialForm, medialForm,
      finalForm, similarGroup, soundValue, exampleWord);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LetterRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.isolated == this.isolated &&
          other.initialForm == this.initialForm &&
          other.medialForm == this.medialForm &&
          other.finalForm == this.finalForm &&
          other.similarGroup == this.similarGroup &&
          other.soundValue == this.soundValue &&
          other.exampleWord == this.exampleWord);
}

class LettersCompanion extends UpdateCompanion<LetterRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> isolated;
  final Value<String> initialForm;
  final Value<String> medialForm;
  final Value<String> finalForm;
  final Value<String?> similarGroup;
  final Value<String> soundValue;
  final Value<String?> exampleWord;
  final Value<int> rowid;
  const LettersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isolated = const Value.absent(),
    this.initialForm = const Value.absent(),
    this.medialForm = const Value.absent(),
    this.finalForm = const Value.absent(),
    this.similarGroup = const Value.absent(),
    this.soundValue = const Value.absent(),
    this.exampleWord = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LettersCompanion.insert({
    required String id,
    required String name,
    required String isolated,
    required String initialForm,
    required String medialForm,
    required String finalForm,
    this.similarGroup = const Value.absent(),
    required String soundValue,
    this.exampleWord = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        isolated = Value(isolated),
        initialForm = Value(initialForm),
        medialForm = Value(medialForm),
        finalForm = Value(finalForm),
        soundValue = Value(soundValue);
  static Insertable<LetterRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? isolated,
    Expression<String>? initialForm,
    Expression<String>? medialForm,
    Expression<String>? finalForm,
    Expression<String>? similarGroup,
    Expression<String>? soundValue,
    Expression<String>? exampleWord,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isolated != null) 'isolated': isolated,
      if (initialForm != null) 'initial_form': initialForm,
      if (medialForm != null) 'medial_form': medialForm,
      if (finalForm != null) 'final_form': finalForm,
      if (similarGroup != null) 'similar_group': similarGroup,
      if (soundValue != null) 'sound_value': soundValue,
      if (exampleWord != null) 'example_word': exampleWord,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LettersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? isolated,
      Value<String>? initialForm,
      Value<String>? medialForm,
      Value<String>? finalForm,
      Value<String?>? similarGroup,
      Value<String>? soundValue,
      Value<String?>? exampleWord,
      Value<int>? rowid}) {
    return LettersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isolated: isolated ?? this.isolated,
      initialForm: initialForm ?? this.initialForm,
      medialForm: medialForm ?? this.medialForm,
      finalForm: finalForm ?? this.finalForm,
      similarGroup: similarGroup ?? this.similarGroup,
      soundValue: soundValue ?? this.soundValue,
      exampleWord: exampleWord ?? this.exampleWord,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isolated.present) {
      map['isolated'] = Variable<String>(isolated.value);
    }
    if (initialForm.present) {
      map['initial_form'] = Variable<String>(initialForm.value);
    }
    if (medialForm.present) {
      map['medial_form'] = Variable<String>(medialForm.value);
    }
    if (finalForm.present) {
      map['final_form'] = Variable<String>(finalForm.value);
    }
    if (similarGroup.present) {
      map['similar_group'] = Variable<String>(similarGroup.value);
    }
    if (soundValue.present) {
      map['sound_value'] = Variable<String>(soundValue.value);
    }
    if (exampleWord.present) {
      map['example_word'] = Variable<String>(exampleWord.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LettersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isolated: $isolated, ')
          ..write('initialForm: $initialForm, ')
          ..write('medialForm: $medialForm, ')
          ..write('finalForm: $finalForm, ')
          ..write('similarGroup: $similarGroup, ')
          ..write('soundValue: $soundValue, ')
          ..write('exampleWord: $exampleWord, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ottomanMeta =
      const VerificationMeta('ottoman');
  @override
  late final GeneratedColumn<String> ottoman = GeneratedColumn<String>(
      'ottoman', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transliterationMeta =
      const VerificationMeta('transliteration');
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
      'transliteration', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _meaningTrMeta =
      const VerificationMeta('meaningTr');
  @override
  late final GeneratedColumn<String> meaningTr = GeneratedColumn<String>(
      'meaning_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rootMeta = const VerificationMeta('root');
  @override
  late final GeneratedColumn<String> root = GeneratedColumn<String>(
      'root', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _frequencyRankMeta =
      const VerificationMeta('frequencyRank');
  @override
  late final GeneratedColumn<int> frequencyRank = GeneratedColumn<int>(
      'frequency_rank', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _exampleSentenceMeta =
      const VerificationMeta('exampleSentence');
  @override
  late final GeneratedColumn<String> exampleSentence = GeneratedColumn<String>(
      'example_sentence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ottoman,
        transliteration,
        meaningTr,
        root,
        frequencyRank,
        level,
        exampleSentence
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(Insertable<WordRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ottoman')) {
      context.handle(_ottomanMeta,
          ottoman.isAcceptableOrUnknown(data['ottoman']!, _ottomanMeta));
    } else if (isInserting) {
      context.missing(_ottomanMeta);
    }
    if (data.containsKey('transliteration')) {
      context.handle(
          _transliterationMeta,
          transliteration.isAcceptableOrUnknown(
              data['transliteration']!, _transliterationMeta));
    } else if (isInserting) {
      context.missing(_transliterationMeta);
    }
    if (data.containsKey('meaning_tr')) {
      context.handle(_meaningTrMeta,
          meaningTr.isAcceptableOrUnknown(data['meaning_tr']!, _meaningTrMeta));
    } else if (isInserting) {
      context.missing(_meaningTrMeta);
    }
    if (data.containsKey('root')) {
      context.handle(
          _rootMeta, root.isAcceptableOrUnknown(data['root']!, _rootMeta));
    }
    if (data.containsKey('frequency_rank')) {
      context.handle(
          _frequencyRankMeta,
          frequencyRank.isAcceptableOrUnknown(
              data['frequency_rank']!, _frequencyRankMeta));
    } else if (isInserting) {
      context.missing(_frequencyRankMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('example_sentence')) {
      context.handle(
          _exampleSentenceMeta,
          exampleSentence.isAcceptableOrUnknown(
              data['example_sentence']!, _exampleSentenceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ottoman: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ottoman'])!,
      transliteration: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transliteration'])!,
      meaningTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning_tr'])!,
      root: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}root']),
      frequencyRank: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}frequency_rank'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      exampleSentence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}example_sentence']),
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final String id;
  final String ottoman;
  final String transliteration;
  final String meaningTr;
  final String? root;
  final int frequencyRank;
  final int level;
  final String? exampleSentence;
  const WordRow(
      {required this.id,
      required this.ottoman,
      required this.transliteration,
      required this.meaningTr,
      this.root,
      required this.frequencyRank,
      required this.level,
      this.exampleSentence});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ottoman'] = Variable<String>(ottoman);
    map['transliteration'] = Variable<String>(transliteration);
    map['meaning_tr'] = Variable<String>(meaningTr);
    if (!nullToAbsent || root != null) {
      map['root'] = Variable<String>(root);
    }
    map['frequency_rank'] = Variable<int>(frequencyRank);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || exampleSentence != null) {
      map['example_sentence'] = Variable<String>(exampleSentence);
    }
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      ottoman: Value(ottoman),
      transliteration: Value(transliteration),
      meaningTr: Value(meaningTr),
      root: root == null && nullToAbsent ? const Value.absent() : Value(root),
      frequencyRank: Value(frequencyRank),
      level: Value(level),
      exampleSentence: exampleSentence == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleSentence),
    );
  }

  factory WordRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      id: serializer.fromJson<String>(json['id']),
      ottoman: serializer.fromJson<String>(json['ottoman']),
      transliteration: serializer.fromJson<String>(json['transliteration']),
      meaningTr: serializer.fromJson<String>(json['meaningTr']),
      root: serializer.fromJson<String?>(json['root']),
      frequencyRank: serializer.fromJson<int>(json['frequencyRank']),
      level: serializer.fromJson<int>(json['level']),
      exampleSentence: serializer.fromJson<String?>(json['exampleSentence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ottoman': serializer.toJson<String>(ottoman),
      'transliteration': serializer.toJson<String>(transliteration),
      'meaningTr': serializer.toJson<String>(meaningTr),
      'root': serializer.toJson<String?>(root),
      'frequencyRank': serializer.toJson<int>(frequencyRank),
      'level': serializer.toJson<int>(level),
      'exampleSentence': serializer.toJson<String?>(exampleSentence),
    };
  }

  WordRow copyWith(
          {String? id,
          String? ottoman,
          String? transliteration,
          String? meaningTr,
          Value<String?> root = const Value.absent(),
          int? frequencyRank,
          int? level,
          Value<String?> exampleSentence = const Value.absent()}) =>
      WordRow(
        id: id ?? this.id,
        ottoman: ottoman ?? this.ottoman,
        transliteration: transliteration ?? this.transliteration,
        meaningTr: meaningTr ?? this.meaningTr,
        root: root.present ? root.value : this.root,
        frequencyRank: frequencyRank ?? this.frequencyRank,
        level: level ?? this.level,
        exampleSentence: exampleSentence.present
            ? exampleSentence.value
            : this.exampleSentence,
      );
  WordRow copyWithCompanion(WordsCompanion data) {
    return WordRow(
      id: data.id.present ? data.id.value : this.id,
      ottoman: data.ottoman.present ? data.ottoman.value : this.ottoman,
      transliteration: data.transliteration.present
          ? data.transliteration.value
          : this.transliteration,
      meaningTr: data.meaningTr.present ? data.meaningTr.value : this.meaningTr,
      root: data.root.present ? data.root.value : this.root,
      frequencyRank: data.frequencyRank.present
          ? data.frequencyRank.value
          : this.frequencyRank,
      level: data.level.present ? data.level.value : this.level,
      exampleSentence: data.exampleSentence.present
          ? data.exampleSentence.value
          : this.exampleSentence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('id: $id, ')
          ..write('ottoman: $ottoman, ')
          ..write('transliteration: $transliteration, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('root: $root, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('level: $level, ')
          ..write('exampleSentence: $exampleSentence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ottoman, transliteration, meaningTr, root,
      frequencyRank, level, exampleSentence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.id == this.id &&
          other.ottoman == this.ottoman &&
          other.transliteration == this.transliteration &&
          other.meaningTr == this.meaningTr &&
          other.root == this.root &&
          other.frequencyRank == this.frequencyRank &&
          other.level == this.level &&
          other.exampleSentence == this.exampleSentence);
}

class WordsCompanion extends UpdateCompanion<WordRow> {
  final Value<String> id;
  final Value<String> ottoman;
  final Value<String> transliteration;
  final Value<String> meaningTr;
  final Value<String?> root;
  final Value<int> frequencyRank;
  final Value<int> level;
  final Value<String?> exampleSentence;
  final Value<int> rowid;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.ottoman = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.meaningTr = const Value.absent(),
    this.root = const Value.absent(),
    this.frequencyRank = const Value.absent(),
    this.level = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordsCompanion.insert({
    required String id,
    required String ottoman,
    required String transliteration,
    required String meaningTr,
    this.root = const Value.absent(),
    required int frequencyRank,
    required int level,
    this.exampleSentence = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ottoman = Value(ottoman),
        transliteration = Value(transliteration),
        meaningTr = Value(meaningTr),
        frequencyRank = Value(frequencyRank),
        level = Value(level);
  static Insertable<WordRow> custom({
    Expression<String>? id,
    Expression<String>? ottoman,
    Expression<String>? transliteration,
    Expression<String>? meaningTr,
    Expression<String>? root,
    Expression<int>? frequencyRank,
    Expression<int>? level,
    Expression<String>? exampleSentence,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ottoman != null) 'ottoman': ottoman,
      if (transliteration != null) 'transliteration': transliteration,
      if (meaningTr != null) 'meaning_tr': meaningTr,
      if (root != null) 'root': root,
      if (frequencyRank != null) 'frequency_rank': frequencyRank,
      if (level != null) 'level': level,
      if (exampleSentence != null) 'example_sentence': exampleSentence,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ottoman,
      Value<String>? transliteration,
      Value<String>? meaningTr,
      Value<String?>? root,
      Value<int>? frequencyRank,
      Value<int>? level,
      Value<String?>? exampleSentence,
      Value<int>? rowid}) {
    return WordsCompanion(
      id: id ?? this.id,
      ottoman: ottoman ?? this.ottoman,
      transliteration: transliteration ?? this.transliteration,
      meaningTr: meaningTr ?? this.meaningTr,
      root: root ?? this.root,
      frequencyRank: frequencyRank ?? this.frequencyRank,
      level: level ?? this.level,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ottoman.present) {
      map['ottoman'] = Variable<String>(ottoman.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (meaningTr.present) {
      map['meaning_tr'] = Variable<String>(meaningTr.value);
    }
    if (root.present) {
      map['root'] = Variable<String>(root.value);
    }
    if (frequencyRank.present) {
      map['frequency_rank'] = Variable<int>(frequencyRank.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (exampleSentence.present) {
      map['example_sentence'] = Variable<String>(exampleSentence.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('ottoman: $ottoman, ')
          ..write('transliteration: $transliteration, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('root: $root, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('level: $level, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingPassagesTable extends ReadingPassages
    with TableInfo<$ReadingPassagesTable, ReadingPassageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingPassagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageAssetPathMeta =
      const VerificationMeta('imageAssetPath');
  @override
  late final GeneratedColumn<String> imageAssetPath = GeneratedColumn<String>(
      'image_asset_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, level, genre, imageAssetPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_passages';
  @override
  VerificationContext validateIntegrity(Insertable<ReadingPassageRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('image_asset_path')) {
      context.handle(
          _imageAssetPathMeta,
          imageAssetPath.isAcceptableOrUnknown(
              data['image_asset_path']!, _imageAssetPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingPassageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingPassageRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre'])!,
      imageAssetPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}image_asset_path']),
    );
  }

  @override
  $ReadingPassagesTable createAlias(String alias) {
    return $ReadingPassagesTable(attachedDatabase, alias);
  }
}

class ReadingPassageRow extends DataClass
    implements Insertable<ReadingPassageRow> {
  final String id;
  final String title;
  final int level;
  final String genre;
  final String? imageAssetPath;
  const ReadingPassageRow(
      {required this.id,
      required this.title,
      required this.level,
      required this.genre,
      this.imageAssetPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['level'] = Variable<int>(level);
    map['genre'] = Variable<String>(genre);
    if (!nullToAbsent || imageAssetPath != null) {
      map['image_asset_path'] = Variable<String>(imageAssetPath);
    }
    return map;
  }

  ReadingPassagesCompanion toCompanion(bool nullToAbsent) {
    return ReadingPassagesCompanion(
      id: Value(id),
      title: Value(title),
      level: Value(level),
      genre: Value(genre),
      imageAssetPath: imageAssetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAssetPath),
    );
  }

  factory ReadingPassageRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingPassageRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      level: serializer.fromJson<int>(json['level']),
      genre: serializer.fromJson<String>(json['genre']),
      imageAssetPath: serializer.fromJson<String?>(json['imageAssetPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'level': serializer.toJson<int>(level),
      'genre': serializer.toJson<String>(genre),
      'imageAssetPath': serializer.toJson<String?>(imageAssetPath),
    };
  }

  ReadingPassageRow copyWith(
          {String? id,
          String? title,
          int? level,
          String? genre,
          Value<String?> imageAssetPath = const Value.absent()}) =>
      ReadingPassageRow(
        id: id ?? this.id,
        title: title ?? this.title,
        level: level ?? this.level,
        genre: genre ?? this.genre,
        imageAssetPath:
            imageAssetPath.present ? imageAssetPath.value : this.imageAssetPath,
      );
  ReadingPassageRow copyWithCompanion(ReadingPassagesCompanion data) {
    return ReadingPassageRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      level: data.level.present ? data.level.value : this.level,
      genre: data.genre.present ? data.genre.value : this.genre,
      imageAssetPath: data.imageAssetPath.present
          ? data.imageAssetPath.value
          : this.imageAssetPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPassageRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('genre: $genre, ')
          ..write('imageAssetPath: $imageAssetPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, level, genre, imageAssetPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingPassageRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.level == this.level &&
          other.genre == this.genre &&
          other.imageAssetPath == this.imageAssetPath);
}

class ReadingPassagesCompanion extends UpdateCompanion<ReadingPassageRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> level;
  final Value<String> genre;
  final Value<String?> imageAssetPath;
  final Value<int> rowid;
  const ReadingPassagesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.level = const Value.absent(),
    this.genre = const Value.absent(),
    this.imageAssetPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingPassagesCompanion.insert({
    required String id,
    required String title,
    required int level,
    required String genre,
    this.imageAssetPath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        level = Value(level),
        genre = Value(genre);
  static Insertable<ReadingPassageRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? level,
    Expression<String>? genre,
    Expression<String>? imageAssetPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (level != null) 'level': level,
      if (genre != null) 'genre': genre,
      if (imageAssetPath != null) 'image_asset_path': imageAssetPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingPassagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<int>? level,
      Value<String>? genre,
      Value<String?>? imageAssetPath,
      Value<int>? rowid}) {
    return ReadingPassagesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      level: level ?? this.level,
      genre: genre ?? this.genre,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (imageAssetPath.present) {
      map['image_asset_path'] = Variable<String>(imageAssetPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingPassagesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('genre: $genre, ')
          ..write('imageAssetPath: $imageAssetPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PassageLinesTable extends PassageLines
    with TableInfo<$PassageLinesTable, PassageLineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PassageLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passageIdMeta =
      const VerificationMeta('passageId');
  @override
  late final GeneratedColumn<String> passageId = GeneratedColumn<String>(
      'passage_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ordinalMeta =
      const VerificationMeta('ordinal');
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
      'ordinal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ottomanMeta =
      const VerificationMeta('ottoman');
  @override
  late final GeneratedColumn<String> ottoman = GeneratedColumn<String>(
      'ottoman', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transliterationMeta =
      const VerificationMeta('transliteration');
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
      'transliteration', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _simplifiedTrMeta =
      const VerificationMeta('simplifiedTr');
  @override
  late final GeneratedColumn<String> simplifiedTr = GeneratedColumn<String>(
      'simplified_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, passageId, ordinal, ottoman, transliteration, simplifiedTr];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'passage_lines';
  @override
  VerificationContext validateIntegrity(Insertable<PassageLineRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('passage_id')) {
      context.handle(_passageIdMeta,
          passageId.isAcceptableOrUnknown(data['passage_id']!, _passageIdMeta));
    } else if (isInserting) {
      context.missing(_passageIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(_ordinalMeta,
          ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta));
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('ottoman')) {
      context.handle(_ottomanMeta,
          ottoman.isAcceptableOrUnknown(data['ottoman']!, _ottomanMeta));
    } else if (isInserting) {
      context.missing(_ottomanMeta);
    }
    if (data.containsKey('transliteration')) {
      context.handle(
          _transliterationMeta,
          transliteration.isAcceptableOrUnknown(
              data['transliteration']!, _transliterationMeta));
    } else if (isInserting) {
      context.missing(_transliterationMeta);
    }
    if (data.containsKey('simplified_tr')) {
      context.handle(
          _simplifiedTrMeta,
          simplifiedTr.isAcceptableOrUnknown(
              data['simplified_tr']!, _simplifiedTrMeta));
    } else if (isInserting) {
      context.missing(_simplifiedTrMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PassageLineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PassageLineRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      passageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}passage_id'])!,
      ordinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordinal'])!,
      ottoman: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ottoman'])!,
      transliteration: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transliteration'])!,
      simplifiedTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}simplified_tr'])!,
    );
  }

  @override
  $PassageLinesTable createAlias(String alias) {
    return $PassageLinesTable(attachedDatabase, alias);
  }
}

class PassageLineRow extends DataClass implements Insertable<PassageLineRow> {
  final String id;
  final String passageId;
  final int ordinal;
  final String ottoman;
  final String transliteration;
  final String simplifiedTr;
  const PassageLineRow(
      {required this.id,
      required this.passageId,
      required this.ordinal,
      required this.ottoman,
      required this.transliteration,
      required this.simplifiedTr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['passage_id'] = Variable<String>(passageId);
    map['ordinal'] = Variable<int>(ordinal);
    map['ottoman'] = Variable<String>(ottoman);
    map['transliteration'] = Variable<String>(transliteration);
    map['simplified_tr'] = Variable<String>(simplifiedTr);
    return map;
  }

  PassageLinesCompanion toCompanion(bool nullToAbsent) {
    return PassageLinesCompanion(
      id: Value(id),
      passageId: Value(passageId),
      ordinal: Value(ordinal),
      ottoman: Value(ottoman),
      transliteration: Value(transliteration),
      simplifiedTr: Value(simplifiedTr),
    );
  }

  factory PassageLineRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PassageLineRow(
      id: serializer.fromJson<String>(json['id']),
      passageId: serializer.fromJson<String>(json['passageId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      ottoman: serializer.fromJson<String>(json['ottoman']),
      transliteration: serializer.fromJson<String>(json['transliteration']),
      simplifiedTr: serializer.fromJson<String>(json['simplifiedTr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'passageId': serializer.toJson<String>(passageId),
      'ordinal': serializer.toJson<int>(ordinal),
      'ottoman': serializer.toJson<String>(ottoman),
      'transliteration': serializer.toJson<String>(transliteration),
      'simplifiedTr': serializer.toJson<String>(simplifiedTr),
    };
  }

  PassageLineRow copyWith(
          {String? id,
          String? passageId,
          int? ordinal,
          String? ottoman,
          String? transliteration,
          String? simplifiedTr}) =>
      PassageLineRow(
        id: id ?? this.id,
        passageId: passageId ?? this.passageId,
        ordinal: ordinal ?? this.ordinal,
        ottoman: ottoman ?? this.ottoman,
        transliteration: transliteration ?? this.transliteration,
        simplifiedTr: simplifiedTr ?? this.simplifiedTr,
      );
  PassageLineRow copyWithCompanion(PassageLinesCompanion data) {
    return PassageLineRow(
      id: data.id.present ? data.id.value : this.id,
      passageId: data.passageId.present ? data.passageId.value : this.passageId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      ottoman: data.ottoman.present ? data.ottoman.value : this.ottoman,
      transliteration: data.transliteration.present
          ? data.transliteration.value
          : this.transliteration,
      simplifiedTr: data.simplifiedTr.present
          ? data.simplifiedTr.value
          : this.simplifiedTr,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PassageLineRow(')
          ..write('id: $id, ')
          ..write('passageId: $passageId, ')
          ..write('ordinal: $ordinal, ')
          ..write('ottoman: $ottoman, ')
          ..write('transliteration: $transliteration, ')
          ..write('simplifiedTr: $simplifiedTr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, passageId, ordinal, ottoman, transliteration, simplifiedTr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PassageLineRow &&
          other.id == this.id &&
          other.passageId == this.passageId &&
          other.ordinal == this.ordinal &&
          other.ottoman == this.ottoman &&
          other.transliteration == this.transliteration &&
          other.simplifiedTr == this.simplifiedTr);
}

class PassageLinesCompanion extends UpdateCompanion<PassageLineRow> {
  final Value<String> id;
  final Value<String> passageId;
  final Value<int> ordinal;
  final Value<String> ottoman;
  final Value<String> transliteration;
  final Value<String> simplifiedTr;
  final Value<int> rowid;
  const PassageLinesCompanion({
    this.id = const Value.absent(),
    this.passageId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.ottoman = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.simplifiedTr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PassageLinesCompanion.insert({
    required String id,
    required String passageId,
    required int ordinal,
    required String ottoman,
    required String transliteration,
    required String simplifiedTr,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        passageId = Value(passageId),
        ordinal = Value(ordinal),
        ottoman = Value(ottoman),
        transliteration = Value(transliteration),
        simplifiedTr = Value(simplifiedTr);
  static Insertable<PassageLineRow> custom({
    Expression<String>? id,
    Expression<String>? passageId,
    Expression<int>? ordinal,
    Expression<String>? ottoman,
    Expression<String>? transliteration,
    Expression<String>? simplifiedTr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (passageId != null) 'passage_id': passageId,
      if (ordinal != null) 'ordinal': ordinal,
      if (ottoman != null) 'ottoman': ottoman,
      if (transliteration != null) 'transliteration': transliteration,
      if (simplifiedTr != null) 'simplified_tr': simplifiedTr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PassageLinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? passageId,
      Value<int>? ordinal,
      Value<String>? ottoman,
      Value<String>? transliteration,
      Value<String>? simplifiedTr,
      Value<int>? rowid}) {
    return PassageLinesCompanion(
      id: id ?? this.id,
      passageId: passageId ?? this.passageId,
      ordinal: ordinal ?? this.ordinal,
      ottoman: ottoman ?? this.ottoman,
      transliteration: transliteration ?? this.transliteration,
      simplifiedTr: simplifiedTr ?? this.simplifiedTr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (passageId.present) {
      map['passage_id'] = Variable<String>(passageId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (ottoman.present) {
      map['ottoman'] = Variable<String>(ottoman.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (simplifiedTr.present) {
      map['simplified_tr'] = Variable<String>(simplifiedTr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PassageLinesCompanion(')
          ..write('id: $id, ')
          ..write('passageId: $passageId, ')
          ..write('ordinal: $ordinal, ')
          ..write('ottoman: $ottoman, ')
          ..write('transliteration: $transliteration, ')
          ..write('simplifiedTr: $simplifiedTr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurriculumNodesTable extends CurriculumNodes
    with TableInfo<$CurriculumNodesTable, CurriculumNodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurriculumNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitTitleMeta =
      const VerificationMeta('unitTitle');
  @override
  late final GeneratedColumn<String> unitTitle = GeneratedColumn<String>(
      'unit_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ordinalMeta =
      const VerificationMeta('ordinal');
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
      'ordinal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentRefsMeta =
      const VerificationMeta('contentRefs');
  @override
  late final GeneratedColumn<String> contentRefs = GeneratedColumn<String>(
      'content_refs', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, unitId, unitTitle, ordinal, title, contentRefs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'curriculum_nodes';
  @override
  VerificationContext validateIntegrity(Insertable<CurriculumNodeRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('unit_title')) {
      context.handle(_unitTitleMeta,
          unitTitle.isAcceptableOrUnknown(data['unit_title']!, _unitTitleMeta));
    } else if (isInserting) {
      context.missing(_unitTitleMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(_ordinalMeta,
          ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta));
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content_refs')) {
      context.handle(
          _contentRefsMeta,
          contentRefs.isAcceptableOrUnknown(
              data['content_refs']!, _contentRefsMeta));
    } else if (isInserting) {
      context.missing(_contentRefsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurriculumNodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurriculumNodeRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_id'])!,
      unitTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_title'])!,
      ordinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordinal'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      contentRefs: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_refs'])!,
    );
  }

  @override
  $CurriculumNodesTable createAlias(String alias) {
    return $CurriculumNodesTable(attachedDatabase, alias);
  }
}

class CurriculumNodeRow extends DataClass
    implements Insertable<CurriculumNodeRow> {
  final String id;
  final String type;
  final String unitId;
  final String unitTitle;
  final int ordinal;
  final String title;
  final String contentRefs;
  const CurriculumNodeRow(
      {required this.id,
      required this.type,
      required this.unitId,
      required this.unitTitle,
      required this.ordinal,
      required this.title,
      required this.contentRefs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['unit_id'] = Variable<String>(unitId);
    map['unit_title'] = Variable<String>(unitTitle);
    map['ordinal'] = Variable<int>(ordinal);
    map['title'] = Variable<String>(title);
    map['content_refs'] = Variable<String>(contentRefs);
    return map;
  }

  CurriculumNodesCompanion toCompanion(bool nullToAbsent) {
    return CurriculumNodesCompanion(
      id: Value(id),
      type: Value(type),
      unitId: Value(unitId),
      unitTitle: Value(unitTitle),
      ordinal: Value(ordinal),
      title: Value(title),
      contentRefs: Value(contentRefs),
    );
  }

  factory CurriculumNodeRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurriculumNodeRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      unitId: serializer.fromJson<String>(json['unitId']),
      unitTitle: serializer.fromJson<String>(json['unitTitle']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      title: serializer.fromJson<String>(json['title']),
      contentRefs: serializer.fromJson<String>(json['contentRefs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'unitId': serializer.toJson<String>(unitId),
      'unitTitle': serializer.toJson<String>(unitTitle),
      'ordinal': serializer.toJson<int>(ordinal),
      'title': serializer.toJson<String>(title),
      'contentRefs': serializer.toJson<String>(contentRefs),
    };
  }

  CurriculumNodeRow copyWith(
          {String? id,
          String? type,
          String? unitId,
          String? unitTitle,
          int? ordinal,
          String? title,
          String? contentRefs}) =>
      CurriculumNodeRow(
        id: id ?? this.id,
        type: type ?? this.type,
        unitId: unitId ?? this.unitId,
        unitTitle: unitTitle ?? this.unitTitle,
        ordinal: ordinal ?? this.ordinal,
        title: title ?? this.title,
        contentRefs: contentRefs ?? this.contentRefs,
      );
  CurriculumNodeRow copyWithCompanion(CurriculumNodesCompanion data) {
    return CurriculumNodeRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      unitTitle: data.unitTitle.present ? data.unitTitle.value : this.unitTitle,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      title: data.title.present ? data.title.value : this.title,
      contentRefs:
          data.contentRefs.present ? data.contentRefs.value : this.contentRefs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurriculumNodeRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('unitId: $unitId, ')
          ..write('unitTitle: $unitTitle, ')
          ..write('ordinal: $ordinal, ')
          ..write('title: $title, ')
          ..write('contentRefs: $contentRefs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, unitId, unitTitle, ordinal, title, contentRefs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurriculumNodeRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.unitId == this.unitId &&
          other.unitTitle == this.unitTitle &&
          other.ordinal == this.ordinal &&
          other.title == this.title &&
          other.contentRefs == this.contentRefs);
}

class CurriculumNodesCompanion extends UpdateCompanion<CurriculumNodeRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> unitId;
  final Value<String> unitTitle;
  final Value<int> ordinal;
  final Value<String> title;
  final Value<String> contentRefs;
  final Value<int> rowid;
  const CurriculumNodesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.unitId = const Value.absent(),
    this.unitTitle = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.title = const Value.absent(),
    this.contentRefs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurriculumNodesCompanion.insert({
    required String id,
    required String type,
    required String unitId,
    required String unitTitle,
    required int ordinal,
    required String title,
    required String contentRefs,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        unitId = Value(unitId),
        unitTitle = Value(unitTitle),
        ordinal = Value(ordinal),
        title = Value(title),
        contentRefs = Value(contentRefs);
  static Insertable<CurriculumNodeRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? unitId,
    Expression<String>? unitTitle,
    Expression<int>? ordinal,
    Expression<String>? title,
    Expression<String>? contentRefs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (unitId != null) 'unit_id': unitId,
      if (unitTitle != null) 'unit_title': unitTitle,
      if (ordinal != null) 'ordinal': ordinal,
      if (title != null) 'title': title,
      if (contentRefs != null) 'content_refs': contentRefs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurriculumNodesCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String>? unitId,
      Value<String>? unitTitle,
      Value<int>? ordinal,
      Value<String>? title,
      Value<String>? contentRefs,
      Value<int>? rowid}) {
    return CurriculumNodesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      unitId: unitId ?? this.unitId,
      unitTitle: unitTitle ?? this.unitTitle,
      ordinal: ordinal ?? this.ordinal,
      title: title ?? this.title,
      contentRefs: contentRefs ?? this.contentRefs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (unitTitle.present) {
      map['unit_title'] = Variable<String>(unitTitle.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentRefs.present) {
      map['content_refs'] = Variable<String>(contentRefs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurriculumNodesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('unitId: $unitId, ')
          ..write('unitTitle: $unitTitle, ')
          ..write('ordinal: $ordinal, ')
          ..write('title: $title, ')
          ..write('contentRefs: $contentRefs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NodeProgressTable extends NodeProgress
    with TableInfo<$NodeProgressTable, NodeProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NodeProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
      'node_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
      'stars', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _bestScoreMeta =
      const VerificationMeta('bestScore');
  @override
  late final GeneratedColumn<int> bestScore = GeneratedColumn<int>(
      'best_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [nodeId, status, stars, bestScore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'node_progress';
  @override
  VerificationContext validateIntegrity(Insertable<NodeProgressRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('node_id')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta));
    } else if (isInserting) {
      context.missing(_nodeIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('stars')) {
      context.handle(
          _starsMeta, stars.isAcceptableOrUnknown(data['stars']!, _starsMeta));
    }
    if (data.containsKey('best_score')) {
      context.handle(_bestScoreMeta,
          bestScore.isAcceptableOrUnknown(data['best_score']!, _bestScoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {nodeId};
  @override
  NodeProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NodeProgressRow(
      nodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}node_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      stars: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stars'])!,
      bestScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}best_score'])!,
    );
  }

  @override
  $NodeProgressTable createAlias(String alias) {
    return $NodeProgressTable(attachedDatabase, alias);
  }
}

class NodeProgressRow extends DataClass implements Insertable<NodeProgressRow> {
  final String nodeId;
  final String status;
  final int stars;
  final int bestScore;
  const NodeProgressRow(
      {required this.nodeId,
      required this.status,
      required this.stars,
      required this.bestScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['node_id'] = Variable<String>(nodeId);
    map['status'] = Variable<String>(status);
    map['stars'] = Variable<int>(stars);
    map['best_score'] = Variable<int>(bestScore);
    return map;
  }

  NodeProgressCompanion toCompanion(bool nullToAbsent) {
    return NodeProgressCompanion(
      nodeId: Value(nodeId),
      status: Value(status),
      stars: Value(stars),
      bestScore: Value(bestScore),
    );
  }

  factory NodeProgressRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NodeProgressRow(
      nodeId: serializer.fromJson<String>(json['nodeId']),
      status: serializer.fromJson<String>(json['status']),
      stars: serializer.fromJson<int>(json['stars']),
      bestScore: serializer.fromJson<int>(json['bestScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'nodeId': serializer.toJson<String>(nodeId),
      'status': serializer.toJson<String>(status),
      'stars': serializer.toJson<int>(stars),
      'bestScore': serializer.toJson<int>(bestScore),
    };
  }

  NodeProgressRow copyWith(
          {String? nodeId, String? status, int? stars, int? bestScore}) =>
      NodeProgressRow(
        nodeId: nodeId ?? this.nodeId,
        status: status ?? this.status,
        stars: stars ?? this.stars,
        bestScore: bestScore ?? this.bestScore,
      );
  NodeProgressRow copyWithCompanion(NodeProgressCompanion data) {
    return NodeProgressRow(
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      status: data.status.present ? data.status.value : this.status,
      stars: data.stars.present ? data.stars.value : this.stars,
      bestScore: data.bestScore.present ? data.bestScore.value : this.bestScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NodeProgressRow(')
          ..write('nodeId: $nodeId, ')
          ..write('status: $status, ')
          ..write('stars: $stars, ')
          ..write('bestScore: $bestScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(nodeId, status, stars, bestScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeProgressRow &&
          other.nodeId == this.nodeId &&
          other.status == this.status &&
          other.stars == this.stars &&
          other.bestScore == this.bestScore);
}

class NodeProgressCompanion extends UpdateCompanion<NodeProgressRow> {
  final Value<String> nodeId;
  final Value<String> status;
  final Value<int> stars;
  final Value<int> bestScore;
  final Value<int> rowid;
  const NodeProgressCompanion({
    this.nodeId = const Value.absent(),
    this.status = const Value.absent(),
    this.stars = const Value.absent(),
    this.bestScore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NodeProgressCompanion.insert({
    required String nodeId,
    required String status,
    this.stars = const Value.absent(),
    this.bestScore = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : nodeId = Value(nodeId),
        status = Value(status);
  static Insertable<NodeProgressRow> custom({
    Expression<String>? nodeId,
    Expression<String>? status,
    Expression<int>? stars,
    Expression<int>? bestScore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (nodeId != null) 'node_id': nodeId,
      if (status != null) 'status': status,
      if (stars != null) 'stars': stars,
      if (bestScore != null) 'best_score': bestScore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NodeProgressCompanion copyWith(
      {Value<String>? nodeId,
      Value<String>? status,
      Value<int>? stars,
      Value<int>? bestScore,
      Value<int>? rowid}) {
    return NodeProgressCompanion(
      nodeId: nodeId ?? this.nodeId,
      status: status ?? this.status,
      stars: stars ?? this.stars,
      bestScore: bestScore ?? this.bestScore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (bestScore.present) {
      map['best_score'] = Variable<int>(bestScore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodeProgressCompanion(')
          ..write('nodeId: $nodeId, ')
          ..write('status: $status, ')
          ..write('stars: $stars, ')
          ..write('bestScore: $bestScore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewStatesTable extends ReviewStates
    with TableInfo<$ReviewStatesTable, ReviewStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemKeyMeta =
      const VerificationMeta('itemKey');
  @override
  late final GeneratedColumn<String> itemKey = GeneratedColumn<String>(
      'item_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemTypeMeta =
      const VerificationMeta('itemType');
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
      'item_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stabilityMeta =
      const VerificationMeta('stability');
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
      'stability', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime> due = GeneratedColumn<DateTime>(
      'due', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastReviewMeta =
      const VerificationMeta('lastReview');
  @override
  late final GeneratedColumn<DateTime> lastReview = GeneratedColumn<DateTime>(
      'last_review', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
      'lapses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<String> phase = GeneratedColumn<String>(
      'phase', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('newCard'));
  @override
  List<GeneratedColumn> get $columns => [
        itemKey,
        itemType,
        stability,
        difficulty,
        due,
        lastReview,
        reps,
        lapses,
        phase
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_states';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewStateRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_key')) {
      context.handle(_itemKeyMeta,
          itemKey.isAcceptableOrUnknown(data['item_key']!, _itemKeyMeta));
    } else if (isInserting) {
      context.missing(_itemKeyMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(_itemTypeMeta,
          itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta));
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('stability')) {
      context.handle(_stabilityMeta,
          stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('due')) {
      context.handle(
          _dueMeta, due.isAcceptableOrUnknown(data['due']!, _dueMeta));
    }
    if (data.containsKey('last_review')) {
      context.handle(
          _lastReviewMeta,
          lastReview.isAcceptableOrUnknown(
              data['last_review']!, _lastReviewMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('lapses')) {
      context.handle(_lapsesMeta,
          lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta));
    }
    if (data.containsKey('phase')) {
      context.handle(
          _phaseMeta, phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemKey};
  @override
  ReviewStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewStateRow(
      itemKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_key'])!,
      itemType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_type'])!,
      stability: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stability'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty'])!,
      due: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due']),
      lastReview: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_review']),
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      lapses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lapses'])!,
      phase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phase'])!,
    );
  }

  @override
  $ReviewStatesTable createAlias(String alias) {
    return $ReviewStatesTable(attachedDatabase, alias);
  }
}

class ReviewStateRow extends DataClass implements Insertable<ReviewStateRow> {
  /// Composite key like `word:istanbul` or `letter:be`.
  final String itemKey;
  final String itemType;
  final double stability;
  final double difficulty;
  final DateTime? due;
  final DateTime? lastReview;
  final int reps;
  final int lapses;
  final String phase;
  const ReviewStateRow(
      {required this.itemKey,
      required this.itemType,
      required this.stability,
      required this.difficulty,
      this.due,
      this.lastReview,
      required this.reps,
      required this.lapses,
      required this.phase});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_key'] = Variable<String>(itemKey);
    map['item_type'] = Variable<String>(itemType);
    map['stability'] = Variable<double>(stability);
    map['difficulty'] = Variable<double>(difficulty);
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<DateTime>(due);
    }
    if (!nullToAbsent || lastReview != null) {
      map['last_review'] = Variable<DateTime>(lastReview);
    }
    map['reps'] = Variable<int>(reps);
    map['lapses'] = Variable<int>(lapses);
    map['phase'] = Variable<String>(phase);
    return map;
  }

  ReviewStatesCompanion toCompanion(bool nullToAbsent) {
    return ReviewStatesCompanion(
      itemKey: Value(itemKey),
      itemType: Value(itemType),
      stability: Value(stability),
      difficulty: Value(difficulty),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      lastReview: lastReview == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReview),
      reps: Value(reps),
      lapses: Value(lapses),
      phase: Value(phase),
    );
  }

  factory ReviewStateRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewStateRow(
      itemKey: serializer.fromJson<String>(json['itemKey']),
      itemType: serializer.fromJson<String>(json['itemType']),
      stability: serializer.fromJson<double>(json['stability']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
      due: serializer.fromJson<DateTime?>(json['due']),
      lastReview: serializer.fromJson<DateTime?>(json['lastReview']),
      reps: serializer.fromJson<int>(json['reps']),
      lapses: serializer.fromJson<int>(json['lapses']),
      phase: serializer.fromJson<String>(json['phase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemKey': serializer.toJson<String>(itemKey),
      'itemType': serializer.toJson<String>(itemType),
      'stability': serializer.toJson<double>(stability),
      'difficulty': serializer.toJson<double>(difficulty),
      'due': serializer.toJson<DateTime?>(due),
      'lastReview': serializer.toJson<DateTime?>(lastReview),
      'reps': serializer.toJson<int>(reps),
      'lapses': serializer.toJson<int>(lapses),
      'phase': serializer.toJson<String>(phase),
    };
  }

  ReviewStateRow copyWith(
          {String? itemKey,
          String? itemType,
          double? stability,
          double? difficulty,
          Value<DateTime?> due = const Value.absent(),
          Value<DateTime?> lastReview = const Value.absent(),
          int? reps,
          int? lapses,
          String? phase}) =>
      ReviewStateRow(
        itemKey: itemKey ?? this.itemKey,
        itemType: itemType ?? this.itemType,
        stability: stability ?? this.stability,
        difficulty: difficulty ?? this.difficulty,
        due: due.present ? due.value : this.due,
        lastReview: lastReview.present ? lastReview.value : this.lastReview,
        reps: reps ?? this.reps,
        lapses: lapses ?? this.lapses,
        phase: phase ?? this.phase,
      );
  ReviewStateRow copyWithCompanion(ReviewStatesCompanion data) {
    return ReviewStateRow(
      itemKey: data.itemKey.present ? data.itemKey.value : this.itemKey,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      due: data.due.present ? data.due.value : this.due,
      lastReview:
          data.lastReview.present ? data.lastReview.value : this.lastReview,
      reps: data.reps.present ? data.reps.value : this.reps,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      phase: data.phase.present ? data.phase.value : this.phase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewStateRow(')
          ..write('itemKey: $itemKey, ')
          ..write('itemType: $itemType, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('due: $due, ')
          ..write('lastReview: $lastReview, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('phase: $phase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemKey, itemType, stability, difficulty, due,
      lastReview, reps, lapses, phase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewStateRow &&
          other.itemKey == this.itemKey &&
          other.itemType == this.itemType &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.due == this.due &&
          other.lastReview == this.lastReview &&
          other.reps == this.reps &&
          other.lapses == this.lapses &&
          other.phase == this.phase);
}

class ReviewStatesCompanion extends UpdateCompanion<ReviewStateRow> {
  final Value<String> itemKey;
  final Value<String> itemType;
  final Value<double> stability;
  final Value<double> difficulty;
  final Value<DateTime?> due;
  final Value<DateTime?> lastReview;
  final Value<int> reps;
  final Value<int> lapses;
  final Value<String> phase;
  final Value<int> rowid;
  const ReviewStatesCompanion({
    this.itemKey = const Value.absent(),
    this.itemType = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.due = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.phase = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewStatesCompanion.insert({
    required String itemKey,
    required String itemType,
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.due = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.phase = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : itemKey = Value(itemKey),
        itemType = Value(itemType);
  static Insertable<ReviewStateRow> custom({
    Expression<String>? itemKey,
    Expression<String>? itemType,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<DateTime>? due,
    Expression<DateTime>? lastReview,
    Expression<int>? reps,
    Expression<int>? lapses,
    Expression<String>? phase,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemKey != null) 'item_key': itemKey,
      if (itemType != null) 'item_type': itemType,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (due != null) 'due': due,
      if (lastReview != null) 'last_review': lastReview,
      if (reps != null) 'reps': reps,
      if (lapses != null) 'lapses': lapses,
      if (phase != null) 'phase': phase,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewStatesCompanion copyWith(
      {Value<String>? itemKey,
      Value<String>? itemType,
      Value<double>? stability,
      Value<double>? difficulty,
      Value<DateTime?>? due,
      Value<DateTime?>? lastReview,
      Value<int>? reps,
      Value<int>? lapses,
      Value<String>? phase,
      Value<int>? rowid}) {
    return ReviewStatesCompanion(
      itemKey: itemKey ?? this.itemKey,
      itemType: itemType ?? this.itemType,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      due: due ?? this.due,
      lastReview: lastReview ?? this.lastReview,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      phase: phase ?? this.phase,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemKey.present) {
      map['item_key'] = Variable<String>(itemKey.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (lastReview.present) {
      map['last_review'] = Variable<DateTime>(lastReview.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (phase.present) {
      map['phase'] = Variable<String>(phase.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewStatesCompanion(')
          ..write('itemKey: $itemKey, ')
          ..write('itemType: $itemType, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('due: $due, ')
          ..write('lastReview: $lastReview, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('phase: $phase, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserStateTableTable extends UserStateTable
    with TableInfo<$UserStateTableTable, UserStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _heartsMeta = const VerificationMeta('hearts');
  @override
  late final GeneratedColumn<int> hearts = GeneratedColumn<int>(
      'hearts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _heartsNextRegenMeta =
      const VerificationMeta('heartsNextRegen');
  @override
  late final GeneratedColumn<DateTime> heartsNextRegen =
      GeneratedColumn<DateTime>('hearts_next_regen', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
      'xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _streakCurrentMeta =
      const VerificationMeta('streakCurrent');
  @override
  late final GeneratedColumn<int> streakCurrent = GeneratedColumn<int>(
      'streak_current', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakLongestMeta =
      const VerificationMeta('streakLongest');
  @override
  late final GeneratedColumn<int> streakLongest = GeneratedColumn<int>(
      'streak_longest', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakFreezesMeta =
      const VerificationMeta('streakFreezes');
  @override
  late final GeneratedColumn<int> streakFreezes = GeneratedColumn<int>(
      'streak_freezes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastActiveDayMeta =
      const VerificationMeta('lastActiveDay');
  @override
  late final GeneratedColumn<DateTime> lastActiveDay =
      GeneratedColumn<DateTime>('last_active_day', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastFreezeWeekMeta =
      const VerificationMeta('lastFreezeWeek');
  @override
  late final GeneratedColumn<String> lastFreezeWeek = GeneratedColumn<String>(
      'last_freeze_week', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dailyGoalXpMeta =
      const VerificationMeta('dailyGoalXp');
  @override
  late final GeneratedColumn<int> dailyGoalXp = GeneratedColumn<int>(
      'daily_goal_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  static const VerificationMeta _soundEnabledMeta =
      const VerificationMeta('soundEnabled');
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
      'sound_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sound_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showHarakatMeta =
      const VerificationMeta('showHarakat');
  @override
  late final GeneratedColumn<bool> showHarakat = GeneratedColumn<bool>(
      'show_harakat', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_harakat" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _premiumMeta =
      const VerificationMeta('premium');
  @override
  late final GeneratedColumn<bool> premium = GeneratedColumn<bool>(
      'premium', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("premium" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _onboardedMeta =
      const VerificationMeta('onboarded');
  @override
  late final GeneratedColumn<bool> onboarded = GeneratedColumn<bool>(
      'onboarded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("onboarded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        hearts,
        heartsNextRegen,
        xp,
        level,
        streakCurrent,
        streakLongest,
        streakFreezes,
        lastActiveDay,
        lastFreezeWeek,
        dailyGoalXp,
        soundEnabled,
        showHarakat,
        premium,
        onboarded,
        nickname
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_state';
  @override
  VerificationContext validateIntegrity(Insertable<UserStateRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hearts')) {
      context.handle(_heartsMeta,
          hearts.isAcceptableOrUnknown(data['hearts']!, _heartsMeta));
    }
    if (data.containsKey('hearts_next_regen')) {
      context.handle(
          _heartsNextRegenMeta,
          heartsNextRegen.isAcceptableOrUnknown(
              data['hearts_next_regen']!, _heartsNextRegenMeta));
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('streak_current')) {
      context.handle(
          _streakCurrentMeta,
          streakCurrent.isAcceptableOrUnknown(
              data['streak_current']!, _streakCurrentMeta));
    }
    if (data.containsKey('streak_longest')) {
      context.handle(
          _streakLongestMeta,
          streakLongest.isAcceptableOrUnknown(
              data['streak_longest']!, _streakLongestMeta));
    }
    if (data.containsKey('streak_freezes')) {
      context.handle(
          _streakFreezesMeta,
          streakFreezes.isAcceptableOrUnknown(
              data['streak_freezes']!, _streakFreezesMeta));
    }
    if (data.containsKey('last_active_day')) {
      context.handle(
          _lastActiveDayMeta,
          lastActiveDay.isAcceptableOrUnknown(
              data['last_active_day']!, _lastActiveDayMeta));
    }
    if (data.containsKey('last_freeze_week')) {
      context.handle(
          _lastFreezeWeekMeta,
          lastFreezeWeek.isAcceptableOrUnknown(
              data['last_freeze_week']!, _lastFreezeWeekMeta));
    }
    if (data.containsKey('daily_goal_xp')) {
      context.handle(
          _dailyGoalXpMeta,
          dailyGoalXp.isAcceptableOrUnknown(
              data['daily_goal_xp']!, _dailyGoalXpMeta));
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
          _soundEnabledMeta,
          soundEnabled.isAcceptableOrUnknown(
              data['sound_enabled']!, _soundEnabledMeta));
    }
    if (data.containsKey('show_harakat')) {
      context.handle(
          _showHarakatMeta,
          showHarakat.isAcceptableOrUnknown(
              data['show_harakat']!, _showHarakatMeta));
    }
    if (data.containsKey('premium')) {
      context.handle(_premiumMeta,
          premium.isAcceptableOrUnknown(data['premium']!, _premiumMeta));
    }
    if (data.containsKey('onboarded')) {
      context.handle(_onboardedMeta,
          onboarded.isAcceptableOrUnknown(data['onboarded']!, _onboardedMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStateRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hearts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hearts'])!,
      heartsNextRegen: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}hearts_next_regen']),
      xp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      streakCurrent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_current'])!,
      streakLongest: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_longest'])!,
      streakFreezes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_freezes'])!,
      lastActiveDay: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_active_day']),
      lastFreezeWeek: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_freeze_week']),
      dailyGoalXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_goal_xp'])!,
      soundEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sound_enabled'])!,
      showHarakat: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_harakat'])!,
      premium: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}premium'])!,
      onboarded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}onboarded'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname']),
    );
  }

  @override
  $UserStateTableTable createAlias(String alias) {
    return $UserStateTableTable(attachedDatabase, alias);
  }
}

class UserStateRow extends DataClass implements Insertable<UserStateRow> {
  final int id;
  final int hearts;
  final DateTime? heartsNextRegen;
  final int xp;
  final int level;
  final int streakCurrent;
  final int streakLongest;
  final int streakFreezes;
  final DateTime? lastActiveDay;
  final String? lastFreezeWeek;
  final int dailyGoalXp;
  final bool soundEnabled;
  final bool showHarakat;
  final bool premium;
  final bool onboarded;
  final String? nickname;
  const UserStateRow(
      {required this.id,
      required this.hearts,
      this.heartsNextRegen,
      required this.xp,
      required this.level,
      required this.streakCurrent,
      required this.streakLongest,
      required this.streakFreezes,
      this.lastActiveDay,
      this.lastFreezeWeek,
      required this.dailyGoalXp,
      required this.soundEnabled,
      required this.showHarakat,
      required this.premium,
      required this.onboarded,
      this.nickname});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hearts'] = Variable<int>(hearts);
    if (!nullToAbsent || heartsNextRegen != null) {
      map['hearts_next_regen'] = Variable<DateTime>(heartsNextRegen);
    }
    map['xp'] = Variable<int>(xp);
    map['level'] = Variable<int>(level);
    map['streak_current'] = Variable<int>(streakCurrent);
    map['streak_longest'] = Variable<int>(streakLongest);
    map['streak_freezes'] = Variable<int>(streakFreezes);
    if (!nullToAbsent || lastActiveDay != null) {
      map['last_active_day'] = Variable<DateTime>(lastActiveDay);
    }
    if (!nullToAbsent || lastFreezeWeek != null) {
      map['last_freeze_week'] = Variable<String>(lastFreezeWeek);
    }
    map['daily_goal_xp'] = Variable<int>(dailyGoalXp);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['show_harakat'] = Variable<bool>(showHarakat);
    map['premium'] = Variable<bool>(premium);
    map['onboarded'] = Variable<bool>(onboarded);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    return map;
  }

  UserStateTableCompanion toCompanion(bool nullToAbsent) {
    return UserStateTableCompanion(
      id: Value(id),
      hearts: Value(hearts),
      heartsNextRegen: heartsNextRegen == null && nullToAbsent
          ? const Value.absent()
          : Value(heartsNextRegen),
      xp: Value(xp),
      level: Value(level),
      streakCurrent: Value(streakCurrent),
      streakLongest: Value(streakLongest),
      streakFreezes: Value(streakFreezes),
      lastActiveDay: lastActiveDay == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveDay),
      lastFreezeWeek: lastFreezeWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFreezeWeek),
      dailyGoalXp: Value(dailyGoalXp),
      soundEnabled: Value(soundEnabled),
      showHarakat: Value(showHarakat),
      premium: Value(premium),
      onboarded: Value(onboarded),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
    );
  }

  factory UserStateRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStateRow(
      id: serializer.fromJson<int>(json['id']),
      hearts: serializer.fromJson<int>(json['hearts']),
      heartsNextRegen: serializer.fromJson<DateTime?>(json['heartsNextRegen']),
      xp: serializer.fromJson<int>(json['xp']),
      level: serializer.fromJson<int>(json['level']),
      streakCurrent: serializer.fromJson<int>(json['streakCurrent']),
      streakLongest: serializer.fromJson<int>(json['streakLongest']),
      streakFreezes: serializer.fromJson<int>(json['streakFreezes']),
      lastActiveDay: serializer.fromJson<DateTime?>(json['lastActiveDay']),
      lastFreezeWeek: serializer.fromJson<String?>(json['lastFreezeWeek']),
      dailyGoalXp: serializer.fromJson<int>(json['dailyGoalXp']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      showHarakat: serializer.fromJson<bool>(json['showHarakat']),
      premium: serializer.fromJson<bool>(json['premium']),
      onboarded: serializer.fromJson<bool>(json['onboarded']),
      nickname: serializer.fromJson<String?>(json['nickname']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hearts': serializer.toJson<int>(hearts),
      'heartsNextRegen': serializer.toJson<DateTime?>(heartsNextRegen),
      'xp': serializer.toJson<int>(xp),
      'level': serializer.toJson<int>(level),
      'streakCurrent': serializer.toJson<int>(streakCurrent),
      'streakLongest': serializer.toJson<int>(streakLongest),
      'streakFreezes': serializer.toJson<int>(streakFreezes),
      'lastActiveDay': serializer.toJson<DateTime?>(lastActiveDay),
      'lastFreezeWeek': serializer.toJson<String?>(lastFreezeWeek),
      'dailyGoalXp': serializer.toJson<int>(dailyGoalXp),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'showHarakat': serializer.toJson<bool>(showHarakat),
      'premium': serializer.toJson<bool>(premium),
      'onboarded': serializer.toJson<bool>(onboarded),
      'nickname': serializer.toJson<String?>(nickname),
    };
  }

  UserStateRow copyWith(
          {int? id,
          int? hearts,
          Value<DateTime?> heartsNextRegen = const Value.absent(),
          int? xp,
          int? level,
          int? streakCurrent,
          int? streakLongest,
          int? streakFreezes,
          Value<DateTime?> lastActiveDay = const Value.absent(),
          Value<String?> lastFreezeWeek = const Value.absent(),
          int? dailyGoalXp,
          bool? soundEnabled,
          bool? showHarakat,
          bool? premium,
          bool? onboarded,
          Value<String?> nickname = const Value.absent()}) =>
      UserStateRow(
        id: id ?? this.id,
        hearts: hearts ?? this.hearts,
        heartsNextRegen: heartsNextRegen.present
            ? heartsNextRegen.value
            : this.heartsNextRegen,
        xp: xp ?? this.xp,
        level: level ?? this.level,
        streakCurrent: streakCurrent ?? this.streakCurrent,
        streakLongest: streakLongest ?? this.streakLongest,
        streakFreezes: streakFreezes ?? this.streakFreezes,
        lastActiveDay:
            lastActiveDay.present ? lastActiveDay.value : this.lastActiveDay,
        lastFreezeWeek:
            lastFreezeWeek.present ? lastFreezeWeek.value : this.lastFreezeWeek,
        dailyGoalXp: dailyGoalXp ?? this.dailyGoalXp,
        soundEnabled: soundEnabled ?? this.soundEnabled,
        showHarakat: showHarakat ?? this.showHarakat,
        premium: premium ?? this.premium,
        onboarded: onboarded ?? this.onboarded,
        nickname: nickname.present ? nickname.value : this.nickname,
      );
  UserStateRow copyWithCompanion(UserStateTableCompanion data) {
    return UserStateRow(
      id: data.id.present ? data.id.value : this.id,
      hearts: data.hearts.present ? data.hearts.value : this.hearts,
      heartsNextRegen: data.heartsNextRegen.present
          ? data.heartsNextRegen.value
          : this.heartsNextRegen,
      xp: data.xp.present ? data.xp.value : this.xp,
      level: data.level.present ? data.level.value : this.level,
      streakCurrent: data.streakCurrent.present
          ? data.streakCurrent.value
          : this.streakCurrent,
      streakLongest: data.streakLongest.present
          ? data.streakLongest.value
          : this.streakLongest,
      streakFreezes: data.streakFreezes.present
          ? data.streakFreezes.value
          : this.streakFreezes,
      lastActiveDay: data.lastActiveDay.present
          ? data.lastActiveDay.value
          : this.lastActiveDay,
      lastFreezeWeek: data.lastFreezeWeek.present
          ? data.lastFreezeWeek.value
          : this.lastFreezeWeek,
      dailyGoalXp:
          data.dailyGoalXp.present ? data.dailyGoalXp.value : this.dailyGoalXp,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      showHarakat:
          data.showHarakat.present ? data.showHarakat.value : this.showHarakat,
      premium: data.premium.present ? data.premium.value : this.premium,
      onboarded: data.onboarded.present ? data.onboarded.value : this.onboarded,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStateRow(')
          ..write('id: $id, ')
          ..write('hearts: $hearts, ')
          ..write('heartsNextRegen: $heartsNextRegen, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('streakCurrent: $streakCurrent, ')
          ..write('streakLongest: $streakLongest, ')
          ..write('streakFreezes: $streakFreezes, ')
          ..write('lastActiveDay: $lastActiveDay, ')
          ..write('lastFreezeWeek: $lastFreezeWeek, ')
          ..write('dailyGoalXp: $dailyGoalXp, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('showHarakat: $showHarakat, ')
          ..write('premium: $premium, ')
          ..write('onboarded: $onboarded, ')
          ..write('nickname: $nickname')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      hearts,
      heartsNextRegen,
      xp,
      level,
      streakCurrent,
      streakLongest,
      streakFreezes,
      lastActiveDay,
      lastFreezeWeek,
      dailyGoalXp,
      soundEnabled,
      showHarakat,
      premium,
      onboarded,
      nickname);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStateRow &&
          other.id == this.id &&
          other.hearts == this.hearts &&
          other.heartsNextRegen == this.heartsNextRegen &&
          other.xp == this.xp &&
          other.level == this.level &&
          other.streakCurrent == this.streakCurrent &&
          other.streakLongest == this.streakLongest &&
          other.streakFreezes == this.streakFreezes &&
          other.lastActiveDay == this.lastActiveDay &&
          other.lastFreezeWeek == this.lastFreezeWeek &&
          other.dailyGoalXp == this.dailyGoalXp &&
          other.soundEnabled == this.soundEnabled &&
          other.showHarakat == this.showHarakat &&
          other.premium == this.premium &&
          other.onboarded == this.onboarded &&
          other.nickname == this.nickname);
}

class UserStateTableCompanion extends UpdateCompanion<UserStateRow> {
  final Value<int> id;
  final Value<int> hearts;
  final Value<DateTime?> heartsNextRegen;
  final Value<int> xp;
  final Value<int> level;
  final Value<int> streakCurrent;
  final Value<int> streakLongest;
  final Value<int> streakFreezes;
  final Value<DateTime?> lastActiveDay;
  final Value<String?> lastFreezeWeek;
  final Value<int> dailyGoalXp;
  final Value<bool> soundEnabled;
  final Value<bool> showHarakat;
  final Value<bool> premium;
  final Value<bool> onboarded;
  final Value<String?> nickname;
  const UserStateTableCompanion({
    this.id = const Value.absent(),
    this.hearts = const Value.absent(),
    this.heartsNextRegen = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.streakCurrent = const Value.absent(),
    this.streakLongest = const Value.absent(),
    this.streakFreezes = const Value.absent(),
    this.lastActiveDay = const Value.absent(),
    this.lastFreezeWeek = const Value.absent(),
    this.dailyGoalXp = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.showHarakat = const Value.absent(),
    this.premium = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.nickname = const Value.absent(),
  });
  UserStateTableCompanion.insert({
    this.id = const Value.absent(),
    this.hearts = const Value.absent(),
    this.heartsNextRegen = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.streakCurrent = const Value.absent(),
    this.streakLongest = const Value.absent(),
    this.streakFreezes = const Value.absent(),
    this.lastActiveDay = const Value.absent(),
    this.lastFreezeWeek = const Value.absent(),
    this.dailyGoalXp = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.showHarakat = const Value.absent(),
    this.premium = const Value.absent(),
    this.onboarded = const Value.absent(),
    this.nickname = const Value.absent(),
  });
  static Insertable<UserStateRow> custom({
    Expression<int>? id,
    Expression<int>? hearts,
    Expression<DateTime>? heartsNextRegen,
    Expression<int>? xp,
    Expression<int>? level,
    Expression<int>? streakCurrent,
    Expression<int>? streakLongest,
    Expression<int>? streakFreezes,
    Expression<DateTime>? lastActiveDay,
    Expression<String>? lastFreezeWeek,
    Expression<int>? dailyGoalXp,
    Expression<bool>? soundEnabled,
    Expression<bool>? showHarakat,
    Expression<bool>? premium,
    Expression<bool>? onboarded,
    Expression<String>? nickname,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hearts != null) 'hearts': hearts,
      if (heartsNextRegen != null) 'hearts_next_regen': heartsNextRegen,
      if (xp != null) 'xp': xp,
      if (level != null) 'level': level,
      if (streakCurrent != null) 'streak_current': streakCurrent,
      if (streakLongest != null) 'streak_longest': streakLongest,
      if (streakFreezes != null) 'streak_freezes': streakFreezes,
      if (lastActiveDay != null) 'last_active_day': lastActiveDay,
      if (lastFreezeWeek != null) 'last_freeze_week': lastFreezeWeek,
      if (dailyGoalXp != null) 'daily_goal_xp': dailyGoalXp,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (showHarakat != null) 'show_harakat': showHarakat,
      if (premium != null) 'premium': premium,
      if (onboarded != null) 'onboarded': onboarded,
      if (nickname != null) 'nickname': nickname,
    });
  }

  UserStateTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? hearts,
      Value<DateTime?>? heartsNextRegen,
      Value<int>? xp,
      Value<int>? level,
      Value<int>? streakCurrent,
      Value<int>? streakLongest,
      Value<int>? streakFreezes,
      Value<DateTime?>? lastActiveDay,
      Value<String?>? lastFreezeWeek,
      Value<int>? dailyGoalXp,
      Value<bool>? soundEnabled,
      Value<bool>? showHarakat,
      Value<bool>? premium,
      Value<bool>? onboarded,
      Value<String?>? nickname}) {
    return UserStateTableCompanion(
      id: id ?? this.id,
      hearts: hearts ?? this.hearts,
      heartsNextRegen: heartsNextRegen ?? this.heartsNextRegen,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streakCurrent: streakCurrent ?? this.streakCurrent,
      streakLongest: streakLongest ?? this.streakLongest,
      streakFreezes: streakFreezes ?? this.streakFreezes,
      lastActiveDay: lastActiveDay ?? this.lastActiveDay,
      lastFreezeWeek: lastFreezeWeek ?? this.lastFreezeWeek,
      dailyGoalXp: dailyGoalXp ?? this.dailyGoalXp,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      showHarakat: showHarakat ?? this.showHarakat,
      premium: premium ?? this.premium,
      onboarded: onboarded ?? this.onboarded,
      nickname: nickname ?? this.nickname,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hearts.present) {
      map['hearts'] = Variable<int>(hearts.value);
    }
    if (heartsNextRegen.present) {
      map['hearts_next_regen'] = Variable<DateTime>(heartsNextRegen.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (streakCurrent.present) {
      map['streak_current'] = Variable<int>(streakCurrent.value);
    }
    if (streakLongest.present) {
      map['streak_longest'] = Variable<int>(streakLongest.value);
    }
    if (streakFreezes.present) {
      map['streak_freezes'] = Variable<int>(streakFreezes.value);
    }
    if (lastActiveDay.present) {
      map['last_active_day'] = Variable<DateTime>(lastActiveDay.value);
    }
    if (lastFreezeWeek.present) {
      map['last_freeze_week'] = Variable<String>(lastFreezeWeek.value);
    }
    if (dailyGoalXp.present) {
      map['daily_goal_xp'] = Variable<int>(dailyGoalXp.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (showHarakat.present) {
      map['show_harakat'] = Variable<bool>(showHarakat.value);
    }
    if (premium.present) {
      map['premium'] = Variable<bool>(premium.value);
    }
    if (onboarded.present) {
      map['onboarded'] = Variable<bool>(onboarded.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStateTableCompanion(')
          ..write('id: $id, ')
          ..write('hearts: $hearts, ')
          ..write('heartsNextRegen: $heartsNextRegen, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('streakCurrent: $streakCurrent, ')
          ..write('streakLongest: $streakLongest, ')
          ..write('streakFreezes: $streakFreezes, ')
          ..write('lastActiveDay: $lastActiveDay, ')
          ..write('lastFreezeWeek: $lastFreezeWeek, ')
          ..write('dailyGoalXp: $dailyGoalXp, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('showHarakat: $showHarakat, ')
          ..write('premium: $premium, ')
          ..write('onboarded: $onboarded, ')
          ..write('nickname: $nickname')
          ..write(')'))
        .toString();
  }
}

class $ExerciseLogTable extends ExerciseLog
    with TableInfo<$ExerciseLogTable, ExerciseLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
      'node_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _exerciseTypeMeta =
      const VerificationMeta('exerciseType');
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
      'exercise_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctMeta =
      const VerificationMeta('correct');
  @override
  late final GeneratedColumn<bool> correct = GeneratedColumn<bool>(
      'correct', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("correct" IN (0, 1))'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nodeId, exerciseType, correct, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_log';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseLogRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('node_id')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta));
    }
    if (data.containsKey('exercise_type')) {
      context.handle(
          _exerciseTypeMeta,
          exerciseType.isAcceptableOrUnknown(
              data['exercise_type']!, _exerciseTypeMeta));
    } else if (isInserting) {
      context.missing(_exerciseTypeMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(_correctMeta,
          correct.isAcceptableOrUnknown(data['correct']!, _correctMeta));
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseLogRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}node_id']),
      exerciseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_type'])!,
      correct: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}correct'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ExerciseLogTable createAlias(String alias) {
    return $ExerciseLogTable(attachedDatabase, alias);
  }
}

class ExerciseLogRow extends DataClass implements Insertable<ExerciseLogRow> {
  final int id;
  final String? nodeId;
  final String exerciseType;
  final bool correct;
  final DateTime timestamp;
  const ExerciseLogRow(
      {required this.id,
      this.nodeId,
      required this.exerciseType,
      required this.correct,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nodeId != null) {
      map['node_id'] = Variable<String>(nodeId);
    }
    map['exercise_type'] = Variable<String>(exerciseType);
    map['correct'] = Variable<bool>(correct);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ExerciseLogCompanion toCompanion(bool nullToAbsent) {
    return ExerciseLogCompanion(
      id: Value(id),
      nodeId:
          nodeId == null && nullToAbsent ? const Value.absent() : Value(nodeId),
      exerciseType: Value(exerciseType),
      correct: Value(correct),
      timestamp: Value(timestamp),
    );
  }

  factory ExerciseLogRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseLogRow(
      id: serializer.fromJson<int>(json['id']),
      nodeId: serializer.fromJson<String?>(json['nodeId']),
      exerciseType: serializer.fromJson<String>(json['exerciseType']),
      correct: serializer.fromJson<bool>(json['correct']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nodeId': serializer.toJson<String?>(nodeId),
      'exerciseType': serializer.toJson<String>(exerciseType),
      'correct': serializer.toJson<bool>(correct),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  ExerciseLogRow copyWith(
          {int? id,
          Value<String?> nodeId = const Value.absent(),
          String? exerciseType,
          bool? correct,
          DateTime? timestamp}) =>
      ExerciseLogRow(
        id: id ?? this.id,
        nodeId: nodeId.present ? nodeId.value : this.nodeId,
        exerciseType: exerciseType ?? this.exerciseType,
        correct: correct ?? this.correct,
        timestamp: timestamp ?? this.timestamp,
      );
  ExerciseLogRow copyWithCompanion(ExerciseLogCompanion data) {
    return ExerciseLogRow(
      id: data.id.present ? data.id.value : this.id,
      nodeId: data.nodeId.present ? data.nodeId.value : this.nodeId,
      exerciseType: data.exerciseType.present
          ? data.exerciseType.value
          : this.exerciseType,
      correct: data.correct.present ? data.correct.value : this.correct,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseLogRow(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('correct: $correct, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nodeId, exerciseType, correct, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseLogRow &&
          other.id == this.id &&
          other.nodeId == this.nodeId &&
          other.exerciseType == this.exerciseType &&
          other.correct == this.correct &&
          other.timestamp == this.timestamp);
}

class ExerciseLogCompanion extends UpdateCompanion<ExerciseLogRow> {
  final Value<int> id;
  final Value<String?> nodeId;
  final Value<String> exerciseType;
  final Value<bool> correct;
  final Value<DateTime> timestamp;
  const ExerciseLogCompanion({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.correct = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ExerciseLogCompanion.insert({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    required String exerciseType,
    required bool correct,
    required DateTime timestamp,
  })  : exerciseType = Value(exerciseType),
        correct = Value(correct),
        timestamp = Value(timestamp);
  static Insertable<ExerciseLogRow> custom({
    Expression<int>? id,
    Expression<String>? nodeId,
    Expression<String>? exerciseType,
    Expression<bool>? correct,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nodeId != null) 'node_id': nodeId,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (correct != null) 'correct': correct,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ExerciseLogCompanion copyWith(
      {Value<int>? id,
      Value<String?>? nodeId,
      Value<String>? exerciseType,
      Value<bool>? correct,
      Value<DateTime>? timestamp}) {
    return ExerciseLogCompanion(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      exerciseType: exerciseType ?? this.exerciseType,
      correct: correct ?? this.correct,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (correct.present) {
      map['correct'] = Variable<bool>(correct.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseLogCompanion(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('correct: $correct, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LettersTable letters = $LettersTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $ReadingPassagesTable readingPassages =
      $ReadingPassagesTable(this);
  late final $PassageLinesTable passageLines = $PassageLinesTable(this);
  late final $CurriculumNodesTable curriculumNodes =
      $CurriculumNodesTable(this);
  late final $NodeProgressTable nodeProgress = $NodeProgressTable(this);
  late final $ReviewStatesTable reviewStates = $ReviewStatesTable(this);
  late final $UserStateTableTable userStateTable = $UserStateTableTable(this);
  late final $ExerciseLogTable exerciseLog = $ExerciseLogTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        letters,
        words,
        readingPassages,
        passageLines,
        curriculumNodes,
        nodeProgress,
        reviewStates,
        userStateTable,
        exerciseLog
      ];
}

typedef $$LettersTableCreateCompanionBuilder = LettersCompanion Function({
  required String id,
  required String name,
  required String isolated,
  required String initialForm,
  required String medialForm,
  required String finalForm,
  Value<String?> similarGroup,
  required String soundValue,
  Value<String?> exampleWord,
  Value<int> rowid,
});
typedef $$LettersTableUpdateCompanionBuilder = LettersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> isolated,
  Value<String> initialForm,
  Value<String> medialForm,
  Value<String> finalForm,
  Value<String?> similarGroup,
  Value<String> soundValue,
  Value<String?> exampleWord,
  Value<int> rowid,
});

class $$LettersTableFilterComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isolated => $composableBuilder(
      column: $table.isolated, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get initialForm => $composableBuilder(
      column: $table.initialForm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medialForm => $composableBuilder(
      column: $table.medialForm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get finalForm => $composableBuilder(
      column: $table.finalForm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get similarGroup => $composableBuilder(
      column: $table.similarGroup, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soundValue => $composableBuilder(
      column: $table.soundValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exampleWord => $composableBuilder(
      column: $table.exampleWord, builder: (column) => ColumnFilters(column));
}

class $$LettersTableOrderingComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isolated => $composableBuilder(
      column: $table.isolated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get initialForm => $composableBuilder(
      column: $table.initialForm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medialForm => $composableBuilder(
      column: $table.medialForm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get finalForm => $composableBuilder(
      column: $table.finalForm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get similarGroup => $composableBuilder(
      column: $table.similarGroup,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soundValue => $composableBuilder(
      column: $table.soundValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exampleWord => $composableBuilder(
      column: $table.exampleWord, builder: (column) => ColumnOrderings(column));
}

class $$LettersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get isolated =>
      $composableBuilder(column: $table.isolated, builder: (column) => column);

  GeneratedColumn<String> get initialForm => $composableBuilder(
      column: $table.initialForm, builder: (column) => column);

  GeneratedColumn<String> get medialForm => $composableBuilder(
      column: $table.medialForm, builder: (column) => column);

  GeneratedColumn<String> get finalForm =>
      $composableBuilder(column: $table.finalForm, builder: (column) => column);

  GeneratedColumn<String> get similarGroup => $composableBuilder(
      column: $table.similarGroup, builder: (column) => column);

  GeneratedColumn<String> get soundValue => $composableBuilder(
      column: $table.soundValue, builder: (column) => column);

  GeneratedColumn<String> get exampleWord => $composableBuilder(
      column: $table.exampleWord, builder: (column) => column);
}

class $$LettersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LettersTable,
    LetterRow,
    $$LettersTableFilterComposer,
    $$LettersTableOrderingComposer,
    $$LettersTableAnnotationComposer,
    $$LettersTableCreateCompanionBuilder,
    $$LettersTableUpdateCompanionBuilder,
    (LetterRow, BaseReferences<_$AppDatabase, $LettersTable, LetterRow>),
    LetterRow,
    PrefetchHooks Function()> {
  $$LettersTableTableManager(_$AppDatabase db, $LettersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LettersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LettersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LettersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> isolated = const Value.absent(),
            Value<String> initialForm = const Value.absent(),
            Value<String> medialForm = const Value.absent(),
            Value<String> finalForm = const Value.absent(),
            Value<String?> similarGroup = const Value.absent(),
            Value<String> soundValue = const Value.absent(),
            Value<String?> exampleWord = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LettersCompanion(
            id: id,
            name: name,
            isolated: isolated,
            initialForm: initialForm,
            medialForm: medialForm,
            finalForm: finalForm,
            similarGroup: similarGroup,
            soundValue: soundValue,
            exampleWord: exampleWord,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String isolated,
            required String initialForm,
            required String medialForm,
            required String finalForm,
            Value<String?> similarGroup = const Value.absent(),
            required String soundValue,
            Value<String?> exampleWord = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LettersCompanion.insert(
            id: id,
            name: name,
            isolated: isolated,
            initialForm: initialForm,
            medialForm: medialForm,
            finalForm: finalForm,
            similarGroup: similarGroup,
            soundValue: soundValue,
            exampleWord: exampleWord,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LettersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LettersTable,
    LetterRow,
    $$LettersTableFilterComposer,
    $$LettersTableOrderingComposer,
    $$LettersTableAnnotationComposer,
    $$LettersTableCreateCompanionBuilder,
    $$LettersTableUpdateCompanionBuilder,
    (LetterRow, BaseReferences<_$AppDatabase, $LettersTable, LetterRow>),
    LetterRow,
    PrefetchHooks Function()>;
typedef $$WordsTableCreateCompanionBuilder = WordsCompanion Function({
  required String id,
  required String ottoman,
  required String transliteration,
  required String meaningTr,
  Value<String?> root,
  required int frequencyRank,
  required int level,
  Value<String?> exampleSentence,
  Value<int> rowid,
});
typedef $$WordsTableUpdateCompanionBuilder = WordsCompanion Function({
  Value<String> id,
  Value<String> ottoman,
  Value<String> transliteration,
  Value<String> meaningTr,
  Value<String?> root,
  Value<int> frequencyRank,
  Value<int> level,
  Value<String?> exampleSentence,
  Value<int> rowid,
});

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ottoman => $composableBuilder(
      column: $table.ottoman, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get root => $composableBuilder(
      column: $table.root, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get frequencyRank => $composableBuilder(
      column: $table.frequencyRank, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence,
      builder: (column) => ColumnFilters(column));
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ottoman => $composableBuilder(
      column: $table.ottoman, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get root => $composableBuilder(
      column: $table.root, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get frequencyRank => $composableBuilder(
      column: $table.frequencyRank,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence,
      builder: (column) => ColumnOrderings(column));
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ottoman =>
      $composableBuilder(column: $table.ottoman, builder: (column) => column);

  GeneratedColumn<String> get transliteration => $composableBuilder(
      column: $table.transliteration, builder: (column) => column);

  GeneratedColumn<String> get meaningTr =>
      $composableBuilder(column: $table.meaningTr, builder: (column) => column);

  GeneratedColumn<String> get root =>
      $composableBuilder(column: $table.root, builder: (column) => column);

  GeneratedColumn<int> get frequencyRank => $composableBuilder(
      column: $table.frequencyRank, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence, builder: (column) => column);
}

class $$WordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordsTable,
    WordRow,
    $$WordsTableFilterComposer,
    $$WordsTableOrderingComposer,
    $$WordsTableAnnotationComposer,
    $$WordsTableCreateCompanionBuilder,
    $$WordsTableUpdateCompanionBuilder,
    (WordRow, BaseReferences<_$AppDatabase, $WordsTable, WordRow>),
    WordRow,
    PrefetchHooks Function()> {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ottoman = const Value.absent(),
            Value<String> transliteration = const Value.absent(),
            Value<String> meaningTr = const Value.absent(),
            Value<String?> root = const Value.absent(),
            Value<int> frequencyRank = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String?> exampleSentence = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordsCompanion(
            id: id,
            ottoman: ottoman,
            transliteration: transliteration,
            meaningTr: meaningTr,
            root: root,
            frequencyRank: frequencyRank,
            level: level,
            exampleSentence: exampleSentence,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ottoman,
            required String transliteration,
            required String meaningTr,
            Value<String?> root = const Value.absent(),
            required int frequencyRank,
            required int level,
            Value<String?> exampleSentence = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordsCompanion.insert(
            id: id,
            ottoman: ottoman,
            transliteration: transliteration,
            meaningTr: meaningTr,
            root: root,
            frequencyRank: frequencyRank,
            level: level,
            exampleSentence: exampleSentence,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordsTable,
    WordRow,
    $$WordsTableFilterComposer,
    $$WordsTableOrderingComposer,
    $$WordsTableAnnotationComposer,
    $$WordsTableCreateCompanionBuilder,
    $$WordsTableUpdateCompanionBuilder,
    (WordRow, BaseReferences<_$AppDatabase, $WordsTable, WordRow>),
    WordRow,
    PrefetchHooks Function()>;
typedef $$ReadingPassagesTableCreateCompanionBuilder = ReadingPassagesCompanion
    Function({
  required String id,
  required String title,
  required int level,
  required String genre,
  Value<String?> imageAssetPath,
  Value<int> rowid,
});
typedef $$ReadingPassagesTableUpdateCompanionBuilder = ReadingPassagesCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<int> level,
  Value<String> genre,
  Value<String?> imageAssetPath,
  Value<int> rowid,
});

class $$ReadingPassagesTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingPassagesTable> {
  $$ReadingPassagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageAssetPath => $composableBuilder(
      column: $table.imageAssetPath,
      builder: (column) => ColumnFilters(column));
}

class $$ReadingPassagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingPassagesTable> {
  $$ReadingPassagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageAssetPath => $composableBuilder(
      column: $table.imageAssetPath,
      builder: (column) => ColumnOrderings(column));
}

class $$ReadingPassagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingPassagesTable> {
  $$ReadingPassagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<String> get imageAssetPath => $composableBuilder(
      column: $table.imageAssetPath, builder: (column) => column);
}

class $$ReadingPassagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReadingPassagesTable,
    ReadingPassageRow,
    $$ReadingPassagesTableFilterComposer,
    $$ReadingPassagesTableOrderingComposer,
    $$ReadingPassagesTableAnnotationComposer,
    $$ReadingPassagesTableCreateCompanionBuilder,
    $$ReadingPassagesTableUpdateCompanionBuilder,
    (
      ReadingPassageRow,
      BaseReferences<_$AppDatabase, $ReadingPassagesTable, ReadingPassageRow>
    ),
    ReadingPassageRow,
    PrefetchHooks Function()> {
  $$ReadingPassagesTableTableManager(
      _$AppDatabase db, $ReadingPassagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingPassagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingPassagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingPassagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> genre = const Value.absent(),
            Value<String?> imageAssetPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReadingPassagesCompanion(
            id: id,
            title: title,
            level: level,
            genre: genre,
            imageAssetPath: imageAssetPath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required int level,
            required String genre,
            Value<String?> imageAssetPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReadingPassagesCompanion.insert(
            id: id,
            title: title,
            level: level,
            genre: genre,
            imageAssetPath: imageAssetPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReadingPassagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReadingPassagesTable,
    ReadingPassageRow,
    $$ReadingPassagesTableFilterComposer,
    $$ReadingPassagesTableOrderingComposer,
    $$ReadingPassagesTableAnnotationComposer,
    $$ReadingPassagesTableCreateCompanionBuilder,
    $$ReadingPassagesTableUpdateCompanionBuilder,
    (
      ReadingPassageRow,
      BaseReferences<_$AppDatabase, $ReadingPassagesTable, ReadingPassageRow>
    ),
    ReadingPassageRow,
    PrefetchHooks Function()>;
typedef $$PassageLinesTableCreateCompanionBuilder = PassageLinesCompanion
    Function({
  required String id,
  required String passageId,
  required int ordinal,
  required String ottoman,
  required String transliteration,
  required String simplifiedTr,
  Value<int> rowid,
});
typedef $$PassageLinesTableUpdateCompanionBuilder = PassageLinesCompanion
    Function({
  Value<String> id,
  Value<String> passageId,
  Value<int> ordinal,
  Value<String> ottoman,
  Value<String> transliteration,
  Value<String> simplifiedTr,
  Value<int> rowid,
});

class $$PassageLinesTableFilterComposer
    extends Composer<_$AppDatabase, $PassageLinesTable> {
  $$PassageLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passageId => $composableBuilder(
      column: $table.passageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ottoman => $composableBuilder(
      column: $table.ottoman, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get simplifiedTr => $composableBuilder(
      column: $table.simplifiedTr, builder: (column) => ColumnFilters(column));
}

class $$PassageLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $PassageLinesTable> {
  $$PassageLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passageId => $composableBuilder(
      column: $table.passageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ottoman => $composableBuilder(
      column: $table.ottoman, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get simplifiedTr => $composableBuilder(
      column: $table.simplifiedTr,
      builder: (column) => ColumnOrderings(column));
}

class $$PassageLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PassageLinesTable> {
  $$PassageLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get passageId =>
      $composableBuilder(column: $table.passageId, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get ottoman =>
      $composableBuilder(column: $table.ottoman, builder: (column) => column);

  GeneratedColumn<String> get transliteration => $composableBuilder(
      column: $table.transliteration, builder: (column) => column);

  GeneratedColumn<String> get simplifiedTr => $composableBuilder(
      column: $table.simplifiedTr, builder: (column) => column);
}

class $$PassageLinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PassageLinesTable,
    PassageLineRow,
    $$PassageLinesTableFilterComposer,
    $$PassageLinesTableOrderingComposer,
    $$PassageLinesTableAnnotationComposer,
    $$PassageLinesTableCreateCompanionBuilder,
    $$PassageLinesTableUpdateCompanionBuilder,
    (
      PassageLineRow,
      BaseReferences<_$AppDatabase, $PassageLinesTable, PassageLineRow>
    ),
    PassageLineRow,
    PrefetchHooks Function()> {
  $$PassageLinesTableTableManager(_$AppDatabase db, $PassageLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PassageLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PassageLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PassageLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> passageId = const Value.absent(),
            Value<int> ordinal = const Value.absent(),
            Value<String> ottoman = const Value.absent(),
            Value<String> transliteration = const Value.absent(),
            Value<String> simplifiedTr = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PassageLinesCompanion(
            id: id,
            passageId: passageId,
            ordinal: ordinal,
            ottoman: ottoman,
            transliteration: transliteration,
            simplifiedTr: simplifiedTr,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String passageId,
            required int ordinal,
            required String ottoman,
            required String transliteration,
            required String simplifiedTr,
            Value<int> rowid = const Value.absent(),
          }) =>
              PassageLinesCompanion.insert(
            id: id,
            passageId: passageId,
            ordinal: ordinal,
            ottoman: ottoman,
            transliteration: transliteration,
            simplifiedTr: simplifiedTr,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PassageLinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PassageLinesTable,
    PassageLineRow,
    $$PassageLinesTableFilterComposer,
    $$PassageLinesTableOrderingComposer,
    $$PassageLinesTableAnnotationComposer,
    $$PassageLinesTableCreateCompanionBuilder,
    $$PassageLinesTableUpdateCompanionBuilder,
    (
      PassageLineRow,
      BaseReferences<_$AppDatabase, $PassageLinesTable, PassageLineRow>
    ),
    PassageLineRow,
    PrefetchHooks Function()>;
typedef $$CurriculumNodesTableCreateCompanionBuilder = CurriculumNodesCompanion
    Function({
  required String id,
  required String type,
  required String unitId,
  required String unitTitle,
  required int ordinal,
  required String title,
  required String contentRefs,
  Value<int> rowid,
});
typedef $$CurriculumNodesTableUpdateCompanionBuilder = CurriculumNodesCompanion
    Function({
  Value<String> id,
  Value<String> type,
  Value<String> unitId,
  Value<String> unitTitle,
  Value<int> ordinal,
  Value<String> title,
  Value<String> contentRefs,
  Value<int> rowid,
});

class $$CurriculumNodesTableFilterComposer
    extends Composer<_$AppDatabase, $CurriculumNodesTable> {
  $$CurriculumNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitId => $composableBuilder(
      column: $table.unitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitTitle => $composableBuilder(
      column: $table.unitTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentRefs => $composableBuilder(
      column: $table.contentRefs, builder: (column) => ColumnFilters(column));
}

class $$CurriculumNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $CurriculumNodesTable> {
  $$CurriculumNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitId => $composableBuilder(
      column: $table.unitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitTitle => $composableBuilder(
      column: $table.unitTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordinal => $composableBuilder(
      column: $table.ordinal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentRefs => $composableBuilder(
      column: $table.contentRefs, builder: (column) => ColumnOrderings(column));
}

class $$CurriculumNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurriculumNodesTable> {
  $$CurriculumNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<String> get unitTitle =>
      $composableBuilder(column: $table.unitTitle, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentRefs => $composableBuilder(
      column: $table.contentRefs, builder: (column) => column);
}

class $$CurriculumNodesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CurriculumNodesTable,
    CurriculumNodeRow,
    $$CurriculumNodesTableFilterComposer,
    $$CurriculumNodesTableOrderingComposer,
    $$CurriculumNodesTableAnnotationComposer,
    $$CurriculumNodesTableCreateCompanionBuilder,
    $$CurriculumNodesTableUpdateCompanionBuilder,
    (
      CurriculumNodeRow,
      BaseReferences<_$AppDatabase, $CurriculumNodesTable, CurriculumNodeRow>
    ),
    CurriculumNodeRow,
    PrefetchHooks Function()> {
  $$CurriculumNodesTableTableManager(
      _$AppDatabase db, $CurriculumNodesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurriculumNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurriculumNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurriculumNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> unitId = const Value.absent(),
            Value<String> unitTitle = const Value.absent(),
            Value<int> ordinal = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> contentRefs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CurriculumNodesCompanion(
            id: id,
            type: type,
            unitId: unitId,
            unitTitle: unitTitle,
            ordinal: ordinal,
            title: title,
            contentRefs: contentRefs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required String unitId,
            required String unitTitle,
            required int ordinal,
            required String title,
            required String contentRefs,
            Value<int> rowid = const Value.absent(),
          }) =>
              CurriculumNodesCompanion.insert(
            id: id,
            type: type,
            unitId: unitId,
            unitTitle: unitTitle,
            ordinal: ordinal,
            title: title,
            contentRefs: contentRefs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CurriculumNodesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CurriculumNodesTable,
    CurriculumNodeRow,
    $$CurriculumNodesTableFilterComposer,
    $$CurriculumNodesTableOrderingComposer,
    $$CurriculumNodesTableAnnotationComposer,
    $$CurriculumNodesTableCreateCompanionBuilder,
    $$CurriculumNodesTableUpdateCompanionBuilder,
    (
      CurriculumNodeRow,
      BaseReferences<_$AppDatabase, $CurriculumNodesTable, CurriculumNodeRow>
    ),
    CurriculumNodeRow,
    PrefetchHooks Function()>;
typedef $$NodeProgressTableCreateCompanionBuilder = NodeProgressCompanion
    Function({
  required String nodeId,
  required String status,
  Value<int> stars,
  Value<int> bestScore,
  Value<int> rowid,
});
typedef $$NodeProgressTableUpdateCompanionBuilder = NodeProgressCompanion
    Function({
  Value<String> nodeId,
  Value<String> status,
  Value<int> stars,
  Value<int> bestScore,
  Value<int> rowid,
});

class $$NodeProgressTableFilterComposer
    extends Composer<_$AppDatabase, $NodeProgressTable> {
  $$NodeProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get nodeId => $composableBuilder(
      column: $table.nodeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bestScore => $composableBuilder(
      column: $table.bestScore, builder: (column) => ColumnFilters(column));
}

class $$NodeProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $NodeProgressTable> {
  $$NodeProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get nodeId => $composableBuilder(
      column: $table.nodeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bestScore => $composableBuilder(
      column: $table.bestScore, builder: (column) => ColumnOrderings(column));
}

class $$NodeProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $NodeProgressTable> {
  $$NodeProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get nodeId =>
      $composableBuilder(column: $table.nodeId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<int> get bestScore =>
      $composableBuilder(column: $table.bestScore, builder: (column) => column);
}

class $$NodeProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NodeProgressTable,
    NodeProgressRow,
    $$NodeProgressTableFilterComposer,
    $$NodeProgressTableOrderingComposer,
    $$NodeProgressTableAnnotationComposer,
    $$NodeProgressTableCreateCompanionBuilder,
    $$NodeProgressTableUpdateCompanionBuilder,
    (
      NodeProgressRow,
      BaseReferences<_$AppDatabase, $NodeProgressTable, NodeProgressRow>
    ),
    NodeProgressRow,
    PrefetchHooks Function()> {
  $$NodeProgressTableTableManager(_$AppDatabase db, $NodeProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NodeProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NodeProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NodeProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> nodeId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<int> bestScore = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NodeProgressCompanion(
            nodeId: nodeId,
            status: status,
            stars: stars,
            bestScore: bestScore,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String nodeId,
            required String status,
            Value<int> stars = const Value.absent(),
            Value<int> bestScore = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NodeProgressCompanion.insert(
            nodeId: nodeId,
            status: status,
            stars: stars,
            bestScore: bestScore,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NodeProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NodeProgressTable,
    NodeProgressRow,
    $$NodeProgressTableFilterComposer,
    $$NodeProgressTableOrderingComposer,
    $$NodeProgressTableAnnotationComposer,
    $$NodeProgressTableCreateCompanionBuilder,
    $$NodeProgressTableUpdateCompanionBuilder,
    (
      NodeProgressRow,
      BaseReferences<_$AppDatabase, $NodeProgressTable, NodeProgressRow>
    ),
    NodeProgressRow,
    PrefetchHooks Function()>;
typedef $$ReviewStatesTableCreateCompanionBuilder = ReviewStatesCompanion
    Function({
  required String itemKey,
  required String itemType,
  Value<double> stability,
  Value<double> difficulty,
  Value<DateTime?> due,
  Value<DateTime?> lastReview,
  Value<int> reps,
  Value<int> lapses,
  Value<String> phase,
  Value<int> rowid,
});
typedef $$ReviewStatesTableUpdateCompanionBuilder = ReviewStatesCompanion
    Function({
  Value<String> itemKey,
  Value<String> itemType,
  Value<double> stability,
  Value<double> difficulty,
  Value<DateTime?> due,
  Value<DateTime?> lastReview,
  Value<int> reps,
  Value<int> lapses,
  Value<String> phase,
  Value<int> rowid,
});

class $$ReviewStatesTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewStatesTable> {
  $$ReviewStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemKey => $composableBuilder(
      column: $table.itemKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get due => $composableBuilder(
      column: $table.due, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phase => $composableBuilder(
      column: $table.phase, builder: (column) => ColumnFilters(column));
}

class $$ReviewStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewStatesTable> {
  $$ReviewStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemKey => $composableBuilder(
      column: $table.itemKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get due => $composableBuilder(
      column: $table.due, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phase => $composableBuilder(
      column: $table.phase, builder: (column) => ColumnOrderings(column));
}

class $$ReviewStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewStatesTable> {
  $$ReviewStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemKey =>
      $composableBuilder(column: $table.itemKey, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<String> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);
}

class $$ReviewStatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewStatesTable,
    ReviewStateRow,
    $$ReviewStatesTableFilterComposer,
    $$ReviewStatesTableOrderingComposer,
    $$ReviewStatesTableAnnotationComposer,
    $$ReviewStatesTableCreateCompanionBuilder,
    $$ReviewStatesTableUpdateCompanionBuilder,
    (
      ReviewStateRow,
      BaseReferences<_$AppDatabase, $ReviewStatesTable, ReviewStateRow>
    ),
    ReviewStateRow,
    PrefetchHooks Function()> {
  $$ReviewStatesTableTableManager(_$AppDatabase db, $ReviewStatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> itemKey = const Value.absent(),
            Value<String> itemType = const Value.absent(),
            Value<double> stability = const Value.absent(),
            Value<double> difficulty = const Value.absent(),
            Value<DateTime?> due = const Value.absent(),
            Value<DateTime?> lastReview = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<String> phase = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReviewStatesCompanion(
            itemKey: itemKey,
            itemType: itemType,
            stability: stability,
            difficulty: difficulty,
            due: due,
            lastReview: lastReview,
            reps: reps,
            lapses: lapses,
            phase: phase,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String itemKey,
            required String itemType,
            Value<double> stability = const Value.absent(),
            Value<double> difficulty = const Value.absent(),
            Value<DateTime?> due = const Value.absent(),
            Value<DateTime?> lastReview = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<String> phase = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReviewStatesCompanion.insert(
            itemKey: itemKey,
            itemType: itemType,
            stability: stability,
            difficulty: difficulty,
            due: due,
            lastReview: lastReview,
            reps: reps,
            lapses: lapses,
            phase: phase,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReviewStatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewStatesTable,
    ReviewStateRow,
    $$ReviewStatesTableFilterComposer,
    $$ReviewStatesTableOrderingComposer,
    $$ReviewStatesTableAnnotationComposer,
    $$ReviewStatesTableCreateCompanionBuilder,
    $$ReviewStatesTableUpdateCompanionBuilder,
    (
      ReviewStateRow,
      BaseReferences<_$AppDatabase, $ReviewStatesTable, ReviewStateRow>
    ),
    ReviewStateRow,
    PrefetchHooks Function()>;
typedef $$UserStateTableTableCreateCompanionBuilder = UserStateTableCompanion
    Function({
  Value<int> id,
  Value<int> hearts,
  Value<DateTime?> heartsNextRegen,
  Value<int> xp,
  Value<int> level,
  Value<int> streakCurrent,
  Value<int> streakLongest,
  Value<int> streakFreezes,
  Value<DateTime?> lastActiveDay,
  Value<String?> lastFreezeWeek,
  Value<int> dailyGoalXp,
  Value<bool> soundEnabled,
  Value<bool> showHarakat,
  Value<bool> premium,
  Value<bool> onboarded,
  Value<String?> nickname,
});
typedef $$UserStateTableTableUpdateCompanionBuilder = UserStateTableCompanion
    Function({
  Value<int> id,
  Value<int> hearts,
  Value<DateTime?> heartsNextRegen,
  Value<int> xp,
  Value<int> level,
  Value<int> streakCurrent,
  Value<int> streakLongest,
  Value<int> streakFreezes,
  Value<DateTime?> lastActiveDay,
  Value<String?> lastFreezeWeek,
  Value<int> dailyGoalXp,
  Value<bool> soundEnabled,
  Value<bool> showHarakat,
  Value<bool> premium,
  Value<bool> onboarded,
  Value<String?> nickname,
});

class $$UserStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserStateTableTable> {
  $$UserStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hearts => $composableBuilder(
      column: $table.hearts, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get heartsNextRegen => $composableBuilder(
      column: $table.heartsNextRegen,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakCurrent => $composableBuilder(
      column: $table.streakCurrent, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakLongest => $composableBuilder(
      column: $table.streakLongest, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakFreezes => $composableBuilder(
      column: $table.streakFreezes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastActiveDay => $composableBuilder(
      column: $table.lastActiveDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastFreezeWeek => $composableBuilder(
      column: $table.lastFreezeWeek,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyGoalXp => $composableBuilder(
      column: $table.dailyGoalXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showHarakat => $composableBuilder(
      column: $table.showHarakat, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get premium => $composableBuilder(
      column: $table.premium, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboarded => $composableBuilder(
      column: $table.onboarded, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));
}

class $$UserStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStateTableTable> {
  $$UserStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hearts => $composableBuilder(
      column: $table.hearts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get heartsNextRegen => $composableBuilder(
      column: $table.heartsNextRegen,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakCurrent => $composableBuilder(
      column: $table.streakCurrent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakLongest => $composableBuilder(
      column: $table.streakLongest,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakFreezes => $composableBuilder(
      column: $table.streakFreezes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastActiveDay => $composableBuilder(
      column: $table.lastActiveDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastFreezeWeek => $composableBuilder(
      column: $table.lastFreezeWeek,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyGoalXp => $composableBuilder(
      column: $table.dailyGoalXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showHarakat => $composableBuilder(
      column: $table.showHarakat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get premium => $composableBuilder(
      column: $table.premium, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboarded => $composableBuilder(
      column: $table.onboarded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));
}

class $$UserStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStateTableTable> {
  $$UserStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hearts =>
      $composableBuilder(column: $table.hearts, builder: (column) => column);

  GeneratedColumn<DateTime> get heartsNextRegen => $composableBuilder(
      column: $table.heartsNextRegen, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get streakCurrent => $composableBuilder(
      column: $table.streakCurrent, builder: (column) => column);

  GeneratedColumn<int> get streakLongest => $composableBuilder(
      column: $table.streakLongest, builder: (column) => column);

  GeneratedColumn<int> get streakFreezes => $composableBuilder(
      column: $table.streakFreezes, builder: (column) => column);

  GeneratedColumn<DateTime> get lastActiveDay => $composableBuilder(
      column: $table.lastActiveDay, builder: (column) => column);

  GeneratedColumn<String> get lastFreezeWeek => $composableBuilder(
      column: $table.lastFreezeWeek, builder: (column) => column);

  GeneratedColumn<int> get dailyGoalXp => $composableBuilder(
      column: $table.dailyGoalXp, builder: (column) => column);

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled, builder: (column) => column);

  GeneratedColumn<bool> get showHarakat => $composableBuilder(
      column: $table.showHarakat, builder: (column) => column);

  GeneratedColumn<bool> get premium =>
      $composableBuilder(column: $table.premium, builder: (column) => column);

  GeneratedColumn<bool> get onboarded =>
      $composableBuilder(column: $table.onboarded, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);
}

class $$UserStateTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserStateTableTable,
    UserStateRow,
    $$UserStateTableTableFilterComposer,
    $$UserStateTableTableOrderingComposer,
    $$UserStateTableTableAnnotationComposer,
    $$UserStateTableTableCreateCompanionBuilder,
    $$UserStateTableTableUpdateCompanionBuilder,
    (
      UserStateRow,
      BaseReferences<_$AppDatabase, $UserStateTableTable, UserStateRow>
    ),
    UserStateRow,
    PrefetchHooks Function()> {
  $$UserStateTableTableTableManager(
      _$AppDatabase db, $UserStateTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStateTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> hearts = const Value.absent(),
            Value<DateTime?> heartsNextRegen = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> streakCurrent = const Value.absent(),
            Value<int> streakLongest = const Value.absent(),
            Value<int> streakFreezes = const Value.absent(),
            Value<DateTime?> lastActiveDay = const Value.absent(),
            Value<String?> lastFreezeWeek = const Value.absent(),
            Value<int> dailyGoalXp = const Value.absent(),
            Value<bool> soundEnabled = const Value.absent(),
            Value<bool> showHarakat = const Value.absent(),
            Value<bool> premium = const Value.absent(),
            Value<bool> onboarded = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
          }) =>
              UserStateTableCompanion(
            id: id,
            hearts: hearts,
            heartsNextRegen: heartsNextRegen,
            xp: xp,
            level: level,
            streakCurrent: streakCurrent,
            streakLongest: streakLongest,
            streakFreezes: streakFreezes,
            lastActiveDay: lastActiveDay,
            lastFreezeWeek: lastFreezeWeek,
            dailyGoalXp: dailyGoalXp,
            soundEnabled: soundEnabled,
            showHarakat: showHarakat,
            premium: premium,
            onboarded: onboarded,
            nickname: nickname,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> hearts = const Value.absent(),
            Value<DateTime?> heartsNextRegen = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> streakCurrent = const Value.absent(),
            Value<int> streakLongest = const Value.absent(),
            Value<int> streakFreezes = const Value.absent(),
            Value<DateTime?> lastActiveDay = const Value.absent(),
            Value<String?> lastFreezeWeek = const Value.absent(),
            Value<int> dailyGoalXp = const Value.absent(),
            Value<bool> soundEnabled = const Value.absent(),
            Value<bool> showHarakat = const Value.absent(),
            Value<bool> premium = const Value.absent(),
            Value<bool> onboarded = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
          }) =>
              UserStateTableCompanion.insert(
            id: id,
            hearts: hearts,
            heartsNextRegen: heartsNextRegen,
            xp: xp,
            level: level,
            streakCurrent: streakCurrent,
            streakLongest: streakLongest,
            streakFreezes: streakFreezes,
            lastActiveDay: lastActiveDay,
            lastFreezeWeek: lastFreezeWeek,
            dailyGoalXp: dailyGoalXp,
            soundEnabled: soundEnabled,
            showHarakat: showHarakat,
            premium: premium,
            onboarded: onboarded,
            nickname: nickname,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserStateTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserStateTableTable,
    UserStateRow,
    $$UserStateTableTableFilterComposer,
    $$UserStateTableTableOrderingComposer,
    $$UserStateTableTableAnnotationComposer,
    $$UserStateTableTableCreateCompanionBuilder,
    $$UserStateTableTableUpdateCompanionBuilder,
    (
      UserStateRow,
      BaseReferences<_$AppDatabase, $UserStateTableTable, UserStateRow>
    ),
    UserStateRow,
    PrefetchHooks Function()>;
typedef $$ExerciseLogTableCreateCompanionBuilder = ExerciseLogCompanion
    Function({
  Value<int> id,
  Value<String?> nodeId,
  required String exerciseType,
  required bool correct,
  required DateTime timestamp,
});
typedef $$ExerciseLogTableUpdateCompanionBuilder = ExerciseLogCompanion
    Function({
  Value<int> id,
  Value<String?> nodeId,
  Value<String> exerciseType,
  Value<bool> correct,
  Value<DateTime> timestamp,
});

class $$ExerciseLogTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseLogTable> {
  $$ExerciseLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nodeId => $composableBuilder(
      column: $table.nodeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get correct => $composableBuilder(
      column: $table.correct, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ExerciseLogTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseLogTable> {
  $$ExerciseLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nodeId => $composableBuilder(
      column: $table.nodeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get correct => $composableBuilder(
      column: $table.correct, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ExerciseLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseLogTable> {
  $$ExerciseLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nodeId =>
      $composableBuilder(column: $table.nodeId, builder: (column) => column);

  GeneratedColumn<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType, builder: (column) => column);

  GeneratedColumn<bool> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ExerciseLogTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseLogTable,
    ExerciseLogRow,
    $$ExerciseLogTableFilterComposer,
    $$ExerciseLogTableOrderingComposer,
    $$ExerciseLogTableAnnotationComposer,
    $$ExerciseLogTableCreateCompanionBuilder,
    $$ExerciseLogTableUpdateCompanionBuilder,
    (
      ExerciseLogRow,
      BaseReferences<_$AppDatabase, $ExerciseLogTable, ExerciseLogRow>
    ),
    ExerciseLogRow,
    PrefetchHooks Function()> {
  $$ExerciseLogTableTableManager(_$AppDatabase db, $ExerciseLogTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            Value<String> exerciseType = const Value.absent(),
            Value<bool> correct = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              ExerciseLogCompanion(
            id: id,
            nodeId: nodeId,
            exerciseType: exerciseType,
            correct: correct,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            required String exerciseType,
            required bool correct,
            required DateTime timestamp,
          }) =>
              ExerciseLogCompanion.insert(
            id: id,
            nodeId: nodeId,
            exerciseType: exerciseType,
            correct: correct,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExerciseLogTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseLogTable,
    ExerciseLogRow,
    $$ExerciseLogTableFilterComposer,
    $$ExerciseLogTableOrderingComposer,
    $$ExerciseLogTableAnnotationComposer,
    $$ExerciseLogTableCreateCompanionBuilder,
    $$ExerciseLogTableUpdateCompanionBuilder,
    (
      ExerciseLogRow,
      BaseReferences<_$AppDatabase, $ExerciseLogTable, ExerciseLogRow>
    ),
    ExerciseLogRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LettersTableTableManager get letters =>
      $$LettersTableTableManager(_db, _db.letters);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$ReadingPassagesTableTableManager get readingPassages =>
      $$ReadingPassagesTableTableManager(_db, _db.readingPassages);
  $$PassageLinesTableTableManager get passageLines =>
      $$PassageLinesTableTableManager(_db, _db.passageLines);
  $$CurriculumNodesTableTableManager get curriculumNodes =>
      $$CurriculumNodesTableTableManager(_db, _db.curriculumNodes);
  $$NodeProgressTableTableManager get nodeProgress =>
      $$NodeProgressTableTableManager(_db, _db.nodeProgress);
  $$ReviewStatesTableTableManager get reviewStates =>
      $$ReviewStatesTableTableManager(_db, _db.reviewStates);
  $$UserStateTableTableTableManager get userStateTable =>
      $$UserStateTableTableTableManager(_db, _db.userStateTable);
  $$ExerciseLogTableTableManager get exerciseLog =>
      $$ExerciseLogTableTableManager(_db, _db.exerciseLog);
}
