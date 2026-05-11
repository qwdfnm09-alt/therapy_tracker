import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/love_language_quiz_service.dart';
import '../../../data/local/relationship_tools_repository.dart';
import '../../../data/local/weekly_challenge_progress_service.dart';
import '../../../domain/models/content_item.dart';
import '../../../domain/models/love_language_quiz_question.dart';
import '../../../domain/models/love_language_quiz_result.dart';
import '../../../domain/models/weekly_challenge_item.dart';
import '../../../domain/models/weekly_challenge_progress.dart';

class RelationshipToolsScreen extends StatefulWidget {
  const RelationshipToolsScreen({
    super.key,
    this.repository = const RelationshipToolsRepository(),
    this.quizService = const LoveLanguageQuizService(),
    this.weeklyChallengeProgressService =
        const WeeklyChallengeProgressService(),
  });

  final RelationshipToolsRepository repository;
  final LoveLanguageQuizService quizService;
  final WeeklyChallengeProgressService weeklyChallengeProgressService;

  @override
  State<RelationshipToolsScreen> createState() =>
      _RelationshipToolsScreenState();
}

class _RelationshipToolsScreenState extends State<RelationshipToolsScreen> {
  Map<String, String> _selectedOptionIds = const {};
  Set<String> _completedChallengeIds = const {};
  LoveLanguageQuizResult? _savedQuizResult;
  bool _isLoadingTools = true;
  bool _isSavingQuiz = false;

  @override
  void initState() {
    super.initState();
    _loadLocalToolState();
  }

  Future<void> _loadLocalToolState() async {
    final result = await widget.quizService.readResult();
    final challengeProgress = await widget.weeklyChallengeProgressService
        .readProgress();
    if (!mounted) return;

    setState(() {
      _savedQuizResult = result;
      _selectedOptionIds = Map<String, String>.from(
        result?.selectedOptionIds ?? const {},
      );
      _completedChallengeIds = {...?challengeProgress?.completedIds};
      _isLoadingTools = false;
    });
  }

  Future<void> _saveQuizResult(
    BuildContext context,
    List<LoveLanguageQuizQuestion> questions,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final incompleteMessage = context.tr('loveLanguagesQuizIncomplete');
    final savedMessage = context.tr('loveLanguagesQuizSaved');

    final hasAllAnswers = questions.every(
      (question) => _selectedOptionIds.containsKey(question.id),
    );
    if (!hasAllAnswers) {
      messenger.showSnackBar(SnackBar(content: Text(incompleteMessage)));
      return;
    }

    setState(() => _isSavingQuiz = true);

    final result = LoveLanguageQuizResult.fromSelections(
      questions: questions,
      selectedOptionIds: _selectedOptionIds,
    );
    await widget.quizService.saveResult(result);

    if (!mounted) return;
    setState(() {
      _savedQuizResult = result;
      _isSavingQuiz = false;
    });

    messenger.showSnackBar(SnackBar(content: Text(savedMessage)));
  }

