import 'package:flutter/material.dart';

import '../../../core/constants/clinic_contact.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/emergency_support_repository.dart';
import '../../../domain/services/booking_submission_service.dart';

class EmergencySupportScreen extends StatelessWidget {
  const EmergencySupportScreen({
    super.key,
    this.repository = const EmergencySupportRepository(),
    this.submissionService = const BookingSubmissionService(),
  });

  final EmergencySupportRepository repository;
  final BookingSubmissionService submissionService;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final sections = repository.guidanceSections();

    return AppPage(
      title: context.tr('emergencySupport'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('emergencySupportIntroTitle'),
            icon: Icons.support_agent_outlined,
            child: Text(context.tr('emergencySupportIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('emergencySupportQuickActionsTitle'),
            icon: Icons.contact_phone_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.tr('clinicPhone')}: $clinicPhoneNumber',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: () => _openCall(context),
                      icon: const Icon(Icons.call_outlined),
                      label: Text(context.tr('callClinicAction')),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () => _openWhatsapp(context),
                      icon: const Icon(Icons.chat_outlined),
                      label: Text(context.tr('openWhatsapp')),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  context.tr('emergencySupportActionNote'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < sections.length; i++) ...[
            SectionCard(
              title: sections[i].title(languageCode),
              icon: Icons.health_and_safety_outlined,
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
                    _EmergencyItemTile(
                      title: sections[i].items[j].title(languageCode),
                      body: sections[i].items[j].body(languageCode),
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

  Future<void> _openCall(BuildContext context) async {
    final opened = await submissionService.openCall();
    if (!context.mounted || opened) return;

    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(SnackBar(content: Text(context.tr('bookingActionFailed'))));
  }

  Future<void> _openWhatsapp(BuildContext context) async {
    final opened = await submissionService.openWhatsApp(_emergencyMessage());
    if (!context.mounted || opened) return;

    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(SnackBar(content: Text(context.tr('bookingActionFailed'))));
  }

  String _emergencyMessage() {
    return [
      'Emergency support contact request',
      'The user opened the emergency support screen and needs a fast follow-up.',
      'Please review the situation and advise on the safest next step.',
    ].join('\n');
  }
}

class _EmergencyItemTile extends StatelessWidget {
  const _EmergencyItemTile({required this.title, required this.body});

  final String title;
  final String body;

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
