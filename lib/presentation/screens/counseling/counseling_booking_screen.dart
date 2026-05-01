import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/clinic_contact.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/form_text_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/compatibility_result.dart';
import '../../../domain/services/booking_submission_service.dart';
import '../../providers/app_state.dart';

class CounselingBookingScreen extends StatefulWidget {
  const CounselingBookingScreen({super.key});

  @override
  State<CounselingBookingScreen> createState() =>
      _CounselingBookingScreenState();
}

class _CounselingBookingScreenState extends State<CounselingBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _submissionService = BookingSubmissionService();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _messageController = TextEditingController();
  String _sessionType = 'family';
  CompatibilityResult? _resultSnapshot;
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _resultSnapshot = context.read<AppState>().result;
    _sessionType = _recommendedSessionType(_resultSnapshot);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _dateController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final latestBooking = context.watch<AppState>().latestBooking;
    final recommendedReason = _recommendedReason(context, _resultSnapshot);

    return AppPage(
      title: context.tr('booking'),
      child: Form(
        key: _formKey,
        autovalidateMode: _submitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (_resultSnapshot != null) ...[
              SectionCard(
                title: context.tr('recommendedSessionTitle'),
                icon: Icons.auto_awesome_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BookingRow(
                      label: context.tr('bookingType'),
                      value: _sessionTypeLabel(_sessionType),
                    ),
                    const SizedBox(height: 10),
                    Text(recommendedReason),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (latestBooking != null) ...[
              SectionCard(
                title: context.tr('latestBooking'),
                icon: Icons.history_toggle_off_outlined,
                child: Column(
                  children: [
                    _BookingRow(
                      label: context.tr('bookingType'),
                      value: _sessionTypeLabel(latestBooking['sessionType']),
                    ),
                    const SizedBox(height: 10),
                    _BookingRow(
                      label: context.tr('bookingDate'),
                      value: latestBooking['preferredDate'] ?? '-',
                    ),
                    const SizedBox(height: 10),
                    _BookingRow(
                      label: context.tr('bookingPhone'),
                      value: latestBooking['phone'] ?? '-',
                    ),
                    if ((latestBooking['sendStatus'] ?? '').isNotEmpty) ...[
                      const SizedBox(height: 10),
                      _BookingRow(
                        label: context.tr('bookingStatus'),
                        value: _submissionStatusLabel(
                          context,
                          latestBooking['sendStatus'],
                        ),
                      ),
                    ],
                    if ((latestBooking['message'] ?? '').isNotEmpty) ...[
                      const SizedBox(height: 10),
                      _BookingRow(
                        label: context.tr('bookingMessage'),
                        value: latestBooking['message']!,
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
                        icon: const Icon(Icons.history_rounded),
                        label: Text(context.tr('viewBookingHistory')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            SectionCard(
              title: context.tr('sessions'),
              icon: Icons.support_agent_outlined,
              child: RadioGroup<String>(
                groupValue: _sessionType,
                onChanged: _setSessionType,
                child: Column(
                  children: [
                    _SessionTile(
                      value: 'family',
                      title: context.tr('bookConsultation'),
                      icon: Icons.family_restroom_outlined,
                    ),
                    _SessionTile(
                      value: 'individual',
                      title: context.tr('individualTherapy'),
                      icon: Icons.person_search_outlined,
                    ),
                    _SessionTile(
                      value: 'coaching',
                      title: context.tr('coaching'),
                      icon: Icons.school_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: context.tr('booking'),
              icon: Icons.edit_calendar_outlined,
              child: Column(
                children: [
                  _BookingRow(
                    label: context.tr('clinicPhone'),
                    value: clinicPhoneNumber,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _phoneController,
                    label: context.tr('phone'),
                    keyboardType: TextInputType.phone,
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _dateController,
                    label: context.tr('preferredDate'),
                    validator: _validateDate,
                    readOnly: true,
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _messageController,
                    label: context.tr('message'),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSubmitting ? null : _submit,
              icon: _isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_outlined),
              label: Text(
                _resultSnapshot == null
                    ? context.tr('confirmBooking')
                    : context.tr('bookRecommendedSession'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setSessionType(String? value) {
    if (value == null) return;
    setState(() => _sessionType = value);
  }

  String? _validatePhone(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return context.tr('fieldRequired');
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digitsOnly.length < 8) return context.tr('invalidPhone');
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr('selectPreferredDate');
    }
    return null;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked == null || !mounted) return;
    _dateController.text =
        '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    FocusScope.of(context).unfocus();
    final appState = context.read<AppState>();
    final recommendedReason = _recommendedReason(context, _resultSnapshot);
    final resultVerdict = _resultVerdict(context, _resultSnapshot);
    final booking = {
      'sessionType': _sessionType,
      'phone': _phoneController.text.trim(),
      'preferredDate': _dateController.text.trim(),
      'message': _messageController.text.trim(),
      'recommendedReason': recommendedReason,
      'resultVerdict': resultVerdict,
      'createdAt': DateTime.now().toIso8601String(),
    };
    try {
      final messageText = _submissionService.buildMessage(
        sessionTypeLabel: _sessionTypeLabel(_sessionType),
        clientPhone: booking['phone'] ?? '',
        preferredDate: booking['preferredDate'] ?? '',
        message: booking['message'] ?? '',
        recommendedReason: booking['recommendedReason'],
        resultVerdict: booking['resultVerdict'],
      );
      await appState
          .saveBooking({...booking, 'sendStatus': 'failed'})
          .timeout(const Duration(seconds: 2), onTimeout: () {});
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => _BookingConfirmationPage(
            submission: BookingSubmissionResult(
              success: false,
              channel: 'failed',
              messageText: messageText,
            ),
          ),
        ),
      );
      if (!mounted) return;
      _formKey.currentState?.reset();
      _phoneController.clear();
      _dateController.clear();
      _messageController.clear();
      setState(() => _sessionType = 'family');
    } finally {
      if (mounted && _isSubmitting) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _sessionTypeLabel(String? value) {
    return switch (value) {
      'family' => context.tr('sessionTypeFamily'),
      'individual' => context.tr('sessionTypeIndividual'),
      'coaching' => context.tr('sessionTypeCoaching'),
      _ => '-',
    };
  }

  String _recommendedReason(BuildContext context, CompatibilityResult? result) {
    if (result == null) return '';
    final sessions = result.suggestedSessions;
    if (sessions.contains('session:individualReadiness')) {
      return context.tr('recommendedReasonIndividual');
    }
    if (sessions.contains('session:familyBoundaries')) {
      return context.tr('recommendedReasonFamily');
    }
    if (sessions.contains('session:futurePlanning')) {
      return context.tr('recommendedReasonPlanning');
    }
    if (sessions.contains('session:communication')) {
      return context.tr('recommendedReasonCommunication');
    }
    return context.tr('recommendedReasonAlignment');
  }

  String _resultVerdict(BuildContext context, CompatibilityResult? result) {
    if (result == null) return '';
    if (result.compatibilityPercentage >= 80) {
      return context.tr('verdictStrong');
    }
    if (result.compatibilityPercentage >= 65) {
      return context.tr('verdictWorkable');
    }
    return context.tr('verdictFragile');
  }

  String _recommendedSessionType(CompatibilityResult? result) {
    if (result == null) return 'family';
    final sessions = result.suggestedSessions;
    if (sessions.contains('session:individualReadiness')) {
      return 'individual';
    }
    if (sessions.contains('session:familyBoundaries')) {
      return 'family';
    }
    return 'coaching';
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

class _BookingConfirmationPage extends StatelessWidget {
  _BookingConfirmationPage({required this.submission});

  final BookingSubmissionResult submission;
  final BookingSubmissionService _submissionService =
      BookingSubmissionService();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.tr('bookingConfirmationTitle'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('bookingConfirmationTitle'),
            icon: Icons.check_circle_outline,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BookingRow(
                  label: context.tr('clinicPhone'),
                  value: clinicPhoneNumber,
                ),
                const SizedBox(height: 10),
                _BookingRow(
                  label: context.tr('bookingStatus'),
                  value: switch (submission.channel) {
                    'whatsapp' => context.tr('bookingStatusWhatsapp'),
                    'sms' => context.tr('bookingStatusSms'),
                    'call' => context.tr('bookingStatusCall'),
                    _ => context.tr('bookingStatusFailed'),
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _openBookingAction(
                        context,
                        () => _submissionService.openWhatsApp(
                          submission.messageText,
                        ),
                      ),
                      icon: const Icon(Icons.chat_outlined),
                      label: Text(context.tr('openWhatsapp')),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openBookingAction(
                        context,
                        () =>
                            _submissionService.openSms(submission.messageText),
                      ),
                      icon: const Icon(Icons.sms_outlined),
                      label: Text(context.tr('openSms')),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openBookingAction(
                        context,
                        _submissionService.openCall,
                      ),
                      icon: const Icon(Icons.call_outlined),
                      label: Text(context.tr('callClinicAction')),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: submission.messageText),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                        SnackBar(
                          content: Text(context.tr('bookingMessageCopied')),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy_all_rounded),
                    label: Text(context.tr('copyBookingMessage')),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.bookingHistory),
                    icon: const Icon(Icons.history_rounded),
                    label: Text(context.tr('openBookingHistory')),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.tr('done')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openBookingAction(
    BuildContext context,
    Future<bool> Function() action,
  ) async {
    final opened = await action();
    if (!context.mounted || opened) return;
    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(SnackBar(content: Text(context.tr('bookingActionFailed'))));
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.value,
    required this.title,
    required this.icon,
  });

  final String value;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: value,
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
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
