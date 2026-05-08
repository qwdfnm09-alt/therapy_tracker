import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/static_content_repository.dart';

class GoldenQuestionsScreen extends StatelessWidget {
  const GoldenQuestionsScreen({
    super.key,
    this.repository = const StaticContentRepository(),
  });

  final StaticContentRepository repository;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final sections = repository.goldenQuestionSections();

    return AppPage(
      title: context.tr('goldenQuestions'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('goldenQuestionsIntroTitle'),
            icon: Icons.record_voice_over_outlined,
            child: Text(context.tr('goldenQuestionsIntroBody')),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < sections.length; i++) ...[
            SectionCard(
              title: sections[i].title(languageCode),
              icon: Icons.help_outline_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((sections[i].description(languageCode) ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        sections[i].description(languageCode)!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  for (var j = 0; j < sections[i].items.length; j++) ...[
                    _QuestionTile(
                      index: j + 1,
                      title: sections[i].items[j].title(languageCode),
                      body: sections[i].items[j].body(languageCode),
                    ),
                    if (j != sections[i].items.length - 1)
                      const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
            if (i != sections.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({
    required this.index,
    required this.title,
    required this.body,
  });

  final int index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(body, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
