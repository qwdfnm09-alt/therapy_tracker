import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/scenario_lab_progress_service.dart';
import '../../../data/local/scenario_lab_repository.dart';
import '../../../domain/models/scenario_lab_item.dart';
import '../../../domain/models/scenario_lab_summary.dart';
import '../../../domain/services/scenario_lab_scoring_service.dart';

class ScenarioLabScreen extends StatefulWidget {
  const ScenarioLabScreen({
    super.key,
    this.repository = const ScenarioLabRepository(),
    this.scoringService = const ScenarioLabScoringService(),
    this.progressService = const ScenarioLabProgressService(),
  });

  final ScenarioLabRepository repository;
  final ScenarioLabScoringService scoringService;
  final ScenarioLabProgressService progressService;

  @override
  State<ScenarioLabScreen> createState() => _ScenarioLabScreenState();
}

class _ScenarioLabScreenState extends State<ScenarioLabScreen> {
  Map<String, String> _userAAnswers = const {};
  Map<String, String> _userBAnswers = const {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final progress = await widget.progressService.readProgress();
    if (!mounted) return;
    setState(() {
      _userAAnswers = progress.userAAnswers;
      _userBAnswers = progress.userBAnswers;
      _isLoading = false;
    });
  }

  Future<void> _saveProgress() async {
    await widget.progressService.saveProgress(
      ScenarioLabProgress(
        userAAnswers: _userAAnswers,
        userBAnswers: _userBAnswers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final scenarios = widget.repository.scenarios();
    final summary = widget.scoringService.buildSummary(
      scenarios: scenarios,
      userAAnswers: _userAAnswers,
      userBAnswers: _userBAnswers,
    );

    return AppPage(
      title: context.tr('scenarioLab'),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SectionCard(
                  title: context.tr('scenarioLabIntroTitle'),
                  icon: Icons.radar_outlined,
                  child: Text(context.tr('scenarioLabIntroBody')),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: context.tr('scenarioLabSummaryTitle'),
                  icon: Icons.track_changes_rounded,
                  child: _ScenarioLabSummaryCard(summary: summary),
                ),
                if (summary.recommendations.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  SectionCard(
                    title: context.tr('scenarioLabRecommendationsTitle'),
                    icon: Icons.forum_outlined,
                    child: _ScenarioLabRecommendationsCard(summary: summary),
                  ),
                ],
                const SizedBox(height: 16),
                for (var i = 0; i < scenarios.length; i++) ...[
                  SectionCard(
                    title: scenarios[i].title(languageCode),
                    icon: Icons.alt_route_rounded,
                    child: _ScenarioCard(
                      scenario: scenarios[i],
                      languageCode: languageCode,
                      userAAnswer: _userAAnswers[scenarios[i].id],
                      userBAnswer: _userBAnswers[scenarios[i].id],
                      onUserAChanged: (value) async {
                        setState(() {
                          _userAAnswers = {
                            ..._userAAnswers,
                            scenarios[i].id: value,
                          };
                        });
                        await _saveProgress();
                      },
                      onUserBChanged: (value) async {
                        setState(() {
                          _userBAnswers = {
                            ..._userBAnswers,
                            scenarios[i].id: value,
                          };
                        });
                        await _saveProgress();
                      },
                    ),
                  ),
                  if (i != scenarios.length - 1) const SizedBox(height: 16),
                ],
              ],
            ),
    );
  }
}

class _ScenarioLabRecommendationsCard extends StatelessWidget {
  const _ScenarioLabRecommendationsCard({required this.summary});

