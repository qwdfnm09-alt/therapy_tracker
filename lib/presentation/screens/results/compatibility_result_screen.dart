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
                      onPressed: () =>
                          Navigator.pushNamed(context, _assessmentRoute(appState)),
                      child: Text(context.tr('openAssessment')),
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
                _ArchetypeSection(
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
                const SizedBox(height: 16),
                _PersonalityMapSection(
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
                          appState.userA?.answers['personality_social_energy'] ??
                          3,
                      userBValue:
                          appState.userB?.answers['personality_social_energy'] ??
                          3,
                    ),
                    _MapRowData(
                      label: context.tr('mapStructure'),
                      userAValue:
                          appState.userA?.answers['personality_structure'] ?? 3,
                      userBValue:
                          appState.userB?.answers['personality_structure'] ?? 3,
                    ),
                    _MapRowData(
                      label: context.tr('mapEmotion'),
                      userAValue:
                          appState.userA?.answers['emotion_self_awareness'] ?? 3,
                      userBValue:
                          appState.userB?.answers['emotion_self_awareness'] ?? 3,
                    ),
                    _MapRowData(
                      label: context.tr('mapConflict'),
                      userAValue:
                          (((appState.userA?.answers['anger_pause'] ?? 3) +
                                      (appState.userA?.answers['anger_repair'] ??
                                          3)) /
                                  2)
                              .round(),
                      userBValue:
                          (((appState.userB?.answers['anger_pause'] ?? 3) +
                                      (appState.userB?.answers['anger_repair'] ??
                                          3)) /
                                  2)
                              .round(),
                    ),
                  ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(flex: 3, child: Text(value)),
      ],
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
              _LegendChip(
                label: userALabel,
                color: theme.colorScheme.primary,
              ),
              _LegendChip(
                label: userBLabel,
                color: theme.colorScheme.tertiary,
              ),
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

String _categoryLabel(BuildContext context, String key) {
  return switch (key) {
    'personality' || 'Personality' => context.tr('categoryPersonality'),
    'emotionalIntelligence' || 'Emotional intelligence' =>
      context.tr('categoryEmotionalIntelligence'),
    'angerManagement' || 'Anger management' =>
      context.tr('categoryAngerManagement'),
    'communication' || 'Communication' =>
      context.tr('categoryCommunication'),
    'financialMindset' || 'Financial mindset' =>
      context.tr('categoryFinancialMindset'),
    'familyBoundaries' || 'Family boundaries' =>
      context.tr('categoryFamilyBoundaries'),
    'futureGoals' || 'Future goals' => context.tr('categoryFutureGoals'),
    'responsibility' || 'Responsibility' =>
      context.tr('categoryResponsibility'),
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
    'note:strongAlignment' =>
      context.tr('noteStrongAlignment'),
    'note:workableCompatibility' =>
      context.tr('noteWorkableCompatibility'),
    'note:fragileCompatibility' =>
      context.tr('noteFragileCompatibility'),
    'note:angerManagement' =>
      context.tr('noteAngerManagement'),
    'note:familyBoundaries' =>
      context.tr('noteFamilyBoundaries'),
    'note:readinessThreshold' =>
      context.tr('noteReadinessThreshold'),
    'session:communication' =>
      context.tr('sessionCommunication'),
    'session:familyBoundaries' =>
      context.tr('sessionFamilyBoundaries'),
    'session:futurePlanning' =>
      context.tr('sessionFuturePlanning'),
    'session:individualReadiness' =>
      context.tr('sessionIndividualReadiness'),
    'session:alignment' =>
      context.tr('sessionAlignment'),
    'No high-risk area detected by the current scoring profile.' =>
      context.tr('noHighRisk'),
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
    'Communication and conflict dialogue session' =>
      context.tr('sessionCommunication'),
    'Family boundaries consultation' =>
      context.tr('sessionFamilyBoundaries'),
    'Future planning and financial expectations session' =>
      context.tr('sessionFuturePlanning'),
    'Individual psychological readiness review' =>
      context.tr('sessionIndividualReadiness'),
    'One pre-marriage coaching session for final alignment' =>
      context.tr('sessionAlignment'),
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
