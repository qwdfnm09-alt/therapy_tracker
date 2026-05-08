import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/relationship_tools_repository.dart';
import '../../../domain/models/content_item.dart';

class RelationshipToolsScreen extends StatelessWidget {
  const RelationshipToolsScreen({
    super.key,
    this.repository = const RelationshipToolsRepository(),
  });

  final RelationshipToolsRepository repository;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final loveLanguages = repository.loveLanguages();
    final weeklyChallenges = repository.weeklyChallenges();

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
                for (var i = 0; i < weeklyChallenges.length; i++) ...[
                  _ToolItemCard(
                    item: weeklyChallenges[i],
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
