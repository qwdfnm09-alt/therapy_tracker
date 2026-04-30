import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/question.dart';
import '../../providers/app_state.dart';

class PersonalityTestScreen extends StatefulWidget {
  const PersonalityTestScreen({super.key});

  @override
  State<PersonalityTestScreen> createState() => _PersonalityTestScreenState();
}

class _PersonalityTestScreenState extends State<PersonalityTestScreen> {
  int _stageIndex = 0;
  bool _restoredStageIndex = false;
  bool _movingForward = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_restoredStageIndex) return;
    _stageIndex = context.read<AppState>().personalityStageIndex;
    _restoredStageIndex = true;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final languageCode = appState.languageCode;
    final totalQuestions = appState.totalQuestionCount;
    final stages = _buildStages(appState);

    if (_stageIndex >= stages.length) {
      final clampedIndex = stages.isEmpty ? 0 : stages.length - 1;
      if (clampedIndex != _stageIndex) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _setStageIndex(context.read<AppState>(), clampedIndex, false);
        });
      }
    }

    final displayStageIndex = stages.isEmpty
        ? 0
        : _stageIndex.clamp(0, stages.length - 1);
    final currentStage = stages[displayStageIndex];

    return AppPage(
      title: context.tr('personalityTest'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('questionnaireProgress'),
            icon: Icons.checklist_rtl_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('scaleHint'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('personalityIntro'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                _ProgressRow(
                  label: context.tr('userA'),
                  answered: appState.answeredQuestionsFor(ParticipantSlot.userA),
                  total: totalQuestions,
                ),
                const SizedBox(height: 10),
                _ProgressRow(
                  label: context.tr('userB'),
                  answered: appState.answeredQuestionsFor(ParticipantSlot.userB),
                  total: totalQuestions,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('stageProgress'),
            icon: Icons.view_carousel_outlined,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(stages.length, (index) {
                final stage = stages[index];
                return ChoiceChip(
                  label: Text('${index + 1}'),
                  selected: index == displayStageIndex,
                  onSelected: (_) => _setStageIndex(
                    context.read<AppState>(),
                    index,
                    index >= displayStageIndex,
                  ),
                  avatar: Icon(
                    _isStageComplete(appState, stage)
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked,
                    size: 16,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            transitionBuilder: (child, animation) {
              final offsetTween = Tween<Offset>(
                begin: Offset(_movingForward ? 0.18 : -0.18, 0),
                end: Offset.zero,
              );
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(offsetTween),
                  child: child,
                ),
              );
            },
            child: SectionCard(
              key: ValueKey(
                '${currentStage.titleKey}:${currentStage.questions.map((q) => q.id).join(",")}',
              ),
              title: context.tr(currentStage.titleKey),
              icon: currentStage.icon,
              child: Column(
                children: [
                  for (final question in currentStage.questions)
                    _QuestionTile(
                      question: question,
                      languageCode: languageCode,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: displayStageIndex == 0
                      ? null
                      : () => _setStageIndex(
                        context.read<AppState>(),
                        displayStageIndex - 1,
                        false,
                      ),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(context.tr('previousStage')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: displayStageIndex == stages.length - 1
                    ? FilledButton.icon(
                        onPressed: appState.canCalculateCompatibility
                            ? () async {
                                final success = await context
                                    .read<AppState>()
                                    .calculateCompatibility();
                                if (!context.mounted) return;
                                if (success) {
                                  Navigator.pushNamed(context, AppRoutes.results);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.tr('completeQuestionnaire'),
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        icon: const Icon(Icons.analytics_outlined),
                        label: Text(context.tr('calculate')),
                      )
                    : FilledButton.icon(
                        onPressed: () => _setStageIndex(
                          context.read<AppState>(),
                          displayStageIndex + 1,
                          true,
                        ),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: Text(context.tr('nextStage')),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_isStageComplete(appState, currentStage))
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(context.tr('stageComplete')),
              ],
            ),
        ],
      ),
    );
  }

  List<_QuestionStage> _buildStages(AppState appState) {
    final stages = <_QuestionStage>[
      _categoryStage(
        appState,
        QuestionCategory.personality,
        'categoryPersonality',
        Icons.diversity_1_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.emotionalIntelligence,
        'categoryEmotionalIntelligence',
        Icons.psychology_alt_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.angerManagement,
        'categoryAngerManagement',
        Icons.local_fire_department_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.communication,
        'categoryCommunication',
        Icons.forum_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.financialMindset,
        'categoryFinancialMindset',
        Icons.account_balance_wallet_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.familyBoundaries,
        'categoryFamilyBoundaries',
        Icons.family_restroom_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.futureGoals,
        'categoryFutureGoals',
        Icons.flag_outlined,
      ),
      _categoryStage(
        appState,
        QuestionCategory.responsibility,
        'categoryResponsibility',
        Icons.verified_user_outlined,
      ),
    ];

    final adaptiveStages = <_QuestionStage?>[
      _branchStage(
        appState,
        'personality_structure_shift',
        'adaptiveStagePlanning',
        Icons.alt_route_outlined,
      ),
      _branchStage(
        appState,
        'anger_escalation',
        'adaptiveStageAnger',
        Icons.crisis_alert_outlined,
      ),
      _branchStage(
        appState,
        'family_interference',
        'adaptiveStageFamily',
        Icons.groups_2_outlined,
      ),
      _branchStage(
        appState,
        'future_career_tradeoff',
        'adaptiveStageCareer',
        Icons.balance_outlined,
      ),
    ].whereType<_QuestionStage>().toList();

    if (adaptiveStages.isNotEmpty) {
      stages.addAll(adaptiveStages);
    }

    return stages.where((stage) => stage.questions.isNotEmpty).toList();
  }

  _QuestionStage _categoryStage(
    AppState appState,
    QuestionCategory category,
    String titleKey,
    IconData icon,
  ) {
    final questions = appState
        .questionsForCategory(category)
        .where((question) => question.dependsOnQuestionId == null)
        .toList();
    return _QuestionStage(titleKey: titleKey, icon: icon, questions: questions);
  }

  _QuestionStage? _branchStage(
    AppState appState,
    String questionId,
    String titleKey,
    IconData icon,
  ) {
    final questions = appState.activeQuestions
        .where((question) => question.id == questionId)
        .toList();
    if (questions.isEmpty) return null;
    return _QuestionStage(titleKey: titleKey, icon: icon, questions: questions);
  }

  bool _isStageComplete(AppState appState, _QuestionStage stage) {
    final ids = stage.questions.map((q) => q.id).toSet();
    final aCount =
        appState.userA?.answers.keys.where(ids.contains).length ?? 0;
    final bCount =
        appState.userB?.answers.keys.where(ids.contains).length ?? 0;
    return aCount == ids.length && bCount == ids.length;
  }

  Future<void> _setStageIndex(
    AppState appState,
    int value,
    bool movingForward,
  ) async {
    setState(() {
      _movingForward = movingForward;
      _stageIndex = value;
    });
    await appState.setPersonalityStageIndex(value);
  }
}

class _QuestionStage {
  const _QuestionStage({
    required this.titleKey,
    required this.icon,
    required this.questions,
  });

  final String titleKey;
  final IconData icon;
  final List<CompatibilityQuestion> questions;
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({required this.question, required this.languageCode});

  final CompatibilityQuestion question;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final aValue = appState.userA?.answers[question.id] ?? 3;
    final bValue = appState.userB?.answers[question.id] ?? 3;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.title(languageCode),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr('selectClosestAnswer'),
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          _ParticipantChoiceRow(
            label: context.tr('userA'),
            value: aValue,
            lowAnchor: question.lowAnchor(languageCode),
            highAnchor: question.highAnchor(languageCode),
            onChanged: (value) => context.read<AppState>().updateAnswer(
              ParticipantSlot.userA,
              question.id,
              value,
            ),
          ),
          const SizedBox(height: 10),
          _ParticipantChoiceRow(
            label: context.tr('userB'),
            value: bValue,
            lowAnchor: question.lowAnchor(languageCode),
            highAnchor: question.highAnchor(languageCode),
            onChanged: (value) => context.read<AppState>().updateAnswer(
              ParticipantSlot.userB,
              question.id,
              value,
            ),
          ),
          Divider(color: theme.colorScheme.outlineVariant),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.answered,
    required this.total,
  });

  final String label;
  final int answered;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : answered / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label)),
            Text('$answered/$total'),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(value: ratio),
      ],
    );
  }
}

class _ParticipantChoiceRow extends StatelessWidget {
  const _ParticipantChoiceRow({
    required this.label,
    required this.value,
    required this.lowAnchor,
    required this.highAnchor,
    required this.onChanged,
  });

  final String label;
  final int value;
  final String lowAnchor;
  final String highAnchor;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: Text(lowAnchor, style: theme.textTheme.bodySmall)),
            const SizedBox(width: 8),
            Text(
              '$value/5',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                highAnchor,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(5, (index) {
            final score = index + 1;
            final selected = score == value;
            return ChoiceChip(
              label: Text('$score'),
              selected: selected,
              onSelected: (_) => onChanged(score),
              selectedColor: theme.colorScheme.primaryContainer,
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: selected
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
              ),
            );
          }),
        ),
      ],
    );
  }
}
