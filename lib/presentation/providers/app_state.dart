import 'package:flutter/material.dart';

import '../../data/local/local_storage_service.dart';
import '../../domain/models/compatibility_result.dart';
import '../../domain/models/participant_profile.dart';
import '../../domain/services/compatibility_scoring_service.dart';

enum ParticipantSlot { userA, userB }

class AppState extends ChangeNotifier {
  AppState(this._storage);

  final LocalStorageService _storage;
  final _scoringService = CompatibilityScoringService();

  ParticipantProfile? userA;
  ParticipantProfile? userB;
  CompatibilityResult? result;
  String languageCode = 'en';
  ThemeMode themeMode = ThemeMode.system;
  bool isReady = false;

  void initialize() {
    userA = _storage.readUserA();
    userB = _storage.readUserB();
    result = _storage.readResult();
    languageCode = _storage.readLanguageCode();
    themeMode = _themeModeFromStorage(_storage.readThemeMode());
    isReady = true;
    notifyListeners();
  }

  ParticipantProfile? profileFor(ParticipantSlot slot) {
    return slot == ParticipantSlot.userA ? userA : userB;
  }

  Future<void> saveProfile(
    ParticipantSlot slot,
    ParticipantProfile profile,
  ) async {
    if (slot == ParticipantSlot.userA) {
      userA = profile;
      await _storage.saveUserA(profile);
    } else {
      userB = profile;
      await _storage.saveUserB(profile);
    }
    notifyListeners();
  }

  Future<void> updateAnswer(
    ParticipantSlot slot,
    String questionId,
    int value,
  ) async {
    final profile = profileFor(slot) ?? ParticipantProfile.empty();
    final answers = Map<String, int>.from(profile.answers)
      ..[questionId] = value;
    await saveProfile(slot, profile.copyWith(answers: answers));
  }

  Future<bool> calculateCompatibility() async {
    final a = userA;
    final b = userB;
    if (a == null || b == null || !a.hasRequiredInfo || !b.hasRequiredInfo) {
      return false;
    }
    result = _scoringService.analyze(a, b);
    await _storage.saveResult(result!);
    notifyListeners();
    return true;
  }

  Future<void> setLanguage(String value) async {
    languageCode = value;
    await _storage.saveLanguageCode(value);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode value) async {
    themeMode = value;
    await _storage.saveThemeMode(value.name);
    notifyListeners();
  }

  Future<void> saveBooking(Map<String, String> booking) {
    return _storage.saveBooking(booking);
  }

  Future<void> clearAssessment() async {
    userA = null;
    userB = null;
    result = null;
    await _storage.clearAssessment();
    notifyListeners();
  }

  ThemeMode _themeModeFromStorage(String value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
