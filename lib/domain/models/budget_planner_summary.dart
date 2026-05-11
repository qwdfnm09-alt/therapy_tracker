class BudgetPlannerSummary {
  const BudgetPlannerSummary({
    required this.incomeTotal,
    required this.expenseTotal,
    required this.balance,
    required this.entriesThisMonth,
    required this.topExpenseCategory,
    required this.topExpenseAmount,
  });

  final double incomeTotal;
  final double expenseTotal;
  final double balance;
  final int entriesThisMonth;
  final String? topExpenseCategory;
  final double topExpenseAmount;
}
