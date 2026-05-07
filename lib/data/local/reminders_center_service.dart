import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/reminder_entry.dart';

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

  Future<List<ReminderEntry>> addEntry({
    required String title,
    required String scheduleLabel,
    required String category,
    required String note,
  }) async {
    final current = await readEntries();
    final entry = ReminderEntry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      scheduleLabel: scheduleLabel.trim(),
      category: category,
      note: note.trim(),
      createdAtIso: DateTime.now().toIso8601String(),
    );
    final updated = [entry, ...current];
    await saveEntries(updated);
    return updated;
  }

  Future<List<ReminderEntry>> deleteEntry(String id) async {
    final current = await readEntries();
    final updated = current.where((entry) => entry.id != id).toList();
    await saveEntries(updated);
    return updated;
  }
}
