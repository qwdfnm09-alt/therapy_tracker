import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingHistory = context.watch<AppState>().bookingHistory;
    final latestBooking = bookingHistory.isEmpty ? null : bookingHistory.first;

    return AppPage(
      title: context.tr('bookingHistory'),
      child: bookingHistory.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  context.tr('bookingHistoryEmpty'),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: bookingHistory.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SectionCard(
                    title: context.tr('bookingHistoryOverviewTitle'),
                    icon: Icons.insights_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('bookingHistoryOverviewBody'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 14),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final useSingleColumn = constraints.maxWidth < 430;
                            return GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: useSingleColumn ? 1 : 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: useSingleColumn ? 104 : 120,
                                  ),
                              children: [
                                _OverviewCard(
                                  label: context.tr('bookingHistory'),
                                  value: bookingHistory.length.toString(),
                                  helper: context.tr(
                                    'bookingHistoryOverviewCountHelper',
                                  ),
                                  icon: Icons.receipt_long_outlined,
                                  color: Colors.indigo,
                                ),
                                _OverviewCard(
                                  label: context.tr('bookingStatus'),
                                  value: _submissionStatusLabel(
                                    context,
                                    latestBooking?['sendStatus'],
                                  ),
                                  helper: context.tr(
                                    'bookingHistoryOverviewStatusHelper',
                                  ),
                                  icon: Icons.send_time_extension_outlined,
                                  color: Colors.teal,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr('bookingHistoryOverviewLatestTitle'),
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _latestBookingSummary(
                                  context,
                                  latestBooking ?? const {},
                                ),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(height: 1.35),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.counseling,
                            ),
                            icon: const Icon(Icons.add_circle_outline_rounded),
                            label: Text(context.tr('startNewBooking')),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final booking = bookingHistory[index - 1];
                return SectionCard(
                  title: '${context.tr('booking')} #$index',
                  icon: Icons.event_note_outlined,
                  child: Column(
                    children: [
                      _BookingRow(
                        label: context.tr('bookingType'),
                        value: _sessionTypeLabel(
                          context,
                          booking['sessionType'],
                        ),
                      ),
                      const SizedBox(height: 10),
                      _BookingRow(
                        label: context.tr('bookingDate'),
                        value: booking['preferredDate'] ?? '-',
                      ),
                      const SizedBox(height: 10),
                      _BookingRow(
                        label: context.tr('bookingPhone'),
                        value: booking['phone'] ?? '-',
                      ),
                      if ((booking['sendStatus'] ?? '').isNotEmpty) ...[
                        const SizedBox(height: 10),
                        _BookingRow(
                          label: context.tr('bookingStatus'),
                          value: _submissionStatusLabel(
                            context,
                            booking['sendStatus'],
                          ),
                        ),
                      ],
                      if ((booking['resultVerdict'] ?? '').isNotEmpty) ...[
                        const SizedBox(height: 10),
                        _BookingRow(
                          label: context.tr('bookingResultVerdict'),
                          value: booking['resultVerdict']!,
                        ),
                      ],
                      if ((booking['recommendedReason'] ?? '').isNotEmpty) ...[
                        const SizedBox(height: 10),
                        _BookingRow(
                          label: context.tr('bookingRecommendation'),
                          value: booking['recommendedReason']!,
                        ),
                      ],
                      if ((booking['message'] ?? '').isNotEmpty) ...[
                        const SizedBox(height: 10),
                        _BookingRow(
                          label: context.tr('bookingMessage'),
                          value: booking['message']!,
                        ),
                      ],
                      if ((booking['createdAt'] ?? '').isNotEmpty) ...[
                        const SizedBox(height: 10),
                        _BookingRow(
                          label: context.tr('createdAt'),
                          value: booking['createdAt']!,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
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

  String _latestBookingSummary(
    BuildContext context,
    Map<String, String> booking,
  ) {
    final type = _sessionTypeLabel(context, booking['sessionType']);
    final date = booking['preferredDate'] ?? '-';
    final status = _submissionStatusLabel(context, booking['sendStatus']);
    return '$type • $date • $status';
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.label,
    required this.value,
    required this.helper,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String helper;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const Spacer(),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            helper,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({required this.label, required this.value});

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
          ),
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [labelText, const SizedBox(height: 4), valueText],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 112, child: labelText),
            const SizedBox(width: 10),
            Expanded(child: valueText),
          ],
        );
      },
    );
  }
}
