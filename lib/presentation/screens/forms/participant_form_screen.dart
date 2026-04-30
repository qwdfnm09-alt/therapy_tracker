import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/form_text_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/participant_profile.dart';
import '../../providers/app_state.dart';

class ParticipantFormScreen extends StatefulWidget {
  const ParticipantFormScreen({super.key, required this.slot});

  final ParticipantSlot slot;

  @override
  State<ParticipantFormScreen> createState() => _ParticipantFormScreenState();
}

class _ParticipantFormScreenState extends State<ParticipantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _jobController;
  late final TextEditingController _educationController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<AppState>().profileFor(widget.slot);
    _nameController = TextEditingController(text: profile?.name ?? '');
    _ageController = TextEditingController(
      text: profile?.age == null || profile!.age == 0 ? '' : '${profile.age}',
    );
    _jobController = TextEditingController(text: profile?.job ?? '');
    _educationController = TextEditingController(
      text: profile?.education ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _jobController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.slot == ParticipantSlot.userA
        ? context.tr('userA')
        : context.tr('userB');

    return AppPage(
      title: title,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SectionCard(
              title: title,
              icon: Icons.person_outline,
              child: Column(
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: context.tr('name'),
                    validator: _required,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _ageController,
                    label: context.tr('age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final age = int.tryParse(value ?? '');
                      if (age == null || age < 18) {
                        return context.tr('invalidAge');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _jobController,
                    label: context.tr('job'),
                    validator: _required,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _educationController,
                    label: context.tr('education'),
                    validator: _required,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check_rounded),
              label: Text(context.tr('saveContinue')),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.tr('fieldRequired');
    }
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final appState = context.read<AppState>();
    final existing =
        appState.profileFor(widget.slot) ?? ParticipantProfile.empty();
    final profile = existing.copyWith(
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      job: _jobController.text.trim(),
      education: _educationController.text.trim(),
    );
    await appState.saveProfile(widget.slot, profile);
    if (!mounted) return;

    final nextRoute = widget.slot == ParticipantSlot.userA
        ? AppRoutes.userBForm
        : AppRoutes.personalityTest;
    Navigator.pushNamed(context, nextRoute);
  }
}
