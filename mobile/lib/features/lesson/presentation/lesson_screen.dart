import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/gamification/transliteration_matcher.dart';
import '../../../core/mascot/mascot_state.dart';
import '../../../core/mascot/mascot_view.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/ottoman_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../paywall/presentation/paywall_screen.dart';
import '../../path/data/path_models.dart';
import '../domain/exercise.dart';
import 'lesson_controller.dart';

class LessonScreen extends ConsumerWidget {
  const LessonScreen({super.key, required this.node});
  final PathNode node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonControllerProvider(node));
    final l10n = AppLocalizations.of(context)!;

    return switch (state.phase) {
      LessonPhase.loading => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      LessonPhase.empty => Scaffold(
          appBar: AppBar(),
          body: const Center(child: Text('Bu ders için içerik bulunamadı.')),
        ),
      LessonPhase.outOfHearts => _OutOfHeartsView(node: node),
      LessonPhase.finished =>
        _LessonResultView(node: node, summary: state.summary!),
      _ => _LessonPlayView(node: node, state: state, l10n: l10n),
    };
  }
}

class _LessonPlayView extends ConsumerWidget {
  const _LessonPlayView({
    required this.node,
    required this.state,
    required this.l10n,
  });
  final PathNode node;
  final LessonState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ex = state.current!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: state.progress,
            minHeight: 12,
            backgroundColor: AppColors.locked.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation(AppColors.success),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(children: [
              const Icon(Icons.favorite, color: AppColors.heart, size: 20),
              const SizedBox(width: 4),
              Text(state.unlimitedHearts ? '∞' : '${state.hearts}',
                  style: const TextStyle(fontWeight: FontWeight.w700),),
            ],),
          ),
        ],
      ),
      body: _ExerciseView(
        key: ValueKey(state.index),
        node: node,
        exercise: ex,
        state: state,
        l10n: l10n,
      ),
    );
  }
}

/// Renders whichever exercise kind is current and owns the check/continue flow.
class _ExerciseView extends ConsumerStatefulWidget {
  const _ExerciseView({
    super.key,
    required this.node,
    required this.exercise,
    required this.state,
    required this.l10n,
  });

  final PathNode node;
  final Exercise exercise;
  final LessonState state;
  final AppLocalizations l10n;

