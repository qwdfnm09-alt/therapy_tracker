class ReminderEntry {
  const ReminderEntry({
    required this.id,
    required this.title,
    required this.scheduleLabel,
    required this.category,
    required this.note,
    required this.createdAtIso,
  });

  final String id;
  final String title;
  final String scheduleLabel;
  final String category;
  final String note;
  final String createdAtIso;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'scheduleLabel': scheduleLabel,
      'category': category,
      'note': note,
      'createdAtIso': createdAtIso,
    };
  }

  factory ReminderEntry.fromJson(Map<String, dynamic> json) {
    return ReminderEntry(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      scheduleLabel: json['scheduleLabel']?.toString() ?? '',
      category: json['category']?.toString() ?? 'custom',
      note: json['note']?.toString() ?? '',
      createdAtIso: json['createdAtIso']?.toString() ?? '',
    );
  }
}
