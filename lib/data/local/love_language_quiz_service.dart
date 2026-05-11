import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/love_language_quiz_result.dart';

class LoveLanguageQuizService {
  const LoveLanguageQuizService();

  static const _resultKey = 'love_language_quiz_result';

  Future<LoveLanguageQuizResult?> readResult() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_resultKey);
    if (raw == null || raw.isEmpty) return null;

    return LoveLanguageQuizResult.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  Future<void> saveResult(LoveLanguageQuizResult result) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_resultKey, jsonEncode(result.toJson()));
  }
}
