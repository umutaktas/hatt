import 'package:drift/drift.dart';

/// Drift table definitions for the local-first content + progress store
/// (CLAUDE.md §5). Enum-like fields are stored as text for forward
/// compatibility with the seed JSON.

@DataClassName('LetterRow')
class Letters extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get isolated => text()();
  TextColumn get initialForm => text().named('initial_form')();
  TextColumn get medialForm => text().named('medial_form')();
  TextColumn get finalForm => text().named('final_form')();
  TextColumn get similarGroup => text().named('similar_group').nullable()();
  TextColumn get soundValue => text().named('sound_value')();
  TextColumn get exampleWord => text().named('example_word').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WordRow')
class Words extends Table {
  TextColumn get id => text()();
  TextColumn get ottoman => text()();
  TextColumn get transliteration => text()();
  TextColumn get meaningTr => text().named('meaning_tr')();
  TextColumn get root => text().nullable()();
  IntColumn get frequencyRank => integer().named('frequency_rank')();
  IntColumn get level => integer()();
  TextColumn get exampleSentence => text().named('example_sentence').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ReadingPassageRow')
class ReadingPassages extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get level => integer()();
  TextColumn get genre => text()();
  TextColumn get imageAssetPath => text().named('image_asset_path').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PassageLineRow')
class PassageLines extends Table {
  TextColumn get id => text()();
  TextColumn get passageId => text().named('passage_id')();
  IntColumn get ordinal => integer()();
  TextColumn get ottoman => text()();
  TextColumn get transliteration => text()();
  TextColumn get simplifiedTr => text().named('simplified_tr')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CurriculumNodeRow')
class CurriculumNodes extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // letter | vocab | reading | review | checkpoint
  TextColumn get unitId => text().named('unit_id')();
  TextColumn get unitTitle => text().named('unit_title')();
  IntColumn get ordinal => integer()();
  TextColumn get title => text()();
  TextColumn get contentRefs => text().named('content_refs')(); // JSON array

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('NodeProgressRow')
class NodeProgress extends Table {
  TextColumn get nodeId => text().named('node_id')();
  TextColumn get status => text()(); // locked | available | completed
  IntColumn get stars => integer().withDefault(const Constant(0))();
  IntColumn get bestScore => integer().named('best_score').withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {nodeId};
}

@DataClassName('ReviewStateRow')
class ReviewStates extends Table {
  /// Composite key like `word:istanbul` or `letter:be`.
  TextColumn get itemKey => text().named('item_key')();
  TextColumn get itemType => text().named('item_type')(); // word | letter
  RealColumn get stability => real().withDefault(const Constant(0))();
  RealColumn get difficulty => real().withDefault(const Constant(0))();
  DateTimeColumn get due => dateTime().nullable()();
  DateTimeColumn get lastReview => dateTime().named('last_review').nullable()();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  TextColumn get phase => text().withDefault(const Constant('newCard'))();

  @override
  Set<Column> get primaryKey => {itemKey};
}

@DataClassName('UserStateRow')
class UserStateTable extends Table {
  @override
  String get tableName => 'user_state';

  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get hearts => integer().withDefault(const Constant(5))();
  DateTimeColumn get heartsNextRegen => dateTime().named('hearts_next_regen').nullable()();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get streakCurrent => integer().named('streak_current').withDefault(const Constant(0))();
  IntColumn get streakLongest => integer().named('streak_longest').withDefault(const Constant(0))();
  IntColumn get streakFreezes => integer().named('streak_freezes').withDefault(const Constant(0))();
  DateTimeColumn get lastActiveDay => dateTime().named('last_active_day').nullable()();
  TextColumn get lastFreezeWeek => text().named('last_freeze_week').nullable()();
  IntColumn get dailyGoalXp => integer().named('daily_goal_xp').withDefault(const Constant(30))();
  BoolColumn get soundEnabled => boolean().named('sound_enabled').withDefault(const Constant(true))();
  BoolColumn get showHarakat => boolean().named('show_harakat').withDefault(const Constant(true))();
  BoolColumn get premium => boolean().withDefault(const Constant(false))();
  BoolColumn get onboarded => boolean().withDefault(const Constant(false))();
  TextColumn get nickname => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseLogRow')
class ExerciseLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nodeId => text().named('node_id').nullable()();
  TextColumn get exerciseType => text().named('exercise_type')();
  BoolColumn get correct => boolean()();
  DateTimeColumn get timestamp => dateTime()();
}
