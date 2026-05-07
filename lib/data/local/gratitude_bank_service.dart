import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/gratitude_note.dart';

class GratitudeBankService {
  const GratitudeBankService();

  static const _notesKey = 'gratitude_bank_notes';

  Future<List<GratitudeNote>> readNotes() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_notesKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => GratitudeNote.fromJson(item as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAtIso.compareTo(a.createdAtIso));
  }

  Future<void> saveNotes(List<GratitudeNote> notes) async {
    final preferences = await SharedPreferences.getInstance();
    final payload = notes.map((note) => note.toJson()).toList();
    await preferences.setString(_notesKey, jsonEncode(payload));
  }

  Future<List<GratitudeNote>> addNote(String text) async {
    final current = await readNotes();
    final note = GratitudeNote(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text.trim(),
      createdAtIso: DateTime.now().toIso8601String(),
    );
    final updated = [note, ...current];
    await saveNotes(updated);
    return updated;
  }

  Future<List<GratitudeNote>> deleteNote(String id) async {
    final current = await readNotes();
    final updated = current.where((note) => note.id != id).toList();
    await saveNotes(updated);
    return updated;
  }
}
