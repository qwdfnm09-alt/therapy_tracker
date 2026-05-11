import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/reminder_entry.dart';
import '../../domain/models/reminders_center_summary.dart';

class RemindersCenterService {
  const RemindersCenterService();

  static const _entriesKey = 'reminders_center_entries';

  Future<List<ReminderEntry>> readEntries() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_entriesKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => ReminderEntry.fromJson(item as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAtIso.compareTo(a.createdAtIso));
  }

  Future<void> saveEntries(List<ReminderEntry> entries) async {
    final preferences = await SharedPreferences.getInstance();
    final payload = entries.map((entry) => entry.toJson()).toList();
    await preferences.setString(_entriesKey, jsonEncode(payload));
  }

  Future<List<ReminderEntry>> saveEntry(ReminderEntry entry) async {
    final current = await readEntries();
    final updated = [entry, ...current];
    await saveEntries(updated);
    return updated;
  }

  Future<List<ReminderEntry>> addEntry({
    required String title,
    required String scheduleLabel,
    required String category,
    required String note,
    String? scheduleType,
    int? scheduledHour,
    int? scheduledMinute,
    int? scheduledWeekday,
    int? notificationId,
  }) async {
    final entry = ReminderEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      scheduleLabel: scheduleLabel.trim(),
      category: category,
      note: note.trim(),
      createdAtIso: DateTime.now().toIso8601String(),
      scheduleType: scheduleType,
      scheduledHour: scheduledHour,
      scheduledMinute: scheduledMinute,
      scheduledWeekday: scheduledWeekday,
      notificationId: notificationId,
    );
    return saveEntry(entry);
  }

  Future<List<ReminderEntry>> deleteEntry(String id) async {
    final current = await readEntries();
    final updated = current.where((entry) => entry.id != id).toList();
    await saveEntries(updated);
    return updated;
  }

  RemindersCenterSummary buildSummary(
    List<ReminderEntry> entries, {
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final entriesThisMonth = entries.where((entry) {
      final parsed = DateTime.tryParse(entry.createdAtIso);
      if (parsed == null) return false;
      return parsed.year == reference.year && parsed.month == reference.month;
    }).length;

    final categoryCounts = <String, int>{};
    for (final entry in entries) {
      categoryCounts.update(
        entry.category,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    String? topCategory;
    int topCount = 0;
    for (final item in categoryCounts.entries) {
      if (item.value > topCount) {
        topCategory = item.key;
        topCount = item.value;
      }
    }

    return RemindersCenterSummary(
      totalEntries: entries.length,
      entriesThisMonth: entriesThisMonth,
      usedCategoriesCount: categoryCounts.length,
      topCategory: topCategory,
    );
  }
}
