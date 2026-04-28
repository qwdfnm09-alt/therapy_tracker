import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return AppPage(
      title: context.tr('booking'),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
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
                    validator: _required,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _dateController,
                    label: context.tr('preferredDate'),
                    validator: _required,
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

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return '*';
    return null;
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
