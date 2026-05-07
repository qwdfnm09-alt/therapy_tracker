class BudgetEntry {
  const BudgetEntry({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.createdAtIso,
  });

  final String id;
  final String title;
  final double amount;
  final String type;
  final String category;
  final String createdAtIso;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'category': category,
      'createdAtIso': createdAtIso,
    };
  }

  factory BudgetEntry.fromJson(Map<String, dynamic> json) {
    return BudgetEntry(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      type: json['type']?.toString() ?? 'expense',
      category: json['category']?.toString() ?? '',
      createdAtIso: json['createdAtIso']?.toString() ?? '',
    );
  }
}
