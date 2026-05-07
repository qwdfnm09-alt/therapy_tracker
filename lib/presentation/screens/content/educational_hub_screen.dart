import 'package:flutter/material.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/static_content_repository.dart';
import '../../../domain/models/content_item.dart';

class EducationalHubScreen extends StatelessWidget {
  const EducationalHubScreen({
    super.key,
    this.repository = const StaticContentRepository(),
  });

  final StaticContentRepository repository;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final guideItems = repository.premaritalGuide();

    return AppPage(
      title: context.tr('educationalHub'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('educationalHubIntroTitle'),
            icon: Icons.menu_book_outlined,
            child: Text(context.tr('educationalHubIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('educationalHubCollections'),
            icon: Icons.dashboard_customize_outlined,
            child: Column(
              children: [
                _HubNavTile(
                  title: context.tr('goldenQuestions'),
                  subtitle: context.tr('goldenQuestionsSubtitle'),
                  icon: Icons.forum_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.goldenQuestions),
                ),
                const SizedBox(height: 12),
                _HubNavTile(
                  title: context.tr('redFlags'),
                  subtitle: context.tr('redFlagsSubtitle'),
                  icon: Icons.warning_amber_rounded,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.redFlags),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('premaritalGuide'),
            icon: Icons.lightbulb_outline_rounded,
            child: Column(
              children: [
                for (var i = 0; i < guideItems.length; i++) ...[
                  _GuideItemCard(
                    item: guideItems[i],
                    languageCode: languageCode,
                  ),
                  if (i != guideItems.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HubNavTile extends StatelessWidget {
  const _HubNavTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primary.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 14),
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
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideItemCard extends StatelessWidget {
  const _GuideItemCard({required this.item, required this.languageCode});

  final ContentItem item;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tag = item.tag(languageCode);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tag != null && tag.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                tag,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
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
