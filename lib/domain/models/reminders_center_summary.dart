class RemindersCenterSummary {
  const RemindersCenterSummary({
    required this.totalEntries,
    required this.entriesThisMonth,
    required this.usedCategoriesCount,
    required this.topCategory,
  });

  final int totalEntries;
  final int entriesThisMonth;
  final int usedCategoriesCount;
  final String? topCategory;
}
