import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/sound_service.dart';
import '../../../core/gamification/lesson_result.dart';
import '../../../core/gamification/xp_calculator.dart';
import '../../../core/providers/app_providers.dart';
import '../../path/data/path_models.dart';
import '../../path/data/path_repository.dart';
import '../../profile/data/user_repository.dart';
import '../../review/data/review_repository.dart';
import '../data/lesson_repository.dart';
import '../domain/exercise.dart';

enum LessonPhase { loading, answering, feedback, outOfHearts, finished, empty }

class LessonSummary {
  const LessonSummary({
    required this.xp,
    required this.leveledUp,
    required this.newLevel,
    required this.streak,
    required this.stars,
    required this.result,
  });

  final int xp;
  final bool leveledUp;
  final int newLevel;
  final int streak;
  final int stars;
  final LessonResult result;
}

class LessonState {
  const LessonState({
    this.phase = LessonPhase.loading,
    this.exercises = const [],
    this.index = 0,
    this.hearts = 5,
    this.unlimitedHearts = false,
    this.lastCorrect,
    this.correctFirstTry = 0,
    this.wrong = 0,
    this.combo = 0,
    this.longestCombo = 0,
    this.summary,
  });

  final LessonPhase phase;
  final List<Exercise> exercises;
  final int index;
  final int hearts;
  final bool unlimitedHearts;
  final bool? lastCorrect;
  final int correctFirstTry;
  final int wrong;
  final int combo;
  final int longestCombo;
  final LessonSummary? summary;

  Exercise? get current =>
      index >= 0 && index < exercises.length ? exercises[index] : null;

  double get progress =>
      exercises.isEmpty ? 0 : (index / exercises.length).clamp(0, 1);

  LessonState copyWith({
    LessonPhase? phase,
    List<Exercise>? exercises,
    int? index,
    int? hearts,
    bool? unlimitedHearts,
    Object? lastCorrect = _sentinel,
    int? correctFirstTry,
    int? wrong,
    int? combo,
    int? longestCombo,
    LessonSummary? summary,
  }) {
    return LessonState(
      phase: phase ?? this.phase,
      exercises: exercises ?? this.exercises,
      index: index ?? this.index,
      hearts: hearts ?? this.hearts,
      unlimitedHearts: unlimitedHearts ?? this.unlimitedHearts,
      lastCorrect:
          identical(lastCorrect, _sentinel) ? this.lastCorrect : lastCorrect as bool?,
      correctFirstTry: correctFirstTry ?? this.correctFirstTry,
      wrong: wrong ?? this.wrong,
      combo: combo ?? this.combo,
      longestCombo: longestCombo ?? this.longestCombo,
      summary: summary ?? this.summary,
    );
  }

  static const _sentinel = Object();
}

class LessonController extends StateNotifier<LessonState> {
  LessonController(this._ref, this.node) : super(const LessonState()) {
    _init();
  }

  final Ref _ref;
  final PathNode node;

  bool _currentHadError = false;

  LessonRepository get _lessons => LessonRepository(
        _ref.read(databaseProvider),
        ReviewRepository(_ref.read(databaseProvider)),
      );
  ReviewRepository get _reviews => ReviewRepository(_ref.read(databaseProvider));
  UserRepository get _users => UserRepository(_ref.read(databaseProvider));
  PathRepository get _paths => PathRepository(_ref.read(databaseProvider));
  SoundService get _sound => _ref.read(soundServiceProvider);

  DateTime get _now => DateTime.now();

  Future<void> _init() async {
    final userRow = await _users.current();
    final heartsState = await _users.regenHearts(_now);
    final exercises = await _lessons.buildForNode(node, rng: Random(), now: _now);
    if (exercises.isEmpty) {
      state = state.copyWith(phase: LessonPhase.empty);
      return;
    }
    state = state.copyWith(
      phase: LessonPhase.answering,
      exercises: exercises,
      hearts: heartsState.current,
      unlimitedHearts: userRow.premium,
    );
  }

  /// Grades the current exercise. [reviewKeys] are the FSRS items it exercised.
  Future<void> grade(bool correct, List<String> reviewKeys) async {
    if (state.phase != LessonPhase.answering) return;
    final ex = state.current;
    if (ex == null) return;

    await _lessons.logAnswer(
        nodeId: node.id, kind: ex.kind, correct: correct, now: _now,);
    for (final key in reviewKeys) {
      await _reviews.recordAnswer(key, correct: correct, now: _now);
    }

    if (correct) {
      final combo = state.combo + 1;
      await _sound.play(Sfx.correct);
      state = state.copyWith(
        phase: LessonPhase.feedback,
        lastCorrect: true,
        combo: combo,
        longestCombo: max(state.longestCombo, combo),
        correctFirstTry:
            _currentHadError ? state.correctFirstTry : state.correctFirstTry + 1,
      );
    } else {
      _currentHadError = true;
      await _sound.play(Sfx.wrong);
      var hearts = state.hearts;
      if (!state.unlimitedHearts) {
        final next = await _users.spendHeart(_now);
        hearts = next.current;
      }
      state = state.copyWith(
        phase: LessonPhase.feedback,
        lastCorrect: false,
        combo: 0,
        wrong: state.wrong + 1,
        hearts: hearts,
      );
    }
  }

  Future<void> advance() async {
    if (state.phase != LessonPhase.feedback) return;
    if (!state.unlimitedHearts && state.hearts <= 0) {
      state = state.copyWith(phase: LessonPhase.outOfHearts);
      return;
    }
    final nextIndex = state.index + 1;
    if (nextIndex >= state.exercises.length) {
      await _finish();
      return;
    }
    _currentHadError = false;
    state = state.copyWith(
      index: nextIndex,
      phase: LessonPhase.answering,
      lastCorrect: null,
    );
  }

  Future<void> _finish() async {
    final result = LessonResult(
      totalExercises: state.exercises.length,
      correctFirstTry: state.correctFirstTry,
      wrongAnswers: state.wrong,
      longestCombo: state.longestCombo,
    );
    final premium = state.unlimitedHearts;
    final xp = const XpCalculator().compute(result, multiplier: premium ? 1.2 : 1.0);
    final stars = result.isFlawless ? 3 : (state.wrong <= 2 ? 2 : 1);

    final outcome = await _users.applyCompletion(xpGained: xp, now: _now);
    await _paths.completeNode(node.id, stars: stars, score: state.correctFirstTry);

    // Review/practice lessons restore hearts (§4.3: "pratik yaparak kazan").
    if (node.type == NodeType.review) {
      await _users.refillHearts();
    }

    await _sound.play(Sfx.lessonComplete);

    state = state.copyWith(
      phase: LessonPhase.finished,
      summary: LessonSummary(
        xp: xp,
        leveledUp: outcome.leveledUp,
        newLevel: outcome.newLevel,
        streak: outcome.streak,
        stars: stars,
        result: result,
      ),
    );
  }
}

final lessonControllerProvider = StateNotifierProvider.autoDispose
    .family<LessonController, LessonState, PathNode>(
  (ref, node) => LessonController(ref, node),
);