  final ScenarioLabSummary summary;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr('scenarioLabRecommendationsBody')),
        const SizedBox(height: 14),
        for (var i = 0; i < summary.recommendations.length; i++) ...[
          _ScenarioRecommendationTile(
            recommendation: summary.recommendations[i],
            languageCode: languageCode,
          ),
          if (i != summary.recommendations.length - 1)
            const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _ScenarioRecommendationTile extends StatelessWidget {
  const _ScenarioRecommendationTile({
    required this.recommendation,
    required this.languageCode,
  });

  final ScenarioLabRecommendation recommendation;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final isGap = recommendation.type == ScenarioLabRecommendationType.gap;
    final tone = isGap ? Colors.pink : Colors.orange;
    final badgeLabel = context.tr(
      isGap
          ? 'scenarioLabRecommendationGapLabel'
          : 'scenarioLabRecommendationCloseLabel',
    );
    final hint = context.tr(
      isGap
          ? 'scenarioLabRecommendationGapHint'
          : 'scenarioLabRecommendationCloseHint',
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tone.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  badgeLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: tone,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                recommendation.scenario.title(languageCode),
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${context.tr('scenarioLabFocusLabel')}: ${recommendation.scenario.focus(languageCode)}',
          ),
          const SizedBox(height: 10),
          Text(hint),
          const SizedBox(height: 10),
          Text(
            '${context.tr('scenarioLabUserALabel')}: ${recommendation.userAOption.label(languageCode)}',
          ),
          const SizedBox(height: 6),
          Text(
            '${context.tr('scenarioLabUserBLabel')}: ${recommendation.userBOption.label(languageCode)}',
          ),
        ],
      ),
    );
  }
}

class _ScenarioLabSummaryCard extends StatelessWidget {
  const _ScenarioLabSummaryCard({required this.summary});

  final ScenarioLabSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('scenarioLabSummaryBody'),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final useSingleColumn = constraints.maxWidth < 430;
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: useSingleColumn ? 1 : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: useSingleColumn ? 88 : 108,
              ),
              children: [
                _ScenarioMetricCard(
                  label: context.tr('scenarioLabAnsweredLabel'),
                  value: summary.answeredScenarios.toString(),
                  color: Colors.indigo,
                ),
                _ScenarioMetricCard(
                  label: context.tr('scenarioLabAlignedLabel'),
                  value: summary.alignedCount.toString(),
                  color: Colors.teal,
                ),
                _ScenarioMetricCard(
                  label: context.tr('scenarioLabCloseLabel'),
                  value: summary.closeCount.toString(),
                  color: Colors.orange,
                ),
                _ScenarioMetricCard(
                  label: context.tr('scenarioLabGapLabel'),
                  value: summary.gapCount.toString(),
                  color: Colors.pink,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ScenarioMetricCard extends StatelessWidget {
  const _ScenarioMetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.scenario,
    required this.languageCode,
    required this.userAAnswer,
    required this.userBAnswer,
    required this.onUserAChanged,
    required this.onUserBChanged,
  });

  final ScenarioLabItem scenario;
  final String languageCode;
  final String? userAAnswer;
  final String? userBAnswer;
  final ValueChanged<String> onUserAChanged;
  final ValueChanged<String> onUserBChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scenario.body(languageCode),
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '${context.tr('scenarioLabFocusLabel')}: ${scenario.focus(languageCode)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.indigo,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          context.tr('scenarioLabUserALabel'),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        _ScenarioOptionsGroup(
          scenario: scenario,
          languageCode: languageCode,
          selectedOptionId: userAAnswer,
          onChanged: onUserAChanged,
        ),
        const SizedBox(height: 12),
        Text(
          context.tr('scenarioLabUserBLabel'),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        _ScenarioOptionsGroup(
          scenario: scenario,
          languageCode: languageCode,
          selectedOptionId: userBAnswer,
          onChanged: onUserBChanged,
        ),
      ],
    );
  }
}

class _ScenarioOptionsGroup extends StatelessWidget {
  const _ScenarioOptionsGroup({
    required this.scenario,
    required this.languageCode,
    required this.selectedOptionId,
    required this.onChanged,
  });

  final ScenarioLabItem scenario;
  final String languageCode;
  final String? selectedOptionId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: selectedOptionId,
      onChanged: (value) {
        if (value == null) return;
        onChanged(value);
      },
      child: Column(
        children: [
          for (final option in scenario.options)
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: option.id,
              title: Text(option.label(languageCode)),
            ),
        ],
      ),
    );
  }
}