  @override
  ConsumerState<_ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends ConsumerState<_ExerciseView> {
  static const _matcher = TransliterationMatcher();
  int? _selected;
  final _typed = TextEditingController();
  bool _showHarakat = true;
  final Map<String, String> _matches = {}; // ottoman key -> tr chosen
  String? _pendingOttoman;

  bool? _lastCorrect;

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  LessonController get _controller =>
      ref.read(lessonControllerProvider(widget.node).notifier);

  bool get _isFeedback => widget.state.phase == LessonPhase.feedback;

  bool _answerReady() {
    final ex = widget.exercise;
    if (ex is ChoiceExercise) return _selected != null;
    if (ex is TypingExercise) return _typed.text.trim().isNotEmpty;
    if (ex is MatchExercise) return _matches.length == ex.pairs.length;
    return false;
  }

  Future<void> _check() async {
    final ex = widget.exercise;
    bool correct;
    if (ex is ChoiceExercise) {
      correct = _selected == ex.correctIndex;
    } else if (ex is TypingExercise) {
      correct = _matcher.matches(_typed.text, ex.expected);
    } else {
      correct = true; // MatchExercise only locks correct pairs.
    }
    setState(() => _lastCorrect = correct);
    await _controller.grade(correct, ex.reviewKeys);
  }

  @override
  Widget build(BuildContext context) {
    final ex = widget.exercise;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: switch (ex) {
              ChoiceExercise() => _buildChoice(ex),
              TypingExercise() => _buildTyping(ex),
              MatchExercise() => _buildMatch(ex),
            },
          ),
        ),
        _FeedbackBar(
          isFeedback: _isFeedback,
          correct: _lastCorrect,
          canCheck: _answerReady(),
          expected: ex is TypingExercise ? ex.expected : null,
          gloss: ex is TypingExercise ? ex.simplifiedTr : null,
          onCheck: _check,
          onContinue: () => _controller.advance(),
          l10n: widget.l10n,
        ),
      ],
    );
  }

  // --- Choice (kinds 1,2,3) ---
  Widget _buildChoice(ChoiceExercise ex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_promptLabel(ex.kind),
            style: Theme.of(context).textTheme.titleMedium,),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            child: ex.promptIsOttoman
                ? OttomanText(ex.prompt, size: OttomanTextSize.prompt)
                : Text(ex.prompt,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,),
          ),
        ),
        const SizedBox(height: 24),
        ...ex.options.asMap().entries.map((e) {
          final i = e.key;
          final opt = e.value;
          final selected = _selected == i;
          Color? border;
          if (_isFeedback) {
            if (i == ex.correctIndex) {
              border = AppColors.success;
            } else if (selected) {
              border = AppColors.error;
            }
          } else if (selected) {
            border = AppColors.gold;
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: _isFeedback ? null : () => setState(() => _selected = i),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                constraints: const BoxConstraints(minHeight: 56),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: border ?? Theme.of(context).colorScheme.outlineVariant,
                    width: border != null ? 2.5 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: opt.isOttoman
                    ? OttomanText(opt.text, size: OttomanTextSize.standard)
                    : Text(opt.text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,),
              ),
            ),
          );
        }),
      ],
    );
  }

  // --- Typing (kinds 4,6) ---
  Widget _buildTyping(TypingExercise ex) {
    final isReading = ex.kind == ExerciseKind.readLine;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.l10n.typeTransliteration,
                style: Theme.of(context).textTheme.titleMedium,),
            Row(children: [
              const Text('Hareke'),
              Switch(
                value: _showHarakat,
                onChanged: (v) => setState(() => _showHarakat = v),
              ),
            ],),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
            child: OttomanText(
              ex.promptOttoman,
              size: isReading ? OttomanTextSize.reading : OttomanTextSize.prompt,
              showHarakat: _showHarakat,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _typed,
          enabled: !_isFeedback,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'okunuşu…',
            border: OutlineInputBorder(),
            filled: true,
          ),
        ),
        if (_isFeedback && isReading && ex.simplifiedTr != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Sadeleştirme: ${ex.simplifiedTr}',
                style: Theme.of(context).textTheme.bodyLarge,),
          ),
      ],
    );
  }

  // --- Match (kind 5) ---
  Widget _buildMatch(MatchExercise ex) {
    final leftDone = _matches.keys.toSet();
    final usedTr = _matches.values.toSet();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.l10n.matchPairs,
            style: Theme.of(context).textTheme.titleMedium,),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: ex.pairs.map((p) {
                  final done = leftDone.contains(p.key);
                  final selected = _pendingOttoman == p.key;
                  return _MatchCell(
                    done: done,
                    selected: selected,
                    onTap: done
                        ? null
                        : () => setState(() => _pendingOttoman = p.key),
                    child: OttomanText(p.ottoman, size: OttomanTextSize.standard),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: (ex.pairs.toList()..sort((a, b) => a.tr.compareTo(b.tr)))
                    .map((p) {
                  final done = usedTr.contains(p.tr);
                  return _MatchCell(
                    done: done,
                    selected: false,
                    onTap: done || _pendingOttoman == null
                        ? null
                        : () => _tryMatch(ex, p.tr),
                    child: Text(p.tr,
                        style: Theme.of(context).textTheme.titleMedium,),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _tryMatch(MatchExercise ex, String tr) {
    final key = _pendingOttoman;
    if (key == null) return;
    final pair = ex.pairs.firstWhere((p) => p.key == key);
    setState(() {
      if (pair.tr == tr) {
        _matches[key] = tr; // correct pair locks
      }
      _pendingOttoman = null;
    });
  }

  String _promptLabel(ExerciseKind kind) => switch (kind) {
        ExerciseKind.chooseMeaning => widget.l10n.chooseMeaning,
        ExerciseKind.chooseOttoman => 'Osmanlıcasını seç',
        ExerciseKind.distinguishLetter => 'Bu harfin sesi hangisi?',
        _ => '',
      };
}

class _MatchCell extends StatelessWidget {
  const _MatchCell({
    required this.child,
    required this.done,
    required this.selected,
    required this.onTap,
  });

  final Widget child;
  final bool done;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Opacity(
          opacity: done ? 0.35 : 1,
          child: Container(
            constraints: const BoxConstraints(minHeight: 56),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? AppColors.gold
                    : Theme.of(context).colorScheme.outlineVariant,
                width: selected ? 2.5 : 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _FeedbackBar extends StatelessWidget {
  const _FeedbackBar({
    required this.isFeedback,
    required this.correct,
    required this.canCheck,
    required this.onCheck,
    required this.onContinue,
    required this.l10n,
    this.expected,
    this.gloss,
  });

  final bool isFeedback;
  final bool? correct;
  final bool canCheck;
  final VoidCallback onCheck;
  final VoidCallback onContinue;
  final AppLocalizations l10n;
  final String? expected;
  final String? gloss;

  @override
  Widget build(BuildContext context) {
    final bg = !isFeedback
        ? null
        : (correct == true
            ? AppColors.success.withValues(alpha: 0.12)
            : AppColors.error.withValues(alpha: 0.12));
    return Container(
      color: bg,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isFeedback)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(correct == true ? Icons.check_circle : Icons.cancel,
                      color: correct == true ? AppColors.success : AppColors.error,),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      correct == true
                          ? l10n.correct
                          : '${l10n.wrong}${expected != null ? ' — $expected' : ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color:
                            correct == true ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          FilledButton(
            onPressed: isFeedback
                ? onContinue
                : (canCheck ? onCheck : null),
            style: FilledButton.styleFrom(
              backgroundColor:
                  isFeedback && correct == false ? AppColors.error : null,
            ),
            child: Text(isFeedback ? l10n.lessonContinue : l10n.lessonCheck),
          ),
        ],
      ),
    );
  }
}

class _OutOfHeartsView extends ConsumerWidget {
  const _OutOfHeartsView({required this.node});
  final PathNode node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MascotView(state: MascotState.sad, size: 140),
            const SizedBox(height: 16),
            Text(l10n.outOfHearts,
                style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: 8),
            Text(l10n.outOfHeartsBody, textAlign: TextAlign.center),
            const SizedBox(height: 32),
            FilledButton.icon(
              icon: const Icon(Icons.workspace_premium),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PaywallScreen()),
              ),
              label: Text(l10n.premiumUnlimitedHearts),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Yola dön'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonResultView extends StatelessWidget {
  const _LessonResultView({required this.node, required this.summary});
  final PathNode node;
  final LessonSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const MascotView(state: MascotState.celebrating, size: 160)
                  .animate()
                  .scale(duration: 400.ms, curve: Curves.elasticOut),
              const SizedBox(height: 16),
              Text(l10n.lessonComplete,
                      style: Theme.of(context).textTheme.headlineMedium,)
                  .animate()
                  .fadeIn(delay: 200.ms),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Icon(
                    i < summary.stars ? Icons.star : Icons.star_border,
                    color: AppColors.gold,
                    size: 40,
                  ).animate().scale(delay: (300 + i * 120).ms),
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                children: [
                  _ResultChip(
                      icon: Icons.star,
                      label: l10n.xpEarned(summary.xp),
                      color: AppColors.teal,),
                  _ResultChip(
                      icon: Icons.local_fire_department,
                      label: l10n.streakDays(summary.streak),
                      color: AppColors.gold,),
                  if (summary.leveledUp)
                    _ResultChip(
                        icon: Icons.trending_up,
                        label: 'Seviye ${summary.newLevel}',
                        color: AppColors.success,),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('Bitir'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultChip extends StatelessWidget {
  const _ResultChip(
      {required this.icon, required this.label, required this.color,});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: color, size: 20),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
