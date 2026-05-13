import 'package:flutter/material.dart';

import '../../../core/config/connected_feature_dependency_container.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/form_text_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/problem_box_submission.dart';
import '../../../domain/services/booking_submission_service.dart';
import '../../../domain/use_cases/submit_problem_box_use_case.dart';

class AnonymousProblemBoxScreen extends StatefulWidget {
  const AnonymousProblemBoxScreen({
    super.key,
    this.submitProblemBoxUseCase,
    this.submissionService = const BookingSubmissionService(),
  });

  final SubmitProblemBoxUseCase? submitProblemBoxUseCase;
  final BookingSubmissionService submissionService;

  @override
  State<AnonymousProblemBoxScreen> createState() =>
      _AnonymousProblemBoxScreenState();
}

class _AnonymousProblemBoxScreenState extends State<AnonymousProblemBoxScreen> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  final _detailsController = TextEditingController();
  late final SubmitProblemBoxUseCase _submitUseCase;
  String? _statusMessageKey;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final container = ConnectedFeatureDependencyContainer.forCurrentMode();
    _submitUseCase =
        widget.submitProblemBoxUseCase ??
        SubmitProblemBoxUseCase(container.problemBoxSubmissions);
  }

  @override
  void dispose() {
    _topicController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final result = await _submitUseCase.execute(
        ProblemBoxSubmission(
          topic: _topicController.text.trim(),
          details: _detailsController.text.trim(),
          createdAtIso: DateTime.now().toIso8601String(),
        ),
      );
      if (!mounted) return;
      setState(() => _statusMessageKey = result.message);
      if (result.submitted) {
        _topicController.clear();
        _detailsController.clear();
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _statusMessageKey = 'problemBoxSubmitFailed');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _openWhatsApp() async {
    if (!_formKey.currentState!.validate()) return;
    final opened = await widget.submissionService.openWhatsApp(
      _buildProblemBoxMessage(),
    );
    if (!mounted) return;
    if (opened) {
      setState(() => _statusMessageKey = 'problemBoxWhatsappOpened');
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.tr('bookingActionFailed'))));
  }

  String _buildProblemBoxMessage() {
    return [
      'Private problem box submission',
      '',
      'Topic: ${_topicController.text.trim()}',
      '',
      'Details:',
      _detailsController.text.trim(),
    ].join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.tr('problemBox'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('problemBoxIntroTitle'),
            icon: Icons.mark_unread_chat_alt_outlined,
            child: Text(context.tr('problemBoxIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('problemBox'),
            icon: Icons.edit_note_outlined,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    controller: _topicController,
                    label: context.tr('problemBoxTopic'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _detailsController,
                    label: context.tr('problemBoxDetails'),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      if (value.trim().length < 10) {
                        return context.tr('problemBoxTooShort');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isSubmitting ? null : _submit,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send_outlined),
                      label: Text(context.tr('problemBoxSubmit')),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _isSubmitting ? null : _openWhatsApp,
                      icon: const Icon(Icons.chat_outlined),
                      label: Text(context.tr('openWhatsapp')),
                    ),
                  ),
                  if (_statusMessageKey != null) ...[
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(context.tr(_statusMessageKey!)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
