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
  final Map<String, int> _questionIndexByStage = {};
  final Set<int> _dismissedInsightStages = {};
  bool _restoredStageIndex = false;
  bool _movingForward = true;
  bool _showFinalReveal = false;

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
    final stageKey = _stageKey(currentStage);
    final questionIndex = _resolvedQuestionIndex(currentStage, appState);
    final currentQuestion = currentStage.questions[questionIndex];
    final currentAnswered = _isQuestionAnswered(appState, currentQuestion.id);
    final showMidJourneyInsight = _shouldShowMidJourneyInsight(
      displayStageIndex,
    );
    final showFinalReveal =
        !showMidJourneyInsight &&
        _showFinalReveal &&
        displayStageIndex == stages.length - 1 &&
        questionIndex == currentStage.questions.length - 1 &&
        currentAnswered &&
        appState.canCalculateCompatibility;

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
                  answered: appState.answeredQuestionsFor(
                    ParticipantSlot.userA,
                  ),
                  total: totalQuestions,
                ),
                const SizedBox(height: 10),
                _ProgressRow(
                  label: context.tr('userB'),
                  answered: appState.answeredQuestionsFor(
                    ParticipantSlot.userB,
                  ),
                  total: totalQuestions,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('stageProgress'),
            icon: Icons.view_carousel_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
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
                const SizedBox(height: 14),
                Text(
                  _questionProgressLabel(
                    context,
                    questionIndex + 1,
                    currentStage.questions.length,
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: currentStage.questions.isEmpty
                      ? 0
                      : (questionIndex + 1) / currentStage.questions.length,
                ),
              ],
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
                showFinalReveal
                    ? 'final-reveal:$stageKey'
                    : showMidJourneyInsight
                    ? 'mid-insight:$displayStageIndex'
                    : '$stageKey:${currentQuestion.id}',
              ),
              title: context.tr(currentStage.titleKey),
              icon: currentStage.icon,
              child: showFinalReveal
                  ? _FinalRevealCard(
                      title: context.tr('finalRevealTitle'),
                      body: context.tr('finalRevealBody'),
                    )
                  : showMidJourneyInsight
                  ? _MidJourneyInsightCard(
                      title: context.tr('midJourneyInsightTitle'),
                      body: _midJourneyInsight(
                        context,
                        appState,
                        stages,
                        displayStageIndex,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InsightBanner(
                          title: context.tr('stageInsight'),
                          body: _stageInsight(context, appState, currentStage),
                        ),
                        const SizedBox(height: 16),
                        _QuestionTile(
                          question: currentQuestion,
                          languageCode: languageCode,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              currentAnswered
                                  ? Icons.check_circle_rounded
                                  : Icons.timelapse_rounded,
                              size: 18,
                              color: currentAnswered
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                currentAnswered
                                    ? context.tr('questionReadyToAdvance')
                                    : context.tr('questionAwaitingAnswer'),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final stackActions = constraints.maxWidth < 460;
              final previousButton = OutlinedButton.icon(
                onPressed:
                    _previousActionEnabled(
                      displayStageIndex,
                      questionIndex,
                      showFinalReveal,
                    )
                    ? () => _goPrevious(
                        context.read<AppState>(),
                        displayStageIndex,
                        questionIndex,
                        currentStage,
                        showFinalReveal,
                      )
                    : null,
                icon: const Icon(Icons.arrow_back_rounded),
                label: Text(
                  showFinalReveal
                      ? context.tr('reviewLastQuestion')
                      : questionIndex > 0
                      ? context.tr('previousQuestion')
                      : context.tr('reviewPreviousStage'),
                ),
              );
              final forwardButton = _buildForwardButton(
                context,
                appState,
                stages,
                displayStageIndex,
                currentStage,
                questionIndex,
                currentAnswered,
                showMidJourneyInsight,
                showFinalReveal,
              );

              if (stackActions) {
                return Column(
                  children: [
                    SizedBox(width: double.infinity, child: previousButton),
                    const SizedBox(height: 10),
                    SizedBox(width: double.infinity, child: forwardButton),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: previousButton),
                  const SizedBox(width: 12),
                  Expanded(child: forwardButton),
                ],
              );
            },
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
    final aCount = appState.userA?.answers.keys.where(ids.contains).length ?? 0;
    final bCount = appState.userB?.answers.keys.where(ids.contains).length ?? 0;
    return aCount == ids.length && bCount == ids.length;
  }

  bool _previousActionEnabled(
    int stageIndex,
    int questionIndex,
    bool showFinalReveal,
  ) {
    if (showFinalReveal) return true;
    return questionIndex > 0 || stageIndex > 0;
  }

  int _resolvedQuestionIndex(_QuestionStage stage, AppState appState) {
    final key = _stageKey(stage);
    final stored = _questionIndexByStage[key];
    if (stored != null && stored >= 0 && stored < stage.questions.length) {
      return stored;
    }

    final firstUnanswered = stage.questions.indexWhere(
      (question) => !_isQuestionAnswered(appState, question.id),
    );
    final initialIndex = firstUnanswered == -1 ? 0 : firstUnanswered;
    _questionIndexByStage[key] = initialIndex;
    return initialIndex;
  }

  bool _isQuestionAnswered(AppState appState, String questionId) {
    final aAnswered = appState.userA?.answers.containsKey(questionId) ?? false;
    final bAnswered = appState.userB?.answers.containsKey(questionId) ?? false;
    return aAnswered && bAnswered;
  }

  String _stageKey(_QuestionStage stage) {
    return '${stage.titleKey}:${stage.questions.map((q) => q.id).join(",")}';
  }

  Future<void> _setQuestionIndex(_QuestionStage stage, int index) async {
    setState(() {
      _showFinalReveal = false;
      _questionIndexByStage[_stageKey(stage)] = index;
    });
  }

  Future<void> _goPrevious(
    AppState appState,
    int displayStageIndex,
    int questionIndex,
    _QuestionStage currentStage,
    bool showFinalReveal,
  ) async {
    if (showFinalReveal) {
      setState(() {
        _movingForward = false;
        _showFinalReveal = false;
      });
      return;
    }
    if (questionIndex > 0) {
      setState(() {
        _movingForward = false;
      });
      await _setQuestionIndex(currentStage, questionIndex - 1);
      return;
    }
    if (displayStageIndex > 0) {
      await _setStageIndex(appState, displayStageIndex - 1, false);
    }
  }

  Widget _buildForwardButton(
    BuildContext context,
    AppState appState,
    List<_QuestionStage> stages,
    int displayStageIndex,
    _QuestionStage currentStage,
    int questionIndex,
    bool currentAnswered,
    bool showMidJourneyInsight,
    bool showFinalReveal,
  ) {
    if (showMidJourneyInsight) {
      return FilledButton.icon(
        onPressed: () {
          setState(() {
            _movingForward = true;
            _dismissedInsightStages.add(displayStageIndex);
          });
        },
        icon: const Icon(Icons.auto_awesome_rounded),
        label: Text(context.tr('midJourneyContinue')),
      );
    }

    if (showFinalReveal) {
      return FilledButton.icon(
        onPressed: () => _calculateAndOpenResults(context),
        icon: const Icon(Icons.auto_graph_rounded),
        label: Text(context.tr('finalRevealPrimary')),
      );
    }

    final isLastQuestion = questionIndex == currentStage.questions.length - 1;
    final isLastStage = displayStageIndex == stages.length - 1;

    if (!isLastQuestion) {
      return FilledButton.icon(
        onPressed: currentAnswered
            ? () async {
                setState(() {
                  _movingForward = true;
                });
                await _setQuestionIndex(currentStage, questionIndex + 1);
              }
            : null,
        icon: const Icon(Icons.arrow_forward_rounded),
        label: Text(context.tr('nextQuestion')),
      );
    }

    if (!isLastStage) {
      return FilledButton.icon(
        onPressed: currentAnswered
            ? () => _setStageIndex(
                context.read<AppState>(),
                displayStageIndex + 1,
                true,
              )
            : null,
        icon: const Icon(Icons.arrow_forward_rounded),
        label: Text(context.tr('continueToNextStage')),
      );
    }

    return FilledButton.icon(
      onPressed: appState.canCalculateCompatibility
          ? () {
              setState(() {
                _movingForward = true;
                _showFinalReveal = true;
              });
            }
          : null,
      icon: const Icon(Icons.visibility_outlined),
      label: Text(context.tr('finalRevealTitle')),
    );
  }

  Future<void> _calculateAndOpenResults(BuildContext context) async {
    final success = await context.read<AppState>().calculateCompatibility();
    if (!context.mounted) return;
    if (success) {
      Navigator.pushNamed(context, AppRoutes.results);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('completeQuestionnaire'))),
      );
    }
  }

  bool _shouldShowMidJourneyInsight(int stageIndex) {
    return stageIndex > 0 &&
        stageIndex.isEven &&
        !_dismissedInsightStages.contains(stageIndex);
  }

  String _midJourneyInsight(
    BuildContext context,
    AppState appState,
    List<_QuestionStage> stages,
    int stageIndex,
  ) {
    final relevantStages = stages
        .sublist(stageIndex >= 2 ? stageIndex - 2 : 0, stageIndex)
        .where((stage) => stage.questions.isNotEmpty)
        .toList();
    final stageNames = relevantStages
        .map((stage) => context.tr(stage.titleKey))
        .join(' + ');

    final gaps = <int>[];
    final averages = <double>[];
    for (final stage in relevantStages) {
      for (final question in stage.questions) {
        final a = appState.userA?.answers[question.id];
        final b = appState.userB?.answers[question.id];
        if (a == null || b == null) continue;
        gaps.add((a - b).abs());
        averages.add((a + b) / 2);
      }
    }

    if (gaps.isEmpty || averages.isEmpty) {
      return _replaceStages(context.tr('midJourneyMixed'), stageNames);
    }

    final avgGap = gaps.reduce((a, b) => a + b) / gaps.length;
    final avgScore = averages.reduce((a, b) => a + b) / averages.length;

    if (avgGap <= 1 && avgScore >= 3.7) {
      return _replaceStages(context.tr('midJourneyStrong'), stageNames);
    }
    if (avgGap >= 1.6) {
      return _replaceStages(context.tr('midJourneyGap'), stageNames);
    }
    return _replaceStages(context.tr('midJourneyMixed'), stageNames);
  }

  String _replaceStages(String template, String stagesLabel) {
    return template.replaceFirst('{stages}', stagesLabel);
  }

  String _questionProgressLabel(BuildContext context, int current, int total) {
    return context
        .tr('questionOfStage')
        .replaceFirst('{current}', '$current')
        .replaceFirst('{total}', '$total');
  }

  String _stageInsight(
    BuildContext context,
    AppState appState,
    _QuestionStage stage,
  ) {
    final answeredQuestions = stage.questions
        .where((question) => _isQuestionAnswered(appState, question.id))
        .toList();
    if (answeredQuestions.isEmpty) {
      return context.tr('stageInsightPrompt');
    }

    final gaps = <int>[];
    final averages = <double>[];
    for (final question in answeredQuestions) {
      final a = appState.userA?.answers[question.id];
      final b = appState.userB?.answers[question.id];
      if (a == null || b == null) continue;
      gaps.add((a - b).abs());
      averages.add((a + b) / 2);
    }

    if (gaps.isEmpty || averages.isEmpty) {
      return context.tr('stageInsightPrompt');
    }

    final avgGap = gaps.reduce((a, b) => a + b) / gaps.length;
    final avgScore = averages.reduce((a, b) => a + b) / averages.length;

    if (avgGap <= 1 && avgScore >= 3.7) {
      return context.tr('stageInsightStrong');
    }
    if (avgGap >= 1.6) {
      return context.tr('stageInsightGap');
    }
    return context.tr('stageInsightMixed');
  }

  Future<void> _setStageIndex(
    AppState appState,
    int value,
    bool movingForward,
  ) async {
    setState(() {
      _movingForward = movingForward;
      _showFinalReveal = false;
      _stageIndex = value;
    });
    await appState.setPersonalityStageIndex(value);
  }
}

