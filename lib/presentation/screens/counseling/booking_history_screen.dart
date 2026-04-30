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
