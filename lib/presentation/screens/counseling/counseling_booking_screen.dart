import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/form_text_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class CounselingBookingScreen extends StatefulWidget {
  const CounselingBookingScreen({super.key});

  @override
  State<CounselingBookingScreen> createState() =>
      _CounselingBookingScreenState();
}

class _CounselingBookingScreenState extends State<CounselingBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _messageController = TextEditingController();
  String _sessionType = 'family';

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

    return AppPage(
      title: context.tr('booking'),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
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
              onPressed: _submit,
              icon: const Icon(Icons.send_outlined),
              label: Text(context.tr('confirmBooking')),
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
    if (!_formKey.currentState!.validate()) return;
    await context.read<AppState>().saveBooking({
      'sessionType': _sessionType,
      'phone': _phoneController.text.trim(),
      'preferredDate': _dateController.text.trim(),
      'message': _messageController.text.trim(),
      'createdAt': DateTime.now().toIso8601String(),
    });
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr('bookingSaved'))));
    _formKey.currentState?.reset();
    _phoneController.clear();
    _dateController.clear();
    _messageController.clear();
    setState(() => _sessionType = 'family');
  }

  String _sessionTypeLabel(String? value) {
    return switch (value) {
      'family' => context.tr('sessionTypeFamily'),
      'individual' => context.tr('sessionTypeIndividual'),
      'coaching' => context.tr('sessionTypeCoaching'),
      _ => '-',
    };
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
