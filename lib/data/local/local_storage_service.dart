import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/compatibility_result.dart';
import '../../domain/models/participant_profile.dart';

class LocalStorageService {
  LocalStorageService._(this._preferences);

  final SharedPreferences _preferences;

  static const _userAKey = 'participant_user_a';
  static const _userBKey = 'participant_user_b';
  static const _resultKey = 'compatibility_result';
  static const _languageKey = 'language_code';
  static const _themeKey = 'theme_mode';
  static const _bookingKey = 'latest_booking';

  static Future<LocalStorageService> create() async {
    return LocalStorageService._(await SharedPreferences.getInstance());
  }

  ParticipantProfile? readProfile(String key) {
    final value = _preferences.getString(key);
    if (value == null) return null;
    return ParticipantProfile.fromJson(
      jsonDecode(value) as Map<String, dynamic>,
    );
  }

  Future<void> saveProfile(String key, ParticipantProfile profile) {
    return _preferences.setString(key, jsonEncode(profile.toJson()));
  }

  ParticipantProfile? readUserA() => readProfile(_userAKey);

  ParticipantProfile? readUserB() => readProfile(_userBKey);

  Future<void> saveUserA(ParticipantProfile profile) =>
      saveProfile(_userAKey, profile);

  Future<void> saveUserB(ParticipantProfile profile) =>
      saveProfile(_userBKey, profile);

  CompatibilityResult? readResult() {
    final value = _preferences.getString(_resultKey);
    if (value == null) return null;
    return CompatibilityResult.fromJson(
      jsonDecode(value) as Map<String, dynamic>,
    );
  }

  Future<void> saveResult(CompatibilityResult result) {
    return _preferences.setString(_resultKey, jsonEncode(result.toJson()));
  }

  String readLanguageCode() => _preferences.getString(_languageKey) ?? 'en';

  Future<void> saveLanguageCode(String languageCode) {
    return _preferences.setString(_languageKey, languageCode);
  }

  String readThemeMode() => _preferences.getString(_themeKey) ?? 'system';

  Future<void> saveThemeMode(String mode) =>
      _preferences.setString(_themeKey, mode);

  Future<void> saveBooking(Map<String, String> booking) {
    return _preferences.setString(_bookingKey, jsonEncode(booking));
  }

  Future<void> clearAssessment() async {
    await _preferences.remove(_userAKey);
    await _preferences.remove(_userBKey);
    await _preferences.remove(_resultKey);
    await _preferences.remove(_bookingKey);
  }
}
