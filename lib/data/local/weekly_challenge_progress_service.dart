import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/weekly_challenge_progress.dart';

class WeeklyChallengeProgressService {
  const WeeklyChallengeProgressService();

  static const _progressKey = 'weekly_challenge_progress';

  Future<WeeklyChallengeProgress?> readProgress() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_progressKey);
    if (raw == null || raw.isEmpty) return null;

    return WeeklyChallengeProgress.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  Future<void> saveProgress(WeeklyChallengeProgress progress) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_progressKey, jsonEncode(progress.toJson()));
  }
}
