import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/reminders_center_service.dart';
import '../../../domain/models/reminder_entry.dart';

class RemindersCenterScreen extends StatefulWidget {
  const RemindersCenterScreen({
    super.key,
    this.service = const RemindersCenterService(),
  });

  final RemindersCenterService service;

  @override
  State<RemindersCenterScreen> createState() => _RemindersCenterScreenState();
}

class _RemindersCenterScreenState extends State<RemindersCenterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _scheduleController = TextEditingController();
  final _noteController = TextEditingController();

  List<ReminderEntry> _entries = const [];
  String _category = 'checkIn';
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _scheduleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadEntries() async {
    final entries = await widget.service.readEntries();
    if (!mounted) return;
    setState(() {
      _entries = entries;
      _isLoading = false;
    });
  }

  Future<void> _saveEntry() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final updated = await widget.service.addEntry(
      title: _titleController.text,
      scheduleLabel: _scheduleController.text,
      category: _category,
      note: _noteController.text,
    );
    if (!mounted) return;

    _titleController.clear();
    _scheduleController.clear();
    _noteController.clear();
    setState(() {
      _entries = updated;
      _category = 'checkIn';
      _isSaving = false;
    });
  }

  Future<void> _deleteEntry(String id) async {
    final updated = await widget.service.deleteEntry(id);
    if (!mounted) return;
    setState(() => _entries = updated);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.tr('remindersCenter'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('remindersCenterIntroTitle'),
            icon: Icons.notifications_none_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr('remindersCenterIntroBody')),
                const SizedBox(height: 10),
                Text(
                  context.tr('remindersCenterLocalOnlyNote'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('remindersCenterAddTitle'),
            icon: Icons.add_alert_rounded,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: context.tr('reminderTitle'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: InputDecoration(
                      labelText: context.tr('reminderCategory'),
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'checkIn',
                        child: Text(context.tr('reminderCategoryCheckIn')),
                      ),
                      DropdownMenuItem(
                        value: 'gratitude',
                        child: Text(context.tr('reminderCategoryGratitude')),
                      ),
                      DropdownMenuItem(
                        value: 'budget',
                        child: Text(context.tr('reminderCategoryBudget')),
                      ),
                      DropdownMenuItem(
                        value: 'custom',
                        child: Text(context.tr('reminderCategoryCustom')),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _category = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _scheduleController,
                    decoration: InputDecoration(
                      labelText: context.tr('reminderScheduleLabel'),
                      hintText: context.tr('reminderScheduleHint'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _noteController,
                    minLines: 2,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: context.tr('reminderNote'),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isSaving ? null : _saveEntry,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save_outlined),
                      label: Text(context.tr('reminderSaveAction')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('remindersCenterSavedTitle'),
            icon: Icons.notifications_active_outlined,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _entries.isEmpty
                ? Text(context.tr('remindersCenterEmpty'))
                : Column(
                    children: [
                      for (var i = 0; i < _entries.length; i++) ...[
                        _ReminderEntryCard(
                          entry: _entries[i],
                          onDelete: () => _deleteEntry(_entries[i].id),
                        ),
                        if (i != _entries.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _ReminderEntryCard extends StatelessWidget {
  const _ReminderEntryCard({required this.entry, required this.onDelete});

  final ReminderEntry entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_categoryLabel(context, entry.category)} • ${entry.scheduleLabel}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
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
          if (entry.note.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              entry.note,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            _formatDate(entry.createdAtIso),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _categoryLabel(BuildContext context, String category) {
    return switch (category) {
      'checkIn' => context.tr('reminderCategoryCheckIn'),
      'gratitude' => context.tr('reminderCategoryGratitude'),
      'budget' => context.tr('reminderCategoryBudget'),
      _ => context.tr('reminderCategoryCustom'),
    };
  }

  String _formatDate(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final day = parsed.day.toString().padLeft(2, '0');
    final month = parsed.month.toString().padLeft(2, '0');
    return '$day/$month/${parsed.year}';
  }
}
