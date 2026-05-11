import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/budget_planner_service.dart';
import '../../../domain/models/budget_entry.dart';
import '../../../domain/models/budget_planner_summary.dart';

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
  final _summarySectionKey = GlobalKey();
  final _addSectionKey = GlobalKey();
  final _entriesSectionKey = GlobalKey();
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
    final summary = widget.service.buildSummary(_entries);
    final incomeTotal = summary.incomeTotal;
    final expenseTotal = summary.expenseTotal;
    final balance = summary.balance;

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
            title: context.tr('budgetPlannerOverviewTitle'),
            icon: Icons.insights_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('budgetPlannerOverviewBody'),
                  style: Theme.of(context).textTheme.bodySmall,
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
                        mainAxisExtent: useSingleColumn ? 116 : 132,
                      ),
                      children: [
                        _OverviewCard(
                          label: context.tr('budgetPlannerSummaryTitle'),
                          value: _formatMoney(balance),
                          helper: context.tr(
                            'budgetPlannerOverviewSummaryHelper',
                          ),
                          icon: Icons.pie_chart_outline_rounded,
                          color: balance >= 0 ? Colors.indigo : Colors.orange,
                          onTap: () => _scrollToSection(
                            _summarySectionKey.currentContext,
                          ),
                        ),
                        _OverviewCard(
                          label: context.tr('budgetPlannerAddTitle'),
                          value: '+',
                          helper: context.tr(
                            'budgetPlannerOverviewActionHelper',
                          ),
                          icon: Icons.add_card_rounded,
                          color: Colors.teal,
                          onTap: () =>
                              _scrollToSection(_addSectionKey.currentContext),
                        ),
                        _OverviewCard(
                          label: context.tr('budgetPlannerEntriesTitle'),
                          value: _entries.length.toString(),
                          helper: context.tr(
                            'budgetPlannerOverviewEntriesHelper',
                          ),
                          icon: Icons.receipt_long_outlined,
                          color: Colors.pink,
                          onTap: () => _scrollToSection(
                            _entriesSectionKey.currentContext,
                          ),
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
                    color: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('budgetPlannerOverviewLatestTitle'),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _entries.isEmpty
                            ? context.tr('toolsOverviewNoData')
                            : _buildLatestEntryPreview(context, _entries.first),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            key: _summarySectionKey,
            title: context.tr('budgetPlannerSummaryTitle'),
            icon: Icons.pie_chart_outline_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BudgetPlannerSmartSummaryCard(
                  summary: summary,
                  formatMoney: _formatMoney,
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
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
                            if (i != cards.length - 1)
                              const SizedBox(height: 12),
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            key: _addSectionKey,
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
            key: _entriesSectionKey,
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

  String _buildLatestEntryPreview(BuildContext context, BudgetEntry entry) {
    final typeLabel = entry.type == 'income'
        ? context.tr('budgetIncome')
        : context.tr('budgetExpense');
    return '${entry.title} • ${entry.category} • $typeLabel • ${entry.amount.toStringAsFixed(2)}';
  }
}

class _BudgetPlannerSmartSummaryCard extends StatelessWidget {
  const _BudgetPlannerSmartSummaryCard({
    required this.summary,
    required this.formatMoney,
  });

  final BudgetPlannerSummary summary;
  final String Function(double value) formatMoney;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('budgetPlannerSmartSummaryTitle'),
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          context.tr('budgetPlannerSmartSummaryBody'),
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
                mainAxisExtent: useSingleColumn ? 88 : 106,
              ),
              children: [
                _SummaryCard(
                  title: context.tr('budgetPlannerSmartSummaryMonthLabel'),
                  value: summary.entriesThisMonth.toString(),
                  color: Colors.indigo,
                ),
                _SummaryCard(
                  title: context.tr(
                    'budgetPlannerSmartSummaryTopCategoryLabel',
                  ),
                  value:
                      summary.topExpenseCategory ??
                      context.tr('budgetPlannerSmartSummaryNoCategory'),
                  color: Colors.orange,
                ),
                _SummaryCard(
                  title: context.tr('budgetPlannerSmartSummaryTopAmountLabel'),
                  value: formatMoney(summary.topExpenseAmount),
                  color: Colors.pink,
                ),
              ],
            );
          },
        ),
      ],
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
    final theme = Theme.of(context);
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
          Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
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
