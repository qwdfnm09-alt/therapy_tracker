import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/budget_entry.dart';
import '../../domain/models/budget_planner_summary.dart';

class BudgetPlannerService {
  const BudgetPlannerService();

  static const _entriesKey = 'budget_planner_entries';

  Future<List<BudgetEntry>> readEntries() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_entriesKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => BudgetEntry.fromJson(item as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAtIso.compareTo(a.createdAtIso));
  }

  Future<void> saveEntries(List<BudgetEntry> entries) async {
    final preferences = await SharedPreferences.getInstance();
    final payload = entries.map((entry) => entry.toJson()).toList();
    await preferences.setString(_entriesKey, jsonEncode(payload));
  }

  Future<List<BudgetEntry>> addEntry({
    required String title,
    required double amount,
    required String type,
    required String category,
  }) async {
    final current = await readEntries();
    final entry = BudgetEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      amount: amount,
      type: type,
      category: category.trim(),
      createdAtIso: DateTime.now().toIso8601String(),
    );
    final updated = [entry, ...current];
    await saveEntries(updated);
    return updated;
  }

  Future<List<BudgetEntry>> deleteEntry(String id) async {
    final current = await readEntries();
    final updated = current.where((entry) => entry.id != id).toList();
    await saveEntries(updated);
    return updated;
  }

  BudgetPlannerSummary buildSummary(
    List<BudgetEntry> entries, {
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final incomeTotal = entries
        .where((entry) => entry.type == 'income')
        .fold<double>(0, (sum, entry) => sum + entry.amount);
    final expenseTotal = entries
        .where((entry) => entry.type == 'expense')
        .fold<double>(0, (sum, entry) => sum + entry.amount);

    final entriesThisMonth = entries.where((entry) {
      final parsed = DateTime.tryParse(entry.createdAtIso);
      if (parsed == null) return false;
      return parsed.year == reference.year && parsed.month == reference.month;
    }).length;

    final expenseByCategory = <String, double>{};
    for (final entry in entries.where((item) => item.type == 'expense')) {
      expenseByCategory.update(
        entry.category,
        (value) => value + entry.amount,
        ifAbsent: () => entry.amount,
      );
    }

    String? topExpenseCategory;
    double topExpenseAmount = 0;
    for (final item in expenseByCategory.entries) {
      if (item.value > topExpenseAmount) {
        topExpenseCategory = item.key;
        topExpenseAmount = item.value;
      }
    }

    return BudgetPlannerSummary(
      incomeTotal: incomeTotal,
      expenseTotal: expenseTotal,
      balance: incomeTotal - expenseTotal,
      entriesThisMonth: entriesThisMonth,
      topExpenseCategory: topExpenseCategory,
      topExpenseAmount: topExpenseAmount,
    );
  }
}
