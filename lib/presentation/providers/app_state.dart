import 'package:flutter/material.dart';

import '../../data/local/local_storage_service.dart';
import '../../domain/models/compatibility_result.dart';
import '../../domain/models/participant_profile.dart';
import '../../domain/models/question.dart';
import '../../domain/services/compatibility_scoring_service.dart';

enum ParticipantSlot { userA, userB }

class AppState extends ChangeNotifier {
  AppState(this._storage);

  final LocalStorageService _storage;
  final _scoringService = CompatibilityScoringService();

  ParticipantProfile? userA;
  ParticipantProfile? userB;
  CompatibilityResult? result;
  Map<String, String>? latestBooking;
  List<Map<String, String>> bookingHistory = [];
  int personalityStageIndex = 0;
  String languageCode = 'en';
  ThemeMode themeMode = ThemeMode.system;
  bool isReady = false;

  bool get hasCompleteProfiles =>
      (userA?.hasRequiredInfo ?? false) && (userB?.hasRequiredInfo ?? false);

  bool get hasCompletedQuestionnaire =>
      answeredQuestionsFor(ParticipantSlot.userA) == totalQuestionCount &&
      answeredQuestionsFor(ParticipantSlot.userB) == totalQuestionCount;

  bool get canCalculateCompatibility =>
      hasCompleteProfiles && hasCompletedQuestionnaire;

  List<CompatibilityQuestion> get activeQuestions =>
      _activeQuestionsForProfiles(userA, userB);

  int get totalQuestionCount => activeQuestions.length;

  List<CompatibilityQuestion> questionsForCategory(QuestionCategory category) {
    return activeQuestions.where((q) => q.category == category).toList();
  }

  int answeredQuestionsFor(ParticipantSlot slot) {
    final activeIds = activeQuestions.map((q) => q.id).toSet();
    return profileFor(slot)?.answers.keys.where(activeIds.contains).length ?? 0;
  }

  int answeredQuestionsForCategory(
    ParticipantSlot slot,
    QuestionCategory category,
  ) {
    final categoryIds = questionsForCategory(category).map((q) => q.id).toSet();
    return profileFor(slot)?.answers.keys.where(categoryIds.contains).length ??
        0;
  }

  bool isCategoryComplete(QuestionCategory category) {
    final total = questionsForCategory(category).length;
    if (total == 0) return true;
    return answeredQuestionsForCategory(ParticipantSlot.userA, category) ==
            total &&
        answeredQuestionsForCategory(ParticipantSlot.userB, category) == total;
  }

  bool get hasBookingHistory => bookingHistory.isNotEmpty;

  bool get hasPersonalityProgress =>
      answeredQuestionsFor(ParticipantSlot.userA) > 0 ||
      answeredQuestionsFor(ParticipantSlot.userB) > 0;

  void initialize() {
    userA = _storage.readUserA();
    userB = _storage.readUserB();
    result = _storage.readResult();
    latestBooking = _storage.readBooking();
    bookingHistory = _storage.readBookingHistory();
    if (bookingHistory.isEmpty && latestBooking != null) {
      bookingHistory = [latestBooking!];
    }
    personalityStageIndex = _storage.readPersonalityStageIndex();
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
    } else {
      userB = profile;
    }
    _pruneInactiveAnswersInMemory();
    await _persistProfiles();
    await _invalidateResultIfNeeded();
    notifyListeners();
  }

  Future<void> updateAnswer(
    ParticipantSlot slot,
    String questionId,
    int value,
  ) async {
    final profile = profileFor(slot) ?? ParticipantProfile.empty();
    if (profile.answers[questionId] == value) return;
    final answers = Map<String, int>.from(profile.answers)
      ..[questionId] = value;
    await saveProfile(slot, profile.copyWith(answers: answers));
  }

  Future<bool> calculateCompatibility() async {
    final a = userA;
    final b = userB;
    if (a == null || b == null || !canCalculateCompatibility) {
      return false;
    }
    result = _scoringService.analyze(a, b, activeQuestions);
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

  Future<void> setPersonalityStageIndex(int value) async {
    personalityStageIndex = value;
    await _storage.savePersonalityStageIndex(value);
    notifyListeners();
  }

  Future<void> saveBooking(Map<String, String> booking) async {
    latestBooking = booking;
    bookingHistory = [booking, ...bookingHistory];
    await _storage.saveBooking(booking);
    await _storage.saveBookingHistory(bookingHistory);
    notifyListeners();
  }

  Future<void> clearAssessment() async {
    userA = null;
    userB = null;
    result = null;
    latestBooking = null;
    bookingHistory = [];
    personalityStageIndex = 0;
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

  Future<void> _invalidateResultIfNeeded() async {
    if (result == null) return;
    result = null;
    await _storage.clearResult();
  }

  Future<void> _persistProfiles() async {
    final currentUserA = userA;
    final currentUserB = userB;
    if (currentUserA != null) {
      await _storage.saveUserA(currentUserA);
    }
    if (currentUserB != null) {
      await _storage.saveUserB(currentUserB);
    }
  }

  void _pruneInactiveAnswersInMemory() {
    final activeIds = activeQuestions.map((q) => q.id).toSet();

    ParticipantProfile? prune(ParticipantProfile? profile) {
      if (profile == null) return null;
      final filteredAnswers = Map<String, int>.from(profile.answers)
        ..removeWhere((key, _) => !activeIds.contains(key));
      if (filteredAnswers.length == profile.answers.length) {
        return profile;
      }
      return profile.copyWith(answers: filteredAnswers);
    }

    userA = prune(userA);
    userB = prune(userB);
  }

  List<CompatibilityQuestion> _activeQuestionsForProfiles(
    ParticipantProfile? participantA,
    ParticipantProfile? participantB,
  ) {
    return compatibilityQuestions.where((question) {
      return _isQuestionActive(question, participantA, participantB);
    }).toList();
  }

  bool _isQuestionActive(
    CompatibilityQuestion question,
    ParticipantProfile? participantA,
    ParticipantProfile? participantB,
  ) {
    final dependencyId = question.dependsOnQuestionId;
    if (dependencyId == null) return true;

    final answerA = participantA?.answers[dependencyId];
    final answerB = participantB?.answers[dependencyId];
    final answers = [answerA, answerB].whereType<int>().toList();
    if (answers.isEmpty) return false;

    final meetsHigh = question.showIfAnyAtLeast == null ||
        answers.any((value) => value >= question.showIfAnyAtLeast!);
    final meetsLow = question.showIfAnyAtMost == null ||
        answers.any((value) => value <= question.showIfAnyAtMost!);
    return meetsHigh && meetsLow;
  }
}
