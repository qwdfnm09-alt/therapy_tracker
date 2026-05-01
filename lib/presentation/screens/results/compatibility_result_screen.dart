import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/metric_ring.dart';
import '../../../core/widgets/score_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/compatibility_result.dart';
import '../../../domain/services/compatibility_pdf_export_service.dart';
import '../../providers/app_state.dart';

class CompatibilityResultScreen extends StatelessWidget {
  const CompatibilityResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<AppState>().result;
    final appState = context.watch<AppState>();

    return AppPage(
      title: context.tr('result'),
      actions: [
        IconButton(
          tooltip: context.tr('settings'),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      child: result == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.assignment_late_outlined, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      context.tr('resultEmptyBody'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        _assessmentRoute(appState),
                      ),
                      child: Text(context.tr('openAssessment')),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _AnimatedReveal(
                  delayFraction: 0,
                  child: _ResultHeroSection(
                    verdict: _verdictHeadline(
                      context,
                      result.compatibilityPercentage,
                    ),
                    summary: _verdictBody(
                      context,
                      result.compatibilityPercentage,
                      result.marriageReadinessScore,
                    ),
                    compatibility: result.compatibilityPercentage,
                    readiness: result.marriageReadinessScore,
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.12,
                  child: _TakeawaysSection(
                    title: context.tr('keyTakeaways'),
                    pulse: _firstMeaningfulItem(
                      context,
                      result.relationshipDynamics,
                      emptyToken: '',
                    ),
                    watchpoint: _firstMeaningfulItem(
                      context,
                      result.riskAreas,
                      emptyToken: 'risk:none',
                    ),
                    advantage: _firstMeaningfulItem(
                      context,
                      result.strengthAreas,
                      emptyToken: 'strength:none',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.22,
                  child: _VerdictSection(
                    title: context.tr('verdictTitle'),
                    headline: _verdictHeadline(
                      context,
                      result.compatibilityPercentage,
                    ),
                    body: _verdictBody(
                      context,
                      result.compatibilityPercentage,
                      result.marriageReadinessScore,
                    ),
                    discussionLead: _firstMeaningfulItem(
                      context,
                      result.riskAreas,
                      emptyToken: 'risk:none',
                    ),
                    strengthLead: _firstMeaningfulItem(
                      context,
                      result.strengthAreas,
                      emptyToken: 'strength:none',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.32,
                  child: _ComparisonSection(
                    title: context.tr('comparisonLens'),
                    userALabel: appState.userA?.name.isNotEmpty == true
                        ? appState.userA!.name
                        : context.tr('userA'),
                    userBLabel: appState.userB?.name.isNotEmpty == true
                        ? appState.userB!.name
                        : context.tr('userB'),
                    rows: [
                      _ComparisonRowData(
                        label: context.tr('mapEnergy'),
                        userAValue:
                            appState
                                .userA
                                ?.answers['personality_social_energy'] ??
                            3,
                        userBValue:
                            appState
                                .userB
                                ?.answers['personality_social_energy'] ??
                            3,
                        highKey: 'leanEnergyHigh',
                        lowKey: 'leanEnergyLow',
                      ),
                      _ComparisonRowData(
                        label: context.tr('mapStructure'),
                        userAValue:
                            appState.userA?.answers['personality_structure'] ??
                            3,
                        userBValue:
                            appState.userB?.answers['personality_structure'] ??
                            3,
                        highKey: 'leanStructureHigh',
                        lowKey: 'leanStructureLow',
                      ),
                      _ComparisonRowData(
                        label: context.tr('mapEmotion'),
                        userAValue:
                            appState.userA?.answers['emotion_self_awareness'] ??
                            3,
                        userBValue:
                            appState.userB?.answers['emotion_self_awareness'] ??
                            3,
                        highKey: 'leanEmotionHigh',
                        lowKey: 'leanEmotionLow',
                      ),
                      _ComparisonRowData(
                        label: context.tr('mapConflict'),
                        userAValue:
                            (((appState.userA?.answers['anger_pause'] ?? 3) +
                                        (appState
                                                .userA
                                                ?.answers['anger_repair'] ??
                                            3)) /
                                    2)
                                .round(),
                        userBValue:
                            (((appState.userB?.answers['anger_pause'] ?? 3) +
                                        (appState
                                                .userB
                                                ?.answers['anger_repair'] ??
                                            3)) /
                                    2)
                                .round(),
                        highKey: 'leanConflictHigh',
                        lowKey: 'leanConflictLow',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.42,
                  child: _ArchetypeSection(
                    title: context.tr('archetypeSummary'),
                    userALabel: appState.userA?.name.isNotEmpty == true
                        ? appState.userA!.name
                        : context.tr('userA'),
                    userBLabel: appState.userB?.name.isNotEmpty == true
                        ? appState.userB!.name
                        : context.tr('userB'),
                    userAValue: _localizeArchetype(
                      context,
                      result.partnerArchetypes['userA'] ?? '',
                    ),
                    userBValue: _localizeArchetype(
                      context,
                      result.partnerArchetypes['userB'] ?? '',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.52,
                  child: _PersonalityMapSection(
                    title: context.tr('personalityMap'),
                    userALabel: appState.userA?.name.isNotEmpty == true
                        ? appState.userA!.name
                        : context.tr('userA'),
                    userBLabel: appState.userB?.name.isNotEmpty == true
                        ? appState.userB!.name
                        : context.tr('userB'),
                    rows: [
                      _MapRowData(
                        label: context.tr('mapEnergy'),
                        userAValue:
                            appState
                                .userA
                                ?.answers['personality_social_energy'] ??
                            3,
                        userBValue:
                            appState
                                .userB
                                ?.answers['personality_social_energy'] ??
                            3,
                      ),
                      _MapRowData(
                        label: context.tr('mapStructure'),
                        userAValue:
                            appState.userA?.answers['personality_structure'] ??
                            3,
                        userBValue:
                            appState.userB?.answers['personality_structure'] ??
                            3,
                      ),
                      _MapRowData(
                        label: context.tr('mapEmotion'),
                        userAValue:
                            appState.userA?.answers['emotion_self_awareness'] ??
                            3,
                        userBValue:
                            appState.userB?.answers['emotion_self_awareness'] ??
                            3,
                      ),
                      _MapRowData(
                        label: context.tr('mapConflict'),
                        userAValue:
                            (((appState.userA?.answers['anger_pause'] ?? 3) +
                                        (appState
                                                .userA
                                                ?.answers['anger_repair'] ??
                                            3)) /
                                    2)
                                .round(),
                        userBValue:
                            (((appState.userB?.answers['anger_pause'] ?? 3) +
                                        (appState
                                                .userB
                                                ?.answers['anger_repair'] ??
                                            3)) /
                                    2)
                                .round(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.62,
                  child: SectionCard(
                    title: context.tr('narrativeSummary'),
                    icon: Icons.text_snippet_outlined,
                    child: Text(_buildNarrativeSummary(context, appState)),
                  ),
                ),
                const SizedBox(height: 16),
                _AnimatedReveal(
                  delayFraction: 0.7,
                  child: _ActionPlanSection(
                    nextStepTitle: context.tr('nextStepTitle'),
                    nextStepBody: _recommendedNextStep(context, result),
                    topicsTitle: context.tr('discussionTopicsTitle'),
                    topics: _discussionTopics(context, result),
                    onBook: () =>
                        Navigator.pushNamed(context, AppRoutes.counseling),
                    onReview: () async {
                      await context.read<AppState>().setPersonalityStageIndex(
                        0,
                      );
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, AppRoutes.personalityTest);
                    },
                    onSavePdf: () => _exportPdf(context, appState, result),
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: context.tr('categoryAnalysis'),
                  icon: Icons.bar_chart_rounded,
                  child: Column(
                    children: [
                      for (final entry in result.categoryScores.entries)
                        ScoreBar(
                          label: _categoryLabel(context, entry.key),
                          value: entry.value,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title:
                      '${appState.userA?.name.isNotEmpty == true ? appState.userA!.name : context.tr('userA')} ${context.tr('personalityProfile')}',
                  icon: Icons.person_outline,
                  items: (result.partnerProfiles['userA'] ?? const [])
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title:
                      '${appState.userB?.name.isNotEmpty == true ? appState.userB!.name : context.tr('userB')} ${context.tr('personalityProfile')}',
                  icon: Icons.person_outline,
                  items: (result.partnerProfiles['userB'] ?? const [])
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('relationshipDynamics'),
                  icon: Icons.hub_outlined,
                  items: result.relationshipDynamics
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('strengths'),
                  icon: Icons.trending_up_rounded,
                  items: result.strengthAreas
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('risks'),
                  icon: Icons.warning_amber_rounded,
                  items: result.riskAreas
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('notes'),
                  icon: Icons.psychology_alt_outlined,
                  items: result.psychologicalNotes
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('sessions'),
                  icon: Icons.event_available_outlined,
                  items: result.suggestedSessions
                      .map((item) => _localizeResultItem(context, item))
                      .toList(),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.counseling),
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Text(context.tr('bookRecommendedSession')),
                ),
              ],
            ),
    );
  }
}

Future<void> _exportPdf(
  BuildContext context,
  AppState appState,
  CompatibilityResult result,
) async {
  final service = CompatibilityPdfExportService();
  final data = _buildPdfReportData(context, appState, result);
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => _PdfOptionsScreen(service: service, data: data),
    ),
  );
}

class _PdfOptionsScreen extends StatefulWidget {
  const _PdfOptionsScreen({required this.service, required this.data});

  final CompatibilityPdfExportService service;
  final CompatibilityPdfReportData data;

  @override
  State<_PdfOptionsScreen> createState() => _PdfOptionsScreenState();
}

class _PdfOptionsScreenState extends State<_PdfOptionsScreen> {
  String? _statusMessage;

  @override
  Widget build(BuildContext context) {
    final fileName = widget.service.fileNameFor(widget.data);

    return AppPage(
      title: context.tr('pdfReadyTitle'),
      child: FutureBuilder<Uint8List>(
        future: widget.service.buildPdfBytes(widget.data),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 12),
                    Text(context.tr('pdfPreparing')),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(context.tr('pdfExportFailed')),
              ),
            );
          }

          final pdfBytes = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SectionCard(
                title: context.tr('pdfReadyTitle'),
                icon: Icons.picture_as_pdf_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fileName),
                    if ((_statusMessage ?? '').isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(_statusMessage!),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _runPdfAction(
                          () =>
                              widget.service.sharePdfBytes(pdfBytes, fileName),
                        ),
                        icon: const Icon(Icons.download_rounded),
                        label: Text(context.tr('pdfSaveAction')),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _runPdfAction(
                          () =>
                              widget.service.printPdfBytes(pdfBytes, fileName),
                        ),
                        icon: const Icon(Icons.print_outlined),
                        label: Text(context.tr('pdfPrintAction')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _runPdfAction(Future<bool> Function() action) async {
    try {
      final ok = await action();
      if (!mounted) return;
      setState(
        () => _statusMessage = context.tr(
          ok ? 'pdfExportReady' : 'pdfActionFailed',
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _statusMessage = context.tr('pdfExportFailed'));
    }
  }
}

CompatibilityPdfReportData _buildPdfReportData(
  BuildContext context,
  AppState appState,
  CompatibilityResult result,
) {
  final userAName = appState.userA?.name.isNotEmpty == true
      ? appState.userA!.name
      : context.tr('userA');
  final userBName = appState.userB?.name.isNotEmpty == true
      ? appState.userB!.name
      : context.tr('userB');

  return CompatibilityPdfReportData(
    isRtl: Directionality.of(context) == TextDirection.rtl,
    appName: context.tr('appName'),
    reportTitle: context.tr('result'),
    generatedAt:
        '${context.tr('generatedAt')}: ${_formatPdfDateTime(DateTime.now())}',
    participantALabel: context.tr('userA'),
    participantAName: userAName,
    participantBLabel: context.tr('userB'),
    participantBName: userBName,
    compatibilityLabel: context.tr('compatibility'),
    compatibilityScore: result.compatibilityPercentage,
    readinessLabel: context.tr('readiness'),
    readinessScore: result.marriageReadinessScore,
    verdictTitle: context.tr('verdictTitle'),
    verdictHeadline: _verdictHeadline(context, result.compatibilityPercentage),
    verdictBody: _verdictBody(
      context,
      result.compatibilityPercentage,
      result.marriageReadinessScore,
    ),
    nextStepTitle: context.tr('nextStepTitle'),
    nextStepBody: _recommendedNextStep(context, result),
    topicsTitle: context.tr('discussionTopicsTitle'),
    discussionTopics: _discussionTopics(context, result),
    categoryTitle: context.tr('categoryAnalysis'),
    categoryScores: {
      for (final entry in result.categoryScores.entries)
        _categoryLabel(context, entry.key): entry.value,
    },
    archetypeTitle: context.tr('archetypeSummary'),
    participantAArchetype: _localizeArchetype(
      context,
      result.partnerArchetypes['userA'] ?? '',
    ),
    participantBArchetype: _localizeArchetype(
      context,
      result.partnerArchetypes['userB'] ?? '',
    ),
    participantProfileTitle: context.tr('personalityProfile'),
    participantAProfile: (result.partnerProfiles['userA'] ?? const [])
        .map((item) => _localizeResultItem(context, item))
        .toList(),
    participantBProfile: (result.partnerProfiles['userB'] ?? const [])
        .map((item) => _localizeResultItem(context, item))
        .toList(),
    dynamicsTitle: context.tr('relationshipDynamics'),
    dynamics: result.relationshipDynamics
        .map((item) => _localizeResultItem(context, item))
        .toList(),
    strengthsTitle: context.tr('strengths'),
    strengths: result.strengthAreas
        .map((item) => _localizeResultItem(context, item))
        .toList(),
    risksTitle: context.tr('risks'),
    risks: result.riskAreas
        .map((item) => _localizeResultItem(context, item))
        .toList(),
    notesTitle: context.tr('notes'),
    notes: result.psychologicalNotes
        .map((item) => _localizeResultItem(context, item))
        .toList(),
    sessionsTitle: context.tr('sessions'),
    sessions: result.suggestedSessions
        .map((item) => _localizeResultItem(context, item))
        .toList(),
  );
}

String _formatPdfDateTime(DateTime value) {
  final year = value.year.toString().padLeft(4, '0');
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$year-$month-$day $hour:$minute';
}

class _AnimatedReveal extends StatelessWidget {
  const _AnimatedReveal({required this.child, required this.delayFraction});

  final Widget child;
  final double delayFraction;

  @override
  Widget build(BuildContext context) {
    final clampedDelay = delayFraction.clamp(0.0, 0.92);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Interval(clampedDelay, 1, curve: Curves.easeOutCubic),
      builder: (context, value, builtChild) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 22),
            child: builtChild,
          ),
        );
      },
      child: child,
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      icon: icon,
      child: Column(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TakeawaysSection extends StatelessWidget {
  const _TakeawaysSection({
    required this.title,
    required this.pulse,
    required this.watchpoint,
    required this.advantage,
  });

  final String title;
  final String pulse;
  final String watchpoint;
  final String advantage;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      icon: Icons.bolt_outlined,
      child: Column(
        children: [
          if (pulse.isNotEmpty)
            _TakeawayTile(
              label: context.tr('relationshipPulse'),
              icon: Icons.favorite_border_rounded,
              value: pulse,
            ),
          if (watchpoint.isNotEmpty) ...[
            if (pulse.isNotEmpty) const SizedBox(height: 10),
            _TakeawayTile(
              label: context.tr('watchpoint'),
              icon: Icons.error_outline_rounded,
              value: watchpoint,
            ),
          ],
          if (advantage.isNotEmpty) ...[
            if (pulse.isNotEmpty || watchpoint.isNotEmpty)
              const SizedBox(height: 10),
            _TakeawayTile(
              label: context.tr('advantage'),
              icon: Icons.trending_up_rounded,
              value: advantage,
            ),
          ],
        ],
      ),
    );
  }
}

class _TakeawayTile extends StatelessWidget {
  const _TakeawayTile({
    required this.label,
    required this.icon,
    required this.value,
  });

  final String label;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.55,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPlanSection extends StatelessWidget {
  const _ActionPlanSection({
    required this.nextStepTitle,
    required this.nextStepBody,
    required this.topicsTitle,
    required this.topics,
    required this.onBook,
    required this.onReview,
    required this.onSavePdf,
  });

  final String nextStepTitle;
  final String nextStepBody;
  final String topicsTitle;
  final List<String> topics;
  final VoidCallback onBook;
  final VoidCallback onReview;
  final VoidCallback onSavePdf;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: nextStepTitle,
      icon: Icons.route_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nextStepBody),
          const SizedBox(height: 14),
          Text(
            topicsTitle,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          for (final topic in topics)
            Padding(
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
                  Expanded(child: Text(topic)),
                ],
              ),
            ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final stackActions = constraints.maxWidth < 460;
              final bookButton = FilledButton.icon(
                onPressed: onBook,
                icon: const Icon(Icons.calendar_month_outlined),
                label: Text(context.tr('booking')),
              );
              final reviewButton = OutlinedButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.restart_alt_rounded),
                label: Text(context.tr('retakeLater')),
              );

              if (stackActions) {
                return Column(
                  children: [
                    SizedBox(width: double.infinity, child: bookButton),
                    const SizedBox(height: 10),
                    SizedBox(width: double.infinity, child: reviewButton),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: bookButton),
                  const SizedBox(width: 12),
                  Expanded(child: reviewButton),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onSavePdf,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: Text(context.tr('saveAsPdf')),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultHeroSection extends StatelessWidget {
  const _ResultHeroSection({
    required this.verdict,
    required this.summary,
    required this.compatibility,
    required this.readiness,
  });

  final String verdict;
  final String summary;
  final int compatibility;
  final int readiness;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primaryContainer.withBlue(210),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('heroSummaryLead'),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.82),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            verdict,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.92),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final stackMetrics = constraints.maxWidth < 440;
              final compatibilityRing = FittedBox(
                fit: BoxFit.scaleDown,
                child: MetricRing(
                  value: compatibility,
                  label: context.tr('compatibility'),
                  size: 132,
                ),
              );
              final readinessRing = FittedBox(
                fit: BoxFit.scaleDown,
                child: MetricRing(
                  value: readiness,
                  label: context.tr('readiness'),
                  size: 132,
                ),
              );

              if (stackMetrics) {
                return Column(
                  children: [
                    compatibilityRing,
                    const SizedBox(height: 12),
                    readinessRing,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: compatibilityRing),
                  const SizedBox(width: 10),
                  Expanded(child: readinessRing),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VerdictSection extends StatelessWidget {
  const _VerdictSection({
    required this.title,
    required this.headline,
    required this.body,
    required this.discussionLead,
    required this.strengthLead,
  });

  final String title;
  final String headline;
  final String body;
  final String discussionLead;
  final String strengthLead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionCard(
      title: title,
      icon: Icons.lightbulb_outline_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(body, style: theme.textTheme.bodyMedium),
          if (discussionLead.isNotEmpty) ...[
            const SizedBox(height: 14),
            _VerdictPill(
              label: context.tr('whatToDiscussNow'),
              value: discussionLead,
              icon: Icons.chat_outlined,
            ),
          ],
          if (strengthLead.isNotEmpty) ...[
            const SizedBox(height: 10),
            _VerdictPill(
              label: context.tr('topStrengthNow'),
              value: strengthLead,
              icon: Icons.trending_up_rounded,
            ),
          ],
        ],
      ),
    );
  }
}

class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection({
    required this.title,
    required this.userALabel,
    required this.userBLabel,
    required this.rows,
  });

  final String title;
  final String userALabel;
  final String userBLabel;
  final List<_ComparisonRowData> rows;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      icon: Icons.compare_arrows_rounded,
      child: Column(
        children: [
          for (final row in rows) ...[
            _ComparisonCard(
              row: row,
              userALabel: userALabel,
              userBLabel: userBLabel,
            ),
            if (row != rows.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ComparisonRowData {
  const _ComparisonRowData({
    required this.label,
    required this.userAValue,
    required this.userBValue,
    required this.highKey,
    required this.lowKey,
  });

  final String label;
  final int userAValue;
  final int userBValue;
  final String highKey;
  final String lowKey;
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.row,
    required this.userALabel,
    required this.userBLabel,
  });

  final _ComparisonRowData row;
  final String userALabel;
  final String userBLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final delta = row.userAValue - row.userBValue;
    final gap = delta.abs();
    final same = gap == 0;

    String lead;
    if (same) {
      lead = context.tr('comparisonClose');
    } else {
      final leader = delta > 0 ? userALabel : userBLabel;
      final leanKey = (delta > 0 ? row.userAValue : row.userBValue) >= 3
          ? row.highKey
          : row.lowKey;
      lead = '$leader ${context.tr(leanKey)}';
    }

    final support = same
        ? ''
        : gap >= 2
        ? context.tr('comparisonGapStrong')
        : context.tr('comparisonGapLight');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.48,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            row.label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MiniScoreChip(label: userALabel, value: row.userAValue),
              _MiniScoreChip(label: userBLabel, value: row.userBValue),
            ],
          ),
          const SizedBox(height: 10),
          Text(lead, style: theme.textTheme.bodyMedium),
          if (support.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              support,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniScoreChip extends StatelessWidget {
  const _MiniScoreChip({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value.toDouble()),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, _) {
              return Text(
                '${animatedValue.round()}/5',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VerdictPill extends StatelessWidget {
  const _VerdictPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.55,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchetypeSection extends StatelessWidget {
  const _ArchetypeSection({
    required this.title,
    required this.userALabel,
    required this.userBLabel,
    required this.userAValue,
    required this.userBValue,
  });

  final String title;
  final String userALabel;
  final String userBLabel;
  final String userAValue;
  final String userBValue;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      icon: Icons.auto_awesome_outlined,
      child: Column(
        children: [
          _ArchetypeRow(label: userALabel, value: userAValue),
          const SizedBox(height: 12),
          _ArchetypeRow(label: userBLabel, value: userBValue),
        ],
      ),
    );
  }
}

class _ArchetypeRow extends StatelessWidget {
  const _ArchetypeRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 430;
        final labelText = Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        );
        final valueText = Text(value);

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [labelText, const SizedBox(height: 6), valueText],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: labelText),
            const SizedBox(width: 12),
            Expanded(flex: 3, child: valueText),
          ],
        );
      },
    );
  }
}

class _PersonalityMapSection extends StatelessWidget {
  const _PersonalityMapSection({
    required this.title,
    required this.userALabel,
    required this.userBLabel,
    required this.rows,
  });

  final String title;
  final String userALabel;
  final String userBLabel;
  final List<_MapRowData> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionCard(
      title: title,
      icon: Icons.insights_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _LegendChip(label: userALabel, color: theme.colorScheme.primary),
              _LegendChip(label: userBLabel, color: theme.colorScheme.tertiary),
            ],
          ),
          const SizedBox(height: 16),
          for (final row in rows) ...[
            _MapRow(row: row),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}

class _MapRowData {
  const _MapRowData({
    required this.label,
    required this.userAValue,
    required this.userBValue,
  });

  final String label;
  final int userAValue;
  final int userBValue;
}

class _MapRow extends StatelessWidget {
  const _MapRow({required this.row});

  final _MapRowData row;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trackColor = theme.colorScheme.surfaceContainerHighest;
    final userAColor = theme.colorScheme.primary;
    final userBColor = theme.colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          row.label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final aLeft = ((row.userAValue - 1) / 4) * maxWidth;
            final bLeft = ((row.userBValue - 1) / 4) * maxWidth;
            return SizedBox(
              height: 28,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 6,
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: trackColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  Positioned(
                    left: aLeft.clamp(0, maxWidth - 16),
                    child: _MapDot(
                      label: '${row.userAValue}',
                      color: userAColor,
                    ),
                  ),
                  Positioned(
                    left: bLeft.clamp(0, maxWidth - 16),
                    child: _MapDot(
                      label: '${row.userBValue}',
                      color: userBColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MapDot extends StatelessWidget {
  const _MapDot({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

String _assessmentRoute(AppState appState) {
  if (!(appState.userA?.hasRequiredInfo ?? false)) return AppRoutes.userAForm;
  if (!(appState.userB?.hasRequiredInfo ?? false)) return AppRoutes.userBForm;
  return AppRoutes.personalityTest;
}

String _verdictHeadline(BuildContext context, int compatibility) {
  return switch (compatibility) {
    >= 80 => context.tr('verdictStrong'),
    >= 65 => context.tr('verdictWorkable'),
    _ => context.tr('verdictFragile'),
  };
}

String _verdictBody(BuildContext context, int compatibility, int readiness) {
  if (compatibility >= 80 && readiness >= 75) {
    return context.tr('verdictStrongBody');
  }
  if (compatibility >= 65 && readiness >= 65) {
    return context.tr('verdictWorkableBody');
  }
  return context.tr('verdictFragileBody');
}

String _firstMeaningfulItem(
  BuildContext context,
  List<String> items, {
  required String emptyToken,
}) {
  for (final item in items) {
    if (item == emptyToken) {
      continue;
    }
    final localized = _localizeResultItem(context, item);
    if (localized.isNotEmpty) {
      return localized;
    }
  }
  return '';
}

String _buildNarrativeSummary(BuildContext context, AppState appState) {
  final result = appState.result;
  if (result == null) return '';

  final compatibilityLead = switch (result.compatibilityPercentage) {
    >= 80 => context.tr('narrativeCompatibilityHigh'),
    >= 65 => context.tr('narrativeCompatibilityMid'),
    _ => context.tr('narrativeCompatibilityLow'),
  };

  final readinessLead = switch (result.marriageReadinessScore) {
    >= 75 => context.tr('narrativeReadinessHigh'),
    >= 65 => context.tr('narrativeReadinessMid'),
    _ => context.tr('narrativeReadinessLow'),
  };

  final userAName = appState.userA?.name.isNotEmpty == true
      ? appState.userA!.name
      : context.tr('userA');
  final userBName = appState.userB?.name.isNotEmpty == true
      ? appState.userB!.name
      : context.tr('userB');

  final archetypeSentence =
      '${context.tr("narrativeArchetypeLead")} $userAName ${_localizeArchetype(context, result.partnerArchetypes["userA"] ?? "")}، '
      '$userBName ${_localizeArchetype(context, result.partnerArchetypes["userB"] ?? "")}.';

  final dynamics = result.relationshipDynamics
      .map((item) => _localizeResultItem(context, item))
      .where((item) => item.isNotEmpty)
      .toList();
  final dynamicSentence = dynamics.isEmpty
      ? ''
      : '${context.tr("narrativeDynamicLead")} ${dynamics.take(2).join(', ')}.';

  final firstRisk = result.riskAreas
      .map((item) => _localizeResultItem(context, item))
      .firstWhere(
        (item) => item.isNotEmpty && item != context.tr('noHighRisk'),
        orElse: () => '',
      );
  final firstStrength = result.strengthAreas
      .map((item) => _localizeResultItem(context, item))
      .firstWhere(
        (item) => item.isNotEmpty && item != context.tr('noStrongAlignmentYet'),
        orElse: () => '',
      );

  final emphasisSentence = firstRisk.isNotEmpty
      ? '${context.tr("narrativeRiskLead")} $firstRisk.'
      : firstStrength.isNotEmpty
      ? '${context.tr("narrativeStrengthLead")} $firstStrength.'
      : '';

  return [
    compatibilityLead,
    readinessLead,
    archetypeSentence,
    dynamicSentence,
    emphasisSentence,
    context.tr('narrativeSupportLead'),
  ].where((line) => line.isNotEmpty).join(' ');
}

String _recommendedNextStep(BuildContext context, CompatibilityResult result) {
  if (result.marriageReadinessScore < 60 ||
      result.compatibilityPercentage < 60) {
    return context.tr('nextStepCounselorFirst');
  }
  if (!result.riskAreas.contains('risk:none')) {
    return context.tr('nextStepGuidedDiscussion');
  }
  return context.tr('nextStepAlignment');
}

List<String> _discussionTopics(
  BuildContext context,
  CompatibilityResult result,
) {
  final topics = <String>[];
  for (final risk in result.riskAreas) {
    final topic = switch (risk) {
      'risk:angerManagement' => context.tr('topicConflictRepair'),
      'risk:familyBoundaries' => context.tr('topicFamilyBoundaries'),
      'risk:financialMindset' => context.tr('topicMoneyPlanning'),
      'risk:futureGoals' => context.tr('topicFutureTiming'),
      'risk:communication' => context.tr('topicCommunicationRhythm'),
      'risk:responsibility' => context.tr('topicHouseholdResponsibility'),
      _ => '',
    };
    if (topic.isNotEmpty && !topics.contains(topic)) {
      topics.add(topic);
    }
  }

  if (topics.isEmpty) {
    topics.add(context.tr('topicCommunicationRhythm'));
    topics.add(context.tr('topicFutureTiming'));
  }

  return topics.take(3).toList();
}

String _categoryLabel(BuildContext context, String key) {
  return switch (key) {
    'personality' || 'Personality' => context.tr('categoryPersonality'),
    'emotionalIntelligence' ||
    'Emotional intelligence' => context.tr('categoryEmotionalIntelligence'),
    'angerManagement' ||
    'Anger management' => context.tr('categoryAngerManagement'),
    'communication' || 'Communication' => context.tr('categoryCommunication'),
    'financialMindset' ||
    'Financial mindset' => context.tr('categoryFinancialMindset'),
    'familyBoundaries' ||
    'Family boundaries' => context.tr('categoryFamilyBoundaries'),
    'futureGoals' || 'Future goals' => context.tr('categoryFutureGoals'),
    'responsibility' ||
    'Responsibility' => context.tr('categoryResponsibility'),
    _ => key,
  };
}

String _localizeResultItem(BuildContext context, String item) {
  if (item == 'strength:none') {
    return context.tr('noStrongAlignmentYet');
  }
  if (item == 'risk:none') {
    return context.tr('noHighRisk');
  }
  if (item.startsWith('strength:')) {
    final parts = item.split(':');
    if (parts.length == 3) {
      final category = _categoryLabel(context, parts[1]);
      final value = parts[2];
      return '$category: $value% ${context.tr("alignmentLabel")}';
    }
  }
  if (item.startsWith('risk:')) {
    final parts = item.split(':');
    if (parts.length == 2) {
      final category = _categoryLabel(context, parts[1]);
      return '$category: ${context.tr("needsStructuredDiscussion")}';
    }
  }

  return switch (item) {
    'profile:energy:outgoing' => context.tr('profileEnergyOutgoing'),
    'profile:energy:reserved' => context.tr('profileEnergyReserved'),
    'profile:energy:balanced' => context.tr('profileEnergyBalanced'),
    'profile:structure:structured' => context.tr('profileStructureStructured'),
    'profile:structure:flexible' => context.tr('profileStructureFlexible'),
    'profile:structure:balanced' => context.tr('profileStructureBalanced'),
    'profile:emotion:aware' => context.tr('profileEmotionAware'),
    'profile:emotion:guarded' => context.tr('profileEmotionGuarded'),
    'profile:emotion:growing' => context.tr('profileEmotionGrowing'),
    'profile:conflict:steady' => context.tr('profileConflictSteady'),
    'profile:conflict:reactive' => context.tr('profileConflictReactive'),
    'profile:conflict:developing' => context.tr('profileConflictDeveloping'),
    'dynamic:energy:aligned' => context.tr('dynamicEnergyAligned'),
    'dynamic:energy:bridge' => context.tr('dynamicEnergyBridge'),
    'dynamic:planning:aligned' => context.tr('dynamicPlanningAligned'),
    'dynamic:planning:bridge' => context.tr('dynamicPlanningBridge'),
    'dynamic:repair:strong' => context.tr('dynamicRepairStrong'),
    'dynamic:repair:fragile' => context.tr('dynamicRepairFragile'),
    'dynamic:repair:developing' => context.tr('dynamicRepairDeveloping'),
    'note:strongAlignment' => context.tr('noteStrongAlignment'),
    'note:workableCompatibility' => context.tr('noteWorkableCompatibility'),
    'note:fragileCompatibility' => context.tr('noteFragileCompatibility'),
    'note:angerManagement' => context.tr('noteAngerManagement'),
    'note:familyBoundaries' => context.tr('noteFamilyBoundaries'),
    'note:readinessThreshold' => context.tr('noteReadinessThreshold'),
    'session:communication' => context.tr('sessionCommunication'),
    'session:familyBoundaries' => context.tr('sessionFamilyBoundaries'),
    'session:futurePlanning' => context.tr('sessionFuturePlanning'),
    'session:individualReadiness' => context.tr('sessionIndividualReadiness'),
    'session:alignment' => context.tr('sessionAlignment'),
    'No high-risk area detected by the current scoring profile.' => context.tr(
      'noHighRisk',
    ),
    'The couple shows strong alignment, but expectations should still be discussed explicitly.' =>
      context.tr('noteStrongAlignment'),
    'The relationship has workable compatibility with several topics needing guided conversation.' =>
      context.tr('noteWorkableCompatibility'),
    'Compatibility is currently fragile. A counselor should review the main gaps before commitment.' =>
      context.tr('noteFragileCompatibility'),
    'Conflict repair and anger regulation need attention before marriage pressure increases.' =>
      context.tr('noteAngerManagement'),
    'Family boundary expectations may cause repeated stress if they remain vague.' =>
      context.tr('noteFamilyBoundaries'),
    'Marriage readiness is below the recommended threshold for a confident decision.' =>
      context.tr('noteReadinessThreshold'),
    'Communication and conflict dialogue session' => context.tr(
      'sessionCommunication',
    ),
    'Family boundaries consultation' => context.tr('sessionFamilyBoundaries'),
    'Future planning and financial expectations session' => context.tr(
      'sessionFuturePlanning',
    ),
    'Individual psychological readiness review' => context.tr(
      'sessionIndividualReadiness',
    ),
    'One pre-marriage coaching session for final alignment' => context.tr(
      'sessionAlignment',
    ),
    _ => item,
  };
}

String _localizeArchetype(BuildContext context, String item) {
  if (item.isEmpty) return '-';
  final parts = item.split('+');
  if (parts.length != 2) return item;
  return '${_archetypePart(context, parts[0])} + ${_archetypePart(context, parts[1])}';
}

String _archetypePart(BuildContext context, String part) {
  return switch (part) {
    'planner' => context.tr('archetypePlanner'),
    'flexible' => context.tr('archetypeFlexible'),
    'balanced' => context.tr('archetypeBalanced'),
    'warmCommunicator' => context.tr('archetypeWarmCommunicator'),
    'reflectivePartner' => context.tr('archetypeReflectivePartner'),
    'steadyResponder' => context.tr('archetypeSteadyResponder'),
    'directProcessor' => context.tr('archetypeDirectProcessor'),
    _ => part,
  };
}
