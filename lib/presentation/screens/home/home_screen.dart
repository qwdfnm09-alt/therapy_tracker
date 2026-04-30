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
        onPressed: () => Navigator.pushNamed(context, AppRoutes.personalityTest),
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
        title: context.tr('settings'),
        subtitle: context.tr('featureSettings'),
        icon: Icons.settings_outlined,
        enabled: true,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
      ),
    ];

    return AppPage(
      title: context.tr('appName'),
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
          SectionCard(
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('homeTitle'),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.tr('homeBody'),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, _assessmentRoute(appState)),
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(
              appState.userA == null && appState.userB == null
                  ? context.tr('startAssessment')
                  : context.tr('continueAssessment'),
            ),
          ),
          const SizedBox(height: 20),
          SectionCard(
            title: context.tr('quickAccess'),
            icon: Icons.dashboard_outlined,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.08,
              ),
              itemCount: featureItems.length,
              itemBuilder: (context, index) {
                return _FeatureCard(item: featureItems[index]);
              },
            ),
          ),
          const SizedBox(height: 20),
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
                : Column(
                    children: [
                      _BookingRow(
                        label: context.tr('bookingType'),
                        value: _sessionTypeLabel(
                          context,
                          appState.latestBooking!['sessionType'],
                        ),
                      ),
                      const SizedBox(height: 10),
                      _BookingRow(
                        label: context.tr('bookingDate'),
                        value: appState.latestBooking!['preferredDate'] ?? '-',
                      ),
                      const SizedBox(height: 10),
                      _BookingRow(
                        label: context.tr('bookingPhone'),
                        value: appState.latestBooking!['phone'] ?? '-',
                      ),
                      if ((appState.latestBooking!['message'] ?? '').isNotEmpty)
                        ...[
                          const SizedBox(height: 10),
                          _BookingRow(
                            label: context.tr('bookingMessage'),
                            value: appState.latestBooking!['message']!,
                          ),
                        ],
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutes.bookingHistory,
                          ),
                          icon: const Icon(Icons.open_in_new_rounded),
                          label: Text(context.tr('viewBookingHistory')),
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
  const _FeatureCard({required this.item});

  final _FeatureItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = item.enabled
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurfaceVariant;
    final iconColor = item.enabled
        ? theme.colorScheme.primary
        : theme.colorScheme.outline;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item.enabled ? item.onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(item.icon, color: iconColor),
                  const Spacer(),
                  Icon(
                    item.enabled
                        ? Icons.arrow_forward_rounded
                        : Icons.lock_outline_rounded,
                    size: 18,
                    color: iconColor,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: foreground,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(color: foreground),
              ),
            ],
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

    return Row(
      children: [
        Icon(
          ready ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          size: 20,
          color: ready
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(label)),
        Text(
          ready ? context.tr('completed') : context.tr('pending'),
          style: theme.textTheme.labelLarge?.copyWith(
            color: ready
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 110, child: Text(label)),
        const SizedBox(width: 10),
        Expanded(child: Text(value)),
      ],
    );
  }
}
