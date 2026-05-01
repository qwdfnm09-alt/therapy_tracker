import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingHistory = context.watch<AppState>().bookingHistory;

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
              itemCount: bookingHistory.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final booking = bookingHistory[index];
                return SectionCard(
                  title: '${context.tr('booking')} #${index + 1}',
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
