import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/gratitude_bank_service.dart';
import '../../../domain/models/gratitude_note.dart';

class GratitudeBankScreen extends StatefulWidget {
  const GratitudeBankScreen({
    super.key,
    this.service = const GratitudeBankService(),
  });

  final GratitudeBankService service;

  @override
  State<GratitudeBankScreen> createState() => _GratitudeBankScreenState();
}

class _GratitudeBankScreenState extends State<GratitudeBankScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<GratitudeNote> _notes = const [];
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    final notes = await widget.service.readNotes();
    if (!mounted) return;
    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final updated = await widget.service.addNote(_controller.text);
    if (!mounted) return;
    _controller.clear();
    setState(() {
      _notes = updated;
      _isSaving = false;
    });
  }

  Future<void> _deleteNote(String id) async {
    final updated = await widget.service.deleteNote(id);
    if (!mounted) return;
    setState(() => _notes = updated);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage(
      title: context.tr('gratitudeBank'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('gratitudeBankIntroTitle'),
            icon: Icons.favorite_outline_rounded,
            child: Text(context.tr('gratitudeBankIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('gratitudeBankAddTitle'),
            icon: Icons.edit_note_rounded,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('gratitudeBankPrompt'),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _controller,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: context.tr('gratitudeBankHint'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      if (value.trim().length < 6) {
                        return context.tr('gratitudeBankTooShort');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isSaving ? null : _saveNote,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.add_comment_outlined),
                      label: Text(context.tr('gratitudeBankSaveAction')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('gratitudeBankSavedTitle'),
            icon: Icons.bookmark_border_rounded,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _notes.isEmpty
                ? Text(context.tr('gratitudeBankEmpty'))
                : Column(
                    children: [
                      for (var i = 0; i < _notes.length; i++) ...[
                        _NoteCard(
                          note: _notes[i],
                          onDelete: () => _deleteNote(_notes[i].id),
                        ),
                        if (i != _notes.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.onDelete});

  final GratitudeNote note;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  note.text,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                tooltip: context.tr('delete'),
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _formatDate(note.createdAtIso),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final day = parsed.day.toString().padLeft(2, '0');
    final month = parsed.month.toString().padLeft(2, '0');
    return '$day/$month/${parsed.year}';
  }
}
