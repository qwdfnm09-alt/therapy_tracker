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
    final featureItems = [
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
        title: context.tr('resourcesToolsHub'),
        subtitle: context.tr('featureResourcesToolsHub'),
        icon: Icons.widgets_outlined,
        enabled: true,
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.resourcesToolsHub),
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
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primaryContainer.withBlue(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr('homeTitle'),
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.tr('homeBody'),
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
                    Icon(
                      Icons.favorite_rounded,
                      size: 64,
                      color: theme.colorScheme.onPrimary.withValues(
                        alpha: 0.15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      _assessmentRoute(appState),
                    ),
                    child: Container(
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            appState.userA == null && appState.userB == null
                                ? context.tr('startAssessment')
                                : context.tr('continueAssessment'),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: context.tr('quickAccess'),
            icon: Icons.dashboard_outlined,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final useSingleColumn = constraints.maxWidth < 430;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: useSingleColumn ? 1 : 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: useSingleColumn ? 2.15 : 1.08,
                  ),
                  itemCount: featureItems.length,
                  itemBuilder: (context, index) {
                    return _FeatureCard(
                      item: featureItems[index],
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          SectionCard(
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
          const SizedBox(height: 20),
          SectionCard(
            title: context.tr('latestBooking'),
            icon: Icons.event_note_outlined,
            child: appState.latestBooking == null
                ? Text(context.tr('noBookingYet'))
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.secondary.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        _BookingRow(
                          icon: Icons.category_outlined,
                          label: context.tr('bookingType'),
                          value: _sessionTypeLabel(
                            context,
                            appState.latestBooking!['sessionType'],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 1, thickness: 0.5),
                        ),
                        _BookingRow(
                          icon: Icons.calendar_today_outlined,
                          label: context.tr('bookingDate'),
                          value:
                              appState.latestBooking!['preferredDate'] ?? '-',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 1, thickness: 0.5),
                        ),
                        _BookingRow(
                          icon: Icons.phone_outlined,
                          label: context.tr('bookingPhone'),
                          value: appState.latestBooking!['phone'] ?? '-',
                        ),
                        if ((appState.latestBooking!['sendStatus'] ?? '')
                            .isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(height: 1, thickness: 0.5),
                          ),
                          _BookingRow(
                            icon: Icons.send_time_extension_outlined,
                            label: context.tr('bookingStatus'),
                            value: _submissionStatusLabel(
                              context,
                              appState.latestBooking!['sendStatus'],
                            ),
                          ),
                        ],
                        if ((appState.latestBooking!['message'] ?? '')
                            .isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(height: 1, thickness: 0.5),
                          ),
                          _BookingRow(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: context.tr('bookingMessage'),
                            value: appState.latestBooking!['message']!,
                          ),
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.bookingHistory,
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.open_in_new_rounded,
                              size: 18,
                            ),
                            label: Text(context.tr('viewBookingHistory')),
                          ),
                        ),
                      ],
                    ),
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
  const _FeatureCard({required this.item, required this.index});

  final _FeatureItem item;
  final int index;

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
        ? baseColor.withValues(alpha: 0.08)
        : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4);

    final iconBgColor = item.enabled
        ? baseColor.withValues(alpha: 0.12)
        : theme.colorScheme.surface;

    final iconColor = item.enabled ? baseColor : theme.colorScheme.outline;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: item.enabled
              ? baseColor.withValues(alpha: 0.1)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.enabled ? item.onPressed : null,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: iconColor, size: 22),
                    ),
                    const Spacer(),
                    if (!item.enabled)
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 18,
                        color: theme.colorScheme.outline,
                      ),
                  ],
                ),
                const Spacer(),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: foreground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: foreground.withValues(alpha: 0.65),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ready
            ? theme.colorScheme.primary.withValues(alpha: 0.04)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ready
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
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
