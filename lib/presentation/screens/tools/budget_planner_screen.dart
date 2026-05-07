import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/budget_planner_service.dart';
import '../../../domain/models/budget_entry.dart';

class BudgetPlannerScreen extends StatefulWidget {
  const BudgetPlannerScreen({
    super.key,
    this.service = const BudgetPlannerService(),
  });

  final BudgetPlannerService service;

  @override
  State<BudgetPlannerScreen> createState() => _BudgetPlannerScreenState();
}

class _BudgetPlannerScreenState extends State<BudgetPlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();

  List<BudgetEntry> _entries = const [];
  String _type = 'expense';
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
    _amountController.dispose();
    _categoryController.dispose();
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

    final amount = double.parse(_amountController.text.trim());
    setState(() => _isSaving = true);

    final updated = await widget.service.addEntry(
      title: _titleController.text,
      amount: amount,
      type: _type,
      category: _categoryController.text,
    );

    if (!mounted) return;
    _titleController.clear();
    _amountController.clear();
    _categoryController.clear();
    setState(() {
      _entries = updated;
      _type = 'expense';
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
    final incomeTotal = _entries
        .where((entry) => entry.type == 'income')
        .fold<double>(0, (sum, entry) => sum + entry.amount);
    final expenseTotal = _entries
        .where((entry) => entry.type == 'expense')
        .fold<double>(0, (sum, entry) => sum + entry.amount);
    final balance = incomeTotal - expenseTotal;

    return AppPage(
      title: context.tr('budgetPlanner'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('budgetPlannerIntroTitle'),
            icon: Icons.account_balance_wallet_outlined,
            child: Text(context.tr('budgetPlannerIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('budgetPlannerSummaryTitle'),
            icon: Icons.pie_chart_outline_rounded,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 460;
                final cards = [
                  _SummaryCard(
                    title: context.tr('budgetIncome'),
                    value: _formatMoney(incomeTotal),
                    color: Colors.teal,
                  ),
                  _SummaryCard(
                    title: context.tr('budgetExpense'),
                    value: _formatMoney(expenseTotal),
                    color: Colors.redAccent,
                  ),
                  _SummaryCard(
                    title: context.tr('budgetBalance'),
                    value: _formatMoney(balance),
                    color: balance >= 0 ? Colors.indigo : Colors.orange,
                  ),
                ];

                if (stacked) {
                  return Column(
                    children: [
                      for (var i = 0; i < cards.length; i++) ...[
                        cards[i],
                        if (i != cards.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                  );
                }

                return Row(
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      Expanded(child: cards[i]),
                      if (i != cards.length - 1) const SizedBox(width: 12),
                    ],
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('budgetPlannerAddTitle'),
            icon: Icons.add_card_rounded,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: context.tr('budgetTitle'),
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
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: context.tr('budgetAmount'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      final parsed = double.tryParse(value.trim());
                      if (parsed == null || parsed <= 0) {
                        return context.tr('budgetAmountInvalid');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _type,
                    decoration: InputDecoration(
                      labelText: context.tr('budgetType'),
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'expense',
                        child: Text(context.tr('budgetExpense')),
                      ),
                      DropdownMenuItem(
                        value: 'income',
                        child: Text(context.tr('budgetIncome')),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _type = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      labelText: context.tr('budgetCategory'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('fieldRequired');
                      }
                      return null;
                    },
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
                      label: Text(context.tr('budgetSaveAction')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('budgetPlannerEntriesTitle'),
            icon: Icons.receipt_long_outlined,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _entries.isEmpty
                ? Text(context.tr('budgetPlannerEmpty'))
                : Column(
                    children: [
                      for (var i = 0; i < _entries.length; i++) ...[
                        _BudgetEntryCard(
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

  String _formatMoney(double value) {
    final whole = value.toStringAsFixed(2);
    return whole;
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetEntryCard extends StatelessWidget {
  const _BudgetEntryCard({required this.entry, required this.onDelete});

  final BudgetEntry entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = entry.type == 'income' ? Colors.teal : Colors.redAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.14)),
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
                      '${entry.category} • ${entry.type == 'income' ? context.tr('budgetIncome') : context.tr('budgetExpense')}',
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
          const SizedBox(height: 10),
          Text(
            entry.amount.toStringAsFixed(2),
            style: theme.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
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

  String _formatDate(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final day = parsed.day.toString().padLeft(2, '0');
    final month = parsed.month.toString().padLeft(2, '0');
    return '$day/$month/${parsed.year}';
  }
}