  Future<void> _toggleWeeklyChallenge(
    String challengeId,
    bool isCompleted,
  ) async {
    final updatedIds = {..._completedChallengeIds};
    if (isCompleted) {
      updatedIds.add(challengeId);
    } else {
      updatedIds.remove(challengeId);
    }

    setState(() {
      _completedChallengeIds = updatedIds;
    });

    await widget.weeklyChallengeProgressService.saveProgress(
      WeeklyChallengeProgress(
        completedIds: updatedIds.toList()..sort(),
        updatedAtIso: DateTime.now().toIso8601String(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final loveLanguages = widget.repository.loveLanguages();
    final loveLanguageQuestions = widget.repository.loveLanguageQuestions();
    final weeklyChallenges = widget.repository.weeklyChallenges();
    final loveLanguagesKey = GlobalKey();
    final weeklyChallengesKey = GlobalKey();
    final usageKey = GlobalKey();
    final primaryLanguage = _savedQuizResult == null
        ? null
        : widget.repository.loveLanguageById(
            _savedQuizResult!.primaryLanguageId,
          );
    final completedCount = weeklyChallenges
        .where((challenge) => _completedChallengeIds.contains(challenge.id))
        .length;
    final progressSummary = context
        .tr('weeklyChallengesProgressCount')
        .replaceAll('{current}', completedCount.toString())
        .replaceAll('{total}', weeklyChallenges.length.toString());

    return AppPage(
      title: context.tr('relationshipTools'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('relationshipToolsIntroTitle'),
            icon: Icons.favorite_border_rounded,
            child: Text(context.tr('relationshipToolsIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('relationshipToolsOverviewTitle'),
            icon: Icons.insights_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('relationshipToolsOverviewBody'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final useSingleColumn = constraints.maxWidth < 430;
                    return GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: useSingleColumn ? 1 : 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: useSingleColumn ? 126 : 154,
                      ),
                      children: [
                        _OverviewCard(
                          label: context.tr('loveLanguagesTitle'),
                          value: loveLanguages.length.toString(),
                          helper: context.tr('loveLanguagesBody'),
                          icon: Icons.favorite_outline_rounded,
                          color: Colors.pink,
                          onTap: () =>
                              _scrollToSection(loveLanguagesKey.currentContext),
                        ),
                        _OverviewCard(
                          label: context.tr('weeklyChallengesTitle'),
                          value: weeklyChallenges.length.toString(),
                          helper: context.tr('weeklyChallengesBody'),
                          icon: Icons.flag_outlined,
                          color: Colors.teal,
                          onTap: () => _scrollToSection(
                            weeklyChallengesKey.currentContext,
                          ),
                        ),
                        _OverviewCard(
                          label: context.tr('relationshipToolsUsageTitle'),
                          value: '3',
                          helper: context.tr('relationshipToolsOverviewUsage'),
                          icon: Icons.rule_rounded,
                          color: Colors.indigo,
                          onTap: () =>
                              _scrollToSection(usageKey.currentContext),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            key: loveLanguagesKey,
            title: context.tr('loveLanguagesTitle'),
            icon: Icons.favorite_outline_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('loveLanguagesBody'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                _QuizIntroCard(
                  title: context.tr('loveLanguagesQuizTitle'),
                  body: context.tr('loveLanguagesQuizBody'),
                ),
                const SizedBox(height: 12),
                if (_isLoadingTools)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  )
                else ...[
                  if (primaryLanguage != null) ...[
                    _SavedQuizResultCard(
                      title: context.tr('loveLanguagesQuizLatestTitle'),
                      resultLabel: context.tr('loveLanguagesQuizPrimaryLabel'),
                      item: primaryLanguage,
                      languageCode: languageCode,
                    ),
                    const SizedBox(height: 12),
                  ],
                  for (var i = 0; i < loveLanguageQuestions.length; i++) ...[
                    _QuizQuestionCard(
                      question: loveLanguageQuestions[i],
                      languageCode: languageCode,
                      selectedOptionId:
                          _selectedOptionIds[loveLanguageQuestions[i].id],
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionIds = {
                            ..._selectedOptionIds,
                            loveLanguageQuestions[i].id: value,
                          };
                        });
                      },
                    ),
                    if (i != loveLanguageQuestions.length - 1)
                      const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isSavingQuiz
                          ? null
                          : () =>
                                _saveQuizResult(context, loveLanguageQuestions),
                      icon: _isSavingQuiz
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.favorite_rounded),
                      label: Text(context.tr('loveLanguagesQuizSaveAction')),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                for (var i = 0; i < loveLanguages.length; i++) ...[
                  _ToolItemCard(
                    item: loveLanguages[i],
                    languageCode: languageCode,
                    accentColor: Colors.pink,
                  ),
                  if (i != loveLanguages.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            key: weeklyChallengesKey,
            title: context.tr('weeklyChallengesTitle'),
            icon: Icons.flag_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('weeklyChallengesBody'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                _QuizIntroCard(
                  title: context.tr('weeklyChallengesChecklistTitle'),
                  body: context.tr('weeklyChallengesChecklistBody'),
                ),
                const SizedBox(height: 12),
                if (_isLoadingTools)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  )
                else ...[
                  _WeeklyChallengesProgressCard(
                    title: context.tr('weeklyChallengesProgressTitle'),
                    body: progressSummary,
                    completedCount: completedCount,
                    totalCount: weeklyChallenges.length,
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < weeklyChallenges.length; i++) ...[
                    _WeeklyChallengeChecklistCard(
                      challenge: weeklyChallenges[i],
                      languageCode: languageCode,
                      isCompleted: _completedChallengeIds.contains(
                        weeklyChallenges[i].id,
                      ),
                      onChanged: (value) =>
                          _toggleWeeklyChallenge(weeklyChallenges[i].id, value),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
                for (var i = 0; i < weeklyChallenges.length; i++) ...[
                  _ToolItemCard(
                    item: weeklyChallenges[i].content,
                    languageCode: languageCode,
                    accentColor: Colors.teal,
                  ),
                  if (i != weeklyChallenges.length - 1)
                    const SizedBox(height: 12),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            key: usageKey,
            title: context.tr('relationshipToolsUsageTitle'),
            icon: Icons.rule_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UsageBullet(text: context.tr('relationshipToolsUsagePoint1')),
                _UsageBullet(text: context.tr('relationshipToolsUsagePoint2')),
                _UsageBullet(text: context.tr('relationshipToolsUsagePoint3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyChallengesProgressCard extends StatelessWidget {
  const _WeeklyChallengesProgressCard({
    required this.title,
    required this.body,
    required this.completedCount,
    required this.totalCount,
  });

  final String title;
  final String body;
  final int completedCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = totalCount == 0 ? 0.0 : completedCount / totalCount;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, style: theme.textTheme.bodySmall),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              color: Colors.teal,
              backgroundColor: Colors.teal.withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyChallengeChecklistCard extends StatelessWidget {
  const _WeeklyChallengeChecklistCard({
    required this.challenge,
    required this.languageCode,
    required this.isCompleted,
    required this.onChanged,
  });

  final WeeklyChallengeItem challenge;
  final String languageCode;
  final bool isCompleted;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = challenge.content;
    final tag = item.tag(languageCode);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tag != null && tag.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          tag,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.teal,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Text(
                      item.title(languageCode),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.body(languageCode),
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Checkbox(
                key: ValueKey('weekly-challenge-${challenge.id}'),
                value: isCompleted,
                activeColor: Colors.teal,
                onChanged: (value) {
                  if (value == null) return;
                  onChanged(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuizIntroCard extends StatelessWidget {
  const _QuizIntroCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _SavedQuizResultCard extends StatelessWidget {
  const _SavedQuizResultCard({
    required this.title,
    required this.resultLabel,
    required this.item,
    required this.languageCode,
  });

  final String title;
  final String resultLabel;
  final ContentItem item;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            resultLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.title(languageCode),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(item.body(languageCode), style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _QuizQuestionCard extends StatelessWidget {
  const _QuizQuestionCard({
    required this.question,
    required this.languageCode,
    required this.selectedOptionId,
    required this.onChanged,
  });

  final LoveLanguageQuizQuestion question;
  final String languageCode;
  final String? selectedOptionId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.prompt(languageCode),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          RadioGroup<String>(
            groupValue: selectedOptionId,
            onChanged: (value) {
              if (value == null) return;
              onChanged(value);
            },
            child: Column(
              children: [
                for (final option in question.options)
                  RadioListTile<String>(
                    key: ValueKey('love-language-option-${option.id}'),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: option.id,
                    activeColor: Colors.pink,
                    title: Text(
                      option.label(languageCode),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _scrollToSection(BuildContext? sectionContext) {
  if (sectionContext == null) return;
  Scrollable.ensureVisible(
    sectionContext,
    duration: const Duration(milliseconds: 280),
    curve: Curves.easeOutCubic,
    alignment: 0.08,
  );
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.label,
    required this.value,
    required this.helper,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String value;
  final String helper;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const Spacer(),
                  Text(
                    value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      helper,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_downward_rounded, size: 15, color: color),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolItemCard extends StatelessWidget {
  const _ToolItemCard({
    required this.item,
    required this.languageCode,
    required this.accentColor,
  });

  final ContentItem item;
  final String languageCode;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tag = item.tag(languageCode);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tag != null && tag.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                tag,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Text(
            item.title(languageCode),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.body(languageCode),
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _UsageBullet extends StatelessWidget {
  const _UsageBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right_alt_rounded,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
