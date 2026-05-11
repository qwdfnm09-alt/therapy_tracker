import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/backend_mode.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/connected_features_service.dart';
import '../../../domain/models/connected_feature_item.dart';
import '../../providers/app_state.dart';

class ConnectedFeaturesScreen extends StatelessWidget {
  const ConnectedFeaturesScreen({
    super.key,
    this.service = const ConnectedFeaturesService(),
  });

  final ConnectedFeaturesService service;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AppState>().languageCode == 'ar';
    final languageCode = isArabic ? 'ar' : 'en';
    final items = service.items();
    final overview = service.buildOverview(items);

    return AppPage(
      title: context.tr('connectedFeatures'),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: items.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return SectionCard(
              title: context.tr('connectedFeaturesIntroTitle'),
              icon: Icons.cloud_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('connectedFeaturesIntroBody')),
                  const SizedBox(height: 10),
                  Text(
                    context.tr('connectedFeaturesLocalOnlyNote'),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _StatusPill(
                        label:
                            '${context.tr('connectedFeaturesModeLabel')}: ${_modeLabel(context, overview.mode)}',
                        color: Colors.indigo,
                      ),
                      _StatusPill(
                        label:
                            '${context.tr('connectedFeaturesEnabledCountLabel')}: ${overview.enabledCount}',
                        color: Colors.teal,
                      ),
                      _StatusPill(
                        label:
                            '${context.tr('connectedFeaturesGatedCountLabel')}: ${overview.gatedCount}',
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          final item = items[index - 1];
          final status = service.runtimeStatusFor(item);
          return SectionCard(
            title: item.title(languageCode),
            icon: Icons.hub_outlined,
            child: _ConnectedFeatureCard(item: item, status: status),
          );
        },
      ),
    );
  }

  String _modeLabel(BuildContext context, BackendMode mode) {
    return switch (mode) {
      BackendMode.localOnly => context.tr('backendModeLocalOnly'),
      BackendMode.connectedPreview => context.tr('backendModeConnectedPreview'),
      BackendMode.connectedLive => context.tr('backendModeConnectedLive'),
    };
  }
}

class _ConnectedFeatureCard extends StatelessWidget {
  const _ConnectedFeatureCard({required this.item, required this.status});

  final ConnectedFeatureItem item;
  final ConnectedFeatureRuntimeStatus status;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AppState>().languageCode == 'ar';
    final languageCode = isArabic ? 'ar' : 'en';
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.summary(languageCode),
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
        ),
        const SizedBox(height: 14),
        Text(
          context.tr('connectedFeaturesStatusLabel'),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        _StatusPill(
          label: _runtimeStatusLabel(context, status, item.availability),
          color: status == ConnectedFeatureRuntimeStatus.enabled
              ? Colors.teal
              : Colors.orange,
        ),
        const SizedBox(height: 14),
        Text(
          context.tr('connectedFeaturesRequirementsLabel'),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final requirement in item.requirements)
              _RequirementPill(label: _requirementLabel(context, requirement)),
          ],
        ),
      ],
    );
  }

  String _runtimeStatusLabel(
    BuildContext context,
    ConnectedFeatureRuntimeStatus status,
    ConnectedFeatureAvailability availability,
  ) {
    if (status == ConnectedFeatureRuntimeStatus.enabled) {
      return context.tr('connectedFeaturesStatusEnabled');
    }

    return switch (availability) {
      ConnectedFeatureAvailability.planned => context.tr(
        'connectedFeaturesStatusGated',
      ),
    };
  }

  String _requirementLabel(
    BuildContext context,
    ConnectedFeatureRequirement requirement,
  ) {
    return switch (requirement) {
      ConnectedFeatureRequirement.auth => context.tr(
        'connectedRequirementAuth',
      ),
      ConnectedFeatureRequirement.backendApi => context.tr(
        'connectedRequirementBackendApi',
      ),
      ConnectedFeatureRequirement.privacyConsent => context.tr(
        'connectedRequirementPrivacyConsent',
      ),
      ConnectedFeatureRequirement.moderation => context.tr(
        'connectedRequirementModeration',
      ),
      ConnectedFeatureRequirement.expertOperations => context.tr(
        'connectedRequirementExpertOperations',
      ),
      ConnectedFeatureRequirement.safetyRouting => context.tr(
        'connectedRequirementSafetyRouting',
      ),
      ConnectedFeatureRequirement.partnerOperations => context.tr(
        'connectedRequirementPartnerOperations',
      ),
    };
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _RequirementPill extends StatelessWidget {
  const _RequirementPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.secondaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
