import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final theme = Theme.of(context);
    final hasProfiles = appState.hasCompleteProfiles;
    final hasQuestionnaire = appState.hasCompletedQuestionnaire;
    final mainJourneyItems = [
      _FeatureItem(
        title: context.tr('personalityTest'),
        subtitle: context.tr('featurePersonality'),
        icon: Icons.psychology_alt_outlined,
        enabled: hasProfiles,
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.personalityTest),
      ),
      _FeatureItem(
        title: context.tr('result'),
        subtitle: context.tr('featureResults'),
        icon: Icons.analytics_outlined,
        enabled: appState.result != null && hasQuestionnaire,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.results),
      ),
      _FeatureItem(
        title: context.tr('booking'),
        subtitle: context.tr('featureCounseling'),
        icon: Icons.calendar_month_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.counseling),
      ),
    ];
    final supportToolItems = [
      _FeatureItem(
        title: context.tr('educationalHub'),
        subtitle: context.tr('featureEducationalHub'),
        icon: Icons.menu_book_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.educationalHub),
      ),
      _FeatureItem(
        title: context.tr('relationshipTools'),
        subtitle: context.tr('featureRelationshipTools'),
        icon: Icons.favorite_border_rounded,
        enabled: true,
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.relationshipTools),
      ),
      _FeatureItem(
        title: context.tr('scenarioLab'),
        subtitle: context.tr('featureScenarioLab'),
        icon: Icons.radar_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.scenarioLab),
      ),
      _FeatureItem(
        title: context.tr('resourcesToolsHub'),
        subtitle: context.tr('featureResourcesToolsHub'),
        icon: Icons.widgets_outlined,
        enabled: true,
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.resourcesToolsHub),
      ),
      _FeatureItem(
        title: context.tr('problemBox'),
        subtitle: context.tr('featureProblemBox'),
        icon: Icons.mark_unread_chat_alt_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.problemBox),
      ),
      _FeatureItem(
        title: context.tr('emergencySupport'),
        subtitle: context.tr('featureEmergencySupport'),
        icon: Icons.sos_outlined,
        enabled: true,
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.emergencySupport),
      ),
      _FeatureItem(
        title: context.tr('guidedMediator'),
        subtitle: context.tr('featureGuidedMediator'),
        icon: Icons.forum_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.guidedMediator),
      ),
      _FeatureItem(
        title: context.tr('partnerOffers'),
        subtitle: context.tr('partnerOffersTileBody'),
        icon: Icons.local_offer_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.partnerOffers),
      ),
      _FeatureItem(
        title: context.tr('settings'),
        subtitle: context.tr('featureSettings'),
        icon: Icons.settings_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
      ),
    ];

    return AppPage(
      titleWidget: Text(
        context.tr('appName'),
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
      ),
      actions: [
        IconButton(
          tooltip: context.tr('settings'),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8787ED), Color(0xFF7984DD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroStateChip(
                            label: _heroStateLabel(context, appState),
                            icon: _heroStateIcon(appState),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            context.tr('homeHeroTitle'),
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.tr('homeHeroBody'),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimary.withValues(
                                alpha: 0.85,
                              ),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.08,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 34,
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.72,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          _assessmentRoute(appState),
                        ),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  appState.userA == null &&
                                          appState.userB == null
                                      ? context.tr('startAssessment')
                                      : context.tr('continueAssessment'),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _FeatureSection(
            title: context.tr('homeMainJourney'),
            icon: Icons.flag_outlined,
            items: mainJourneyItems,
            featured: true,
          ),
          const SizedBox(height: 24),
          _FeatureSection(
            title: context.tr('homeSupportTools'),
            icon: Icons.dashboard_customize_outlined,
            items: supportToolItems,
            compact: true,
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: context.tr('homeProgress'),
            icon: Icons.timeline_outlined,
            child: Column(
              children: [
                _ProgressSubsection(
                  title: context.tr('assessmentStatus'),
                  icon: Icons.assignment_turned_in_outlined,
                  child: Column(
                    children: [
                      _StatusRow(
                        label: context.tr('userA'),
                        ready: appState.userA?.hasRequiredInfo ?? false,
                      ),
                      const SizedBox(height: 10),
                      _StatusRow(
                        label: context.tr('userB'),
                        ready: appState.userB?.hasRequiredInfo ?? false,
                      ),
                      const SizedBox(height: 10),
                      _StatusRow(
                        label: context.tr('questionnaire'),
                        ready: hasQuestionnaire,
                      ),
                      const SizedBox(height: 10),
                      _StatusRow(
                        label: context.tr('result'),
                        ready: appState.result != null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _ProgressSubsection(
                  title: context.tr('latestBooking'),
                  icon: Icons.event_note_outlined,
                  child: _LatestBookingSummary(
                    latestBooking: appState.latestBooking,
                    sessionTypeLabel: (value) =>
                        _sessionTypeLabel(context, value),
                    submissionStatusLabel: (value) =>
                        _submissionStatusLabel(context, value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _assessmentRoute(AppState appState) {
    final userAReady = appState.userA?.hasRequiredInfo ?? false;
    final userBReady = appState.userB?.hasRequiredInfo ?? false;

    if (!userAReady) return AppRoutes.userAForm;
    if (!userBReady) return AppRoutes.userBForm;
    return AppRoutes.personalityTest;
  }

  String _sessionTypeLabel(BuildContext context, String? value) {
    return switch (value) {
      'family' => context.tr('sessionTypeFamily'),
      'individual' => context.tr('sessionTypeIndividual'),
      'coaching' => context.tr('sessionTypeCoaching'),
      _ => '-',
    };
  }

  String _submissionStatusLabel(BuildContext context, String? value) {
    return switch (value) {
      'whatsapp' => context.tr('bookingStatusWhatsapp'),
      'sms' => context.tr('bookingStatusSms'),
      'call' => context.tr('bookingStatusCall'),
      'failed' => context.tr('bookingStatusFailed'),
      _ => '-',
    };
  }

  String _heroStateLabel(BuildContext context, AppState appState) {
    if (appState.result != null) {
      return context.tr('homeHeroStateResultReady');
    }
    if (appState.hasCompleteProfiles) {
      return context.tr('homeHeroStateInProgress');
    }
    return context.tr('homeHeroStateProfilesIncomplete');
  }

  IconData _heroStateIcon(AppState appState) {
    if (appState.result != null) {
      return Icons.verified_outlined;
    }
    if (appState.hasCompleteProfiles) {
      return Icons.timelapse_outlined;
    }
    return Icons.assignment_late_outlined;
  }
}

class _HeroStateChip extends StatelessWidget {
  const _HeroStateChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: onPrimary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: onPrimary.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(icon, size: 16, color: onPrimary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection({
    required this.title,
    required this.icon,
    required this.items,
    this.featured = false,
    this.compact = false,
  });

  final String title;
  final IconData icon;
  final List<_FeatureItem> items;
  final bool featured;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      icon: icon,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useSingleColumn = constraints.maxWidth < 430;
          final featuredSingleColumn = constraints.maxWidth < 760;
          final compactDesktop = constraints.maxWidth >= 980;
          final mobileMainJourneyExtent = featured && featuredSingleColumn
              ? 172.0
              : null;
          final mobileSupportExtent = compact && useSingleColumn ? 186.0 : null;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: featured
                  ? (featuredSingleColumn ? 1 : 3)
                  : compact
                  ? (useSingleColumn ? 1 : (compactDesktop ? 3 : 2))
                  : (useSingleColumn ? 1 : 2),
              mainAxisSpacing: featured ? 14 : (compact ? 14 : 18),
              crossAxisSpacing: 12,
              mainAxisExtent: mobileMainJourneyExtent ?? mobileSupportExtent,
              childAspectRatio: featured
                  ? (featuredSingleColumn ? 2.55 : 1.08)
                  : compact
                  ? (useSingleColumn ? 2.4 : (compactDesktop ? 1.2 : 1.05))
                  : (useSingleColumn ? 2.15 : 1.08),
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _FeatureCard(
                item: items[index],
                index: index,
                featured: featured,
                compact: compact,
                singleColumn: featured ? featuredSingleColumn : useSingleColumn,
              );
            },
          );
        },
      ),
    );
  }
}

class _ProgressSubsection extends StatelessWidget {
  const _ProgressSubsection({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 18, color: theme.colorScheme.secondary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _LatestBookingSummary extends StatelessWidget {
  const _LatestBookingSummary({
    required this.latestBooking,
    required this.sessionTypeLabel,
    required this.submissionStatusLabel,
  });

  final Map<String, String>? latestBooking;
  final String Function(String?) sessionTypeLabel;
  final String Function(String?) submissionStatusLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (latestBooking == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25),
          ),
        ),
        child: Text(
          context.tr('noBookingYet'),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _BookingRow(
            icon: Icons.category_outlined,
            label: context.tr('bookingType'),
            value: sessionTypeLabel(latestBooking!['sessionType']),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _BookingRow(
            icon: Icons.calendar_today_outlined,
            label: context.tr('bookingDate'),
            value: latestBooking!['preferredDate'] ?? '-',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _BookingRow(
            icon: Icons.phone_outlined,
            label: context.tr('bookingPhone'),
            value: latestBooking!['phone'] ?? '-',
          ),
          if ((latestBooking!['sendStatus'] ?? '').isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, thickness: 0.5),
            ),
            _BookingRow(
              icon: Icons.send_time_extension_outlined,
              label: context.tr('bookingStatus'),
              value: submissionStatusLabel(latestBooking!['sendStatus']),
            ),
          ],
          if ((latestBooking!['message'] ?? '').isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, thickness: 0.5),
            ),
            _BookingRow(
              icon: Icons.chat_bubble_outline_rounded,
              label: context.tr('bookingMessage'),
              value: latestBooking!['message']!,
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.bookingHistory),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.open_in_new_rounded, size: 18),
              label: Text(context.tr('viewBookingHistory')),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  const _FeatureItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.item,
    required this.index,
    this.featured = false,
    this.compact = false,
    this.singleColumn = false,
  });

  final _FeatureItem item;
  final int index;
  final bool featured;
  final bool compact;
  final bool singleColumn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorList = [
      Colors.indigo,
      Colors.teal,
      Colors.orange,
      Colors.blueGrey,
    ];
    final baseColor = colorList[index % colorList.length];

    final foreground = item.enabled
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurfaceVariant;

    final bgColor = item.enabled
        ? baseColor.withValues(alpha: featured ? 0.14 : 0.08)
        : theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: compact ? 0.28 : 0.4,
          );

    final iconBgColor = item.enabled
        ? baseColor.withValues(alpha: featured ? 0.18 : 0.12)
        : theme.colorScheme.surface;

    final iconColor = item.enabled ? baseColor : theme.colorScheme.outline;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(featured ? 28 : 24),
        border: Border.all(
          color: item.enabled
              ? baseColor.withValues(alpha: featured ? 0.18 : 0.1)
              : Colors.transparent,
          width: 1,
        ),
        boxShadow: featured && item.enabled
            ? [
                BoxShadow(
                  color: baseColor.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : compact && item.enabled
            ? [
                BoxShadow(
                  color: baseColor.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.enabled ? item.onPressed : null,
          borderRadius: BorderRadius.circular(featured ? 28 : 24),
          child: Padding(
            padding: EdgeInsets.all(featured ? 18 : (compact ? 14 : 16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        featured ? 12 : (compact ? 9 : 10),
                      ),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        color: iconColor,
                        size: featured ? 24 : (compact ? 20 : 22),
                      ),
                    ),
                    const Spacer(),
                    if (!item.enabled)
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 18,
                        color: theme.colorScheme.outline,
                      )
                    else if (featured)
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: baseColor,
                      )
                    else if (compact)
                      Icon(
                        Icons.arrow_outward_rounded,
                        size: 16,
                        color: baseColor.withValues(alpha: 0.85),
                      ),
                  ],
                ),
                SizedBox(height: featured ? 16 : (compact ? 14 : 16)),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      (featured
                              ? theme.textTheme.titleMedium
                              : theme.textTheme.titleSmall)
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: foreground,
                          ),
                ),
                SizedBox(height: featured ? 6 : (compact ? 5 : 4)),
                Text(
                  item.subtitle,
                  maxLines: featured
                      ? (singleColumn ? 2 : 3)
                      : (compact && singleColumn ? 1 : 2),
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: foreground.withValues(alpha: 0.65),
                    fontSize: featured ? 12.5 : (compact ? 11.5 : 12),
                    fontWeight: featured
                        ? FontWeight.w600
                        : (compact ? FontWeight.w500 : FontWeight.w500),
                    height: featured ? 1.35 : (compact ? 1.3 : null),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.ready});

  final String label;
  final bool ready;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = ready
        ? theme.colorScheme.primary.withValues(alpha: 0.05)
        : theme.colorScheme.surface.withValues(alpha: 0.55);
    final borderColor = ready
        ? theme.colorScheme.primary.withValues(alpha: 0.12)
        : theme.colorScheme.outlineVariant.withValues(alpha: 0.2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(
            ready
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 22,
            color: ready
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: ready ? FontWeight.w700 : FontWeight.w500,
                color: ready
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: ready
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              ready ? context.tr('completed') : context.tr('pending'),
              style: theme.textTheme.labelSmall?.copyWith(
                color: ready
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 420;
        final labelText = Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        );
        final valueText = Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSecondaryContainer,
          ),
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 16,
              color: theme.colorScheme.secondary.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: compact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText,
                        const SizedBox(height: 4),
                        valueText,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 94, child: labelText),
                        const SizedBox(width: 8),
                        Expanded(child: valueText),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
