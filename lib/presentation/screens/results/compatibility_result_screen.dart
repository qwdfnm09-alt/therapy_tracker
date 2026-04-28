import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/metric_ring.dart';
import '../../../core/widgets/score_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class CompatibilityResultScreen extends StatelessWidget {
  const CompatibilityResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<AppState>().result;

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
                      context.tr('completeProfiles'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.userAForm),
                      child: Text(context.tr('startAssessment')),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SectionCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MetricRing(
                        value: result.compatibilityPercentage,
                        label: context.tr('compatibility'),
                      ),
                      const SizedBox(width: 12),
                      MetricRing(
                        value: result.marriageReadinessScore,
                        label: context.tr('readiness'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Category analysis',
                  icon: Icons.bar_chart_rounded,
                  child: Column(
                    children: [
                      for (final entry in result.categoryScores.entries)
                        ScoreBar(label: entry.key, value: entry.value),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('strengths'),
                  icon: Icons.trending_up_rounded,
                  items: result.strengthAreas,
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('risks'),
                  icon: Icons.warning_amber_rounded,
                  items: result.riskAreas,
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('notes'),
                  icon: Icons.psychology_alt_outlined,
                  items: result.psychologicalNotes,
                ),
                const SizedBox(height: 16),
                _ListSection(
                  title: context.tr('sessions'),
                  icon: Icons.event_available_outlined,
                  items: result.suggestedSessions,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.counseling),
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Text(context.tr('booking')),
                ),
              ],
            ),
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
