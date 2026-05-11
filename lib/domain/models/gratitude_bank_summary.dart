class GratitudeBankSummary {
  const GratitudeBankSummary({
    required this.totalNotes,
    required this.notesThisMonth,
    required this.latestCreatedAtIso,
  });

  final int totalNotes;
  final int notesThisMonth;
  final String? latestCreatedAtIso;
}
