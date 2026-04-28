import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/question.dart';
import '../../providers/app_state.dart';

class PersonalityTestScreen extends StatelessWidget {
  const PersonalityTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final languageCode = appState.languageCode;

    return AppPage(
      title: context.tr('personalityTest'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '1 = low agreement, 5 = high agreement',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          for (final category in QuestionCategory.values) ...[
            SectionCard(
              title: _categoryTitle(category),
              icon: _categoryIcon(category),
              child: Column(
                children: [
                  for (final question in compatibilityQuestions.where(
                    (q) => q.category == category,
                  ))
                    _QuestionTile(
                      question: question,
                      languageCode: languageCode,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          FilledButton.icon(
            onPressed: () async {
              final success = await context
                  .read<AppState>()
                  .calculateCompatibility();
              if (!context.mounted) return;
              if (success) {
                Navigator.pushNamed(context, AppRoutes.results);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('completeProfiles'))),
                );
              }
            },
            icon: const Icon(Icons.analytics_outlined),
            label: Text(context.tr('calculate')),
          ),
        ],
      ),
    );
  }

  String _categoryTitle(QuestionCategory category) {
    return switch (category) {
      QuestionCategory.personality => 'Personality types',
      QuestionCategory.emotionalIntelligence => 'Emotional intelligence',
      QuestionCategory.angerManagement => 'Anger management',
      QuestionCategory.communication => 'Communication',
      QuestionCategory.financialMindset => 'Financial mindset',
      QuestionCategory.familyBoundaries => 'Family boundaries',
      QuestionCategory.futureGoals => 'Future goals',
      QuestionCategory.responsibility => 'Responsibility level',
    };
  }

  IconData _categoryIcon(QuestionCategory category) {
    return switch (category) {
      QuestionCategory.personality => Icons.diversity_1_outlined,
      QuestionCategory.emotionalIntelligence => Icons.psychology_alt_outlined,
      QuestionCategory.angerManagement => Icons.local_fire_department_outlined,
      QuestionCategory.communication => Icons.forum_outlined,
      QuestionCategory.financialMindset =>
        Icons.account_balance_wallet_outlined,
      QuestionCategory.familyBoundaries => Icons.family_restroom_outlined,
      QuestionCategory.futureGoals => Icons.flag_outlined,
      QuestionCategory.responsibility => Icons.verified_user_outlined,
    };
  }
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
          _ParticipantSlider(
            label: context.tr('userA'),
            value: aValue,
            onChanged: (value) => context.read<AppState>().updateAnswer(
              ParticipantSlot.userA,
              question.id,
              value,
            ),
          ),
          _ParticipantSlider(
            label: context.tr('userB'),
            value: bValue,
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

class _ParticipantSlider extends StatelessWidget {
  const _ParticipantSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 72, child: Text(label)),
        Expanded(
          child: Slider(
            min: 1,
            max: 5,
            divisions: 4,
            value: value.toDouble(),
            label: '$value',
            onChanged: (next) => onChanged(next.round()),
          ),
        ),
        SizedBox(width: 28, child: Text('$value', textAlign: TextAlign.end)),
      ],
    );
  }
}
