import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/gratitude_bank_service.dart';
import '../../../domain/models/gratitude_bank_summary.dart';
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
    final addSectionKey = GlobalKey();
    final savedSectionKey = GlobalKey();
    final summary = widget.service.buildSummary(_notes);

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
            title: context.tr('gratitudeBankOverviewTitle'),
            icon: Icons.insights_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('gratitudeBankOverviewBody'),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final useSingleColumn = constraints.maxWidth < 430;
                    return GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: useSingleColumn ? 1 : 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: useSingleColumn ? 100 : 116,
                      ),
                      children: [
                        _OverviewCard(
                          label: context.tr('gratitudeBankSavedTitle'),
                          value: _notes.length.toString(),
                          helper: context.tr('toolsOverviewSavedItems'),
                          icon: Icons.bookmark_border_rounded,
                          color: Colors.pink,
                          onTap: () =>
                              _scrollToSection(savedSectionKey.currentContext),
                        ),
                        _OverviewCard(
                          label: context.tr('gratitudeBankAddTitle'),
                          value: _notes.isEmpty ? '0' : '1',
                          helper: context.tr(
                            'gratitudeBankOverviewActionHelper',
                          ),
                          icon: Icons.edit_note_rounded,
                          color: Colors.teal,
                          onTap: () =>
                              _scrollToSection(addSectionKey.currentContext),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('gratitudeBankOverviewLatestTitle'),
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _notes.isEmpty
                            ? context.tr('toolsOverviewNoData')
                            : _notes.first.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('gratitudeBankSummaryTitle'),
            icon: Icons.calendar_month_outlined,
            child: _GratitudeSummaryCard(summary: summary),
          ),
          const SizedBox(height: 16),
          SectionCard(
            key: addSectionKey,
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
            key: savedSectionKey,
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

void _scrollToSection(BuildContext? sectionContext) {
  if (sectionContext == null) return;
  Scrollable.ensureVisible(
    sectionContext,
    duration: const Duration(milliseconds: 280),
    curve: Curves.easeOutCubic,
    alignment: 0.08,
  );
}

class _GratitudeSummaryCard extends StatelessWidget {
  const _GratitudeSummaryCard({required this.summary});

  final GratitudeBankSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('gratitudeBankSummaryBody'),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final useSingleColumn = constraints.maxWidth < 430;
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: useSingleColumn ? 1 : 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: useSingleColumn ? 86 : 104,
              ),
              children: [
                _SummaryMetricCard(
                  label: context.tr('gratitudeBankSummaryTotalLabel'),
                  value: summary.totalNotes.toString(),
                  color: Colors.pink,
                ),
                _SummaryMetricCard(
                  label: context.tr('gratitudeBankSummaryMonthLabel'),
                  value: summary.notesThisMonth.toString(),
                  color: Colors.teal,
                ),
                _SummaryMetricCard(
                  label: context.tr('gratitudeBankSummaryLatestLabel'),
                  value: summary.latestCreatedAtIso == null
                      ? context.tr('gratitudeBankSummaryNoDate')
                      : _formatDate(summary.latestCreatedAtIso!),
                  color: Colors.indigo,
                ),
              ],
            );
          },
        ),
      ],
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

class _SummaryMetricCard extends StatelessWidget {
  const _SummaryMetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.label,
    required this.value,
    required this.helper,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String value;
  final String helper;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const Spacer(),
                  Text(
                    value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      helper,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_downward_rounded, size: 15, color: color),
                ],
              ),
            ],
          ),
        ),
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
