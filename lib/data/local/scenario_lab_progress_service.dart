import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ScenarioLabProgressService {
  const ScenarioLabProgressService();

  static const _progressKey = 'scenario_lab_progress';

  Future<ScenarioLabProgress> readProgress() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_progressKey);
    if (raw == null || raw.isEmpty) {
      return const ScenarioLabProgress.empty();
    }

    final json = jsonDecode(raw) as Map<String, dynamic>;
    return ScenarioLabProgress.fromJson(json);
  }

  Future<void> saveProgress(ScenarioLabProgress progress) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_progressKey, jsonEncode(progress.toJson()));
  }
}

class ScenarioLabProgress {
  const ScenarioLabProgress({
    required this.userAAnswers,
    required this.userBAnswers,
  });

  const ScenarioLabProgress.empty()
    : userAAnswers = const {},
      userBAnswers = const {};

  final Map<String, String> userAAnswers;
  final Map<String, String> userBAnswers;

  factory ScenarioLabProgress.fromJson(Map<String, dynamic> json) {
    return ScenarioLabProgress(
      userAAnswers: Map<String, String>.from(
        json['userAAnswers'] as Map? ?? {},
      ),
      userBAnswers: Map<String, String>.from(
        json['userBAnswers'] as Map? ?? {},
      ),
    );
  }

  ScenarioLabProgress copyWith({
    Map<String, String>? userAAnswers,
    Map<String, String>? userBAnswers,
  }) {
    return ScenarioLabProgress(
      userAAnswers: userAAnswers ?? this.userAAnswers,
      userBAnswers: userBAnswers ?? this.userBAnswers,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userAAnswers': userAAnswers, 'userBAnswers': userBAnswers};
  }
}
