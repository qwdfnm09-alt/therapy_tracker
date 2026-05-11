import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/static_content_repository.dart';

class HeritageAwarenessScreen extends StatelessWidget {
  const HeritageAwarenessScreen({
    super.key,
    this.repository = const StaticContentRepository(),
  });

  final StaticContentRepository repository;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final sections = repository.heritageAwarenessSections();

    return AppPage(
      title: context.tr('heritageAwareness'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('heritageAwarenessIntroTitle'),
            icon: Icons.auto_stories_outlined,
            child: Text(context.tr('heritageAwarenessIntroBody')),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < sections.length; i++) ...[
            SectionCard(
              title: sections[i].title(languageCode),
              icon: Icons.history_edu_outlined,
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
                    _HeritageTile(
                      title: sections[i].items[j].title(languageCode),
                      body: sections[i].items[j].body(languageCode),
                      tag: sections[i].items[j].tag(languageCode),
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

class _HeritageTile extends StatelessWidget {
  const _HeritageTile({
    required this.title,
    required this.body,
    required this.tag,
  });

  final String title;
  final String body;
  final String? tag;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((tag ?? '').isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                tag!,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(body, style: theme.textTheme.bodyMedium?.copyWith(height: 1.45)),
        ],
      ),
    );
  }
}
