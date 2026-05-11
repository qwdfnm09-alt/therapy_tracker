class ReminderEntry {
  const ReminderEntry({
    required this.id,
    required this.title,
    required this.scheduleLabel,
    required this.category,
    required this.note,
    required this.createdAtIso,
    this.scheduleType,
    this.scheduledHour,
    this.scheduledMinute,
    this.scheduledWeekday,
    this.notificationId,
  });

  final String id;
  final String title;
  final String scheduleLabel;
  final String category;
  final String note;
  final String createdAtIso;
  final String? scheduleType;
  final int? scheduledHour;
  final int? scheduledMinute;
  final int? scheduledWeekday;
  final int? notificationId;

  ReminderEntry copyWith({
    String? id,
    String? title,
    String? scheduleLabel,
    String? category,
    String? note,
    String? createdAtIso,
    String? scheduleType,
    int? scheduledHour,
    int? scheduledMinute,
    int? scheduledWeekday,
    int? notificationId,
    bool clearScheduleType = false,
    bool clearScheduledHour = false,
    bool clearScheduledMinute = false,
    bool clearScheduledWeekday = false,
    bool clearNotificationId = false,
  }) {
    return ReminderEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      scheduleLabel: scheduleLabel ?? this.scheduleLabel,
      category: category ?? this.category,
      note: note ?? this.note,
      createdAtIso: createdAtIso ?? this.createdAtIso,
      scheduleType: clearScheduleType
          ? null
          : scheduleType ?? this.scheduleType,
      scheduledHour: clearScheduledHour
          ? null
          : scheduledHour ?? this.scheduledHour,
      scheduledMinute: clearScheduledMinute
          ? null
          : scheduledMinute ?? this.scheduledMinute,
      scheduledWeekday: clearScheduledWeekday
          ? null
          : scheduledWeekday ?? this.scheduledWeekday,
      notificationId: clearNotificationId
          ? null
          : notificationId ?? this.notificationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'scheduleLabel': scheduleLabel,
      'category': category,
      'note': note,
      'createdAtIso': createdAtIso,
      'scheduleType': scheduleType,
      'scheduledHour': scheduledHour,
      'scheduledMinute': scheduledMinute,
      'scheduledWeekday': scheduledWeekday,
      'notificationId': notificationId,
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
      scheduleType: json['scheduleType']?.toString(),
      scheduledHour: (json['scheduledHour'] as num?)?.toInt(),
      scheduledMinute: (json['scheduledMinute'] as num?)?.toInt(),
      scheduledWeekday: (json['scheduledWeekday'] as num?)?.toInt(),
      notificationId: (json['notificationId'] as num?)?.toInt(),
    );
  }
}