class _InsightBanner extends StatelessWidget {
  const _InsightBanner({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _MidJourneyInsightCard extends StatelessWidget {
  const _MidJourneyInsightCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(body, style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }
}

class _FinalRevealCard extends StatelessWidget {
  const _FinalRevealCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(body, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _RevealTag(
              icon: Icons.auto_awesome_outlined,
              labelKey: 'archetypeSummary',
            ),
            _RevealTag(
              icon: Icons.insights_outlined,
              labelKey: 'personalityMap',
            ),
            _RevealTag(
              icon: Icons.chat_bubble_outline_rounded,
              labelKey: 'whatToDiscussNow',
            ),
          ],
        ),
      ],
    );
  }
}

class _RevealTag extends StatelessWidget {
  const _RevealTag({required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.55,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            context.tr(labelKey),
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
    final aValue = appState.userA?.answers[question.id];
    final bValue = appState.userB?.answers[question.id];
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
          const SizedBox(height: 4),
          Text(
            context.tr('answerBothUsersPrompt'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
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
  final int? value;
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
        LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 420;
            final scoreText = Text(
              value == null ? '-/5' : '$value/5',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lowAnchor, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 4),
                  scoreText,
                  const SizedBox(height: 4),
                  Text(highAnchor, style: theme.textTheme.bodySmall),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: Text(lowAnchor, style: theme.textTheme.bodySmall),
                ),
                const SizedBox(width: 8),
                scoreText,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    highAnchor,
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            );
          },
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
