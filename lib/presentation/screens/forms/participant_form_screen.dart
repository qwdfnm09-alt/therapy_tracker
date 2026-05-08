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
  bool _submitted = false;
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
    for (final controller in [
      _nameController,
      _ageController,
      _jobController,
      _educationController,
    ]) {
      controller.addListener(_refreshProgress);
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _nameController,
      _ageController,
      _jobController,
      _educationController,
    ]) {
      controller.removeListener(_refreshProgress);
    }
    _nameController.dispose();
    _ageController.dispose();
    _jobController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = widget.slot == ParticipantSlot.userA
        ? context.tr('userA')
        : context.tr('userB');
    final completedFields = _completedFieldsCount;
    final completionRatio = completedFields / 4;
    final nextStepLabel = widget.slot == ParticipantSlot.userA
        ? context.tr('profileNextUserB')
        : context.tr('profileNextTest');

    return AppPage(
      title: title,
      child: Form(
        key: _formKey,
        autovalidateMode: _submitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primaryContainer.withBlue(205),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('profileSetupTitle'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr('profileSetupBody'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _FormInfoChip(icon: Icons.person_outline, label: title),
                      _FormInfoChip(
                        icon: Icons.trending_up_rounded,
                        label: _completionLabel(context, completedFields, 4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: context.tr('profileProgress'),
              icon: Icons.rule_folder_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _completionLabel(context, completedFields, 4),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: completionRatio),
                  const SizedBox(height: 12),
                  Text(
                    completedFields == 4
                        ? context.tr('profileReady')
                        : context.tr('profileNeedsMore'),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    nextStepLabel,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: context.tr('identitySection'),
              icon: Icons.badge_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('identitySectionBody'),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _nameController,
                    label: context.tr('name'),
                    hintText: context.tr('nameHint'),
                    prefixIcon: Icons.person_outline_rounded,
                    textInputAction: TextInputAction.next,
                    validator: _required,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _ageController,
                    label: context.tr('age'),
                    hintText: context.tr('ageHint'),
                    prefixIcon: Icons.cake_outlined,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      final age = int.tryParse(value ?? '');
                      if (age == null || age < 18) {
                        return context.tr('invalidAge');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: context.tr('contextSection'),
              icon: Icons.layers_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('contextSectionBody'),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _jobController,
                    label: context.tr('job'),
                    hintText: context.tr('jobHint'),
                    prefixIcon: Icons.work_outline_rounded,
                    textInputAction: TextInputAction.next,
                    validator: _required,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _educationController,
                    label: context.tr('education'),
                    hintText: context.tr('educationHint'),
                    prefixIcon: Icons.school_outlined,
                    textInputAction: TextInputAction.done,
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

  void _refreshProgress() {
    if (mounted) {
      setState(() {});
    }
  }

  int get _completedFieldsCount {
    final values = [
      _nameController.text.trim(),
      _ageController.text.trim(),
      _jobController.text.trim(),
      _educationController.text.trim(),
    ];
    return values.where((value) => value.isNotEmpty).length;
  }

  String _completionLabel(BuildContext context, int current, int total) {
    return context
        .tr('profileCompleteFields')
        .replaceFirst('{current}', '$current')
        .replaceFirst('{total}', '$total');
  }

  Future<void> _save() async {
    setState(() {
      _submitted = true;
    });
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

class _FormInfoChip extends StatelessWidget {
  const _FormInfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
