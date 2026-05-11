import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:premarital_match/app.dart';
import 'package:premarital_match/data/local/budget_planner_service.dart';
import 'package:premarital_match/data/local/gratitude_bank_service.dart';
import 'package:premarital_match/data/local/love_language_quiz_service.dart';
import 'package:premarital_match/data/local/local_storage_service.dart';
import 'package:premarital_match/data/local/reminders_center_service.dart';
import 'package:premarital_match/data/local/relationship_tools_repository.dart';
import 'package:premarital_match/data/local/scenario_lab_progress_service.dart';
import 'package:premarital_match/data/local/scenario_lab_repository.dart';
import 'package:premarital_match/data/local/weekly_challenge_progress_service.dart';
import 'package:premarital_match/domain/models/budget_entry.dart';
import 'package:premarital_match/domain/models/compatibility_result.dart';
import 'package:premarital_match/domain/models/gratitude_note.dart';
import 'package:premarital_match/domain/models/love_language_quiz_result.dart';
import 'package:premarital_match/domain/models/participant_profile.dart';
import 'package:premarital_match/domain/models/question.dart';
import 'package:premarital_match/domain/models/reminder_entry.dart';
import 'package:premarital_match/domain/models/weekly_challenge_progress.dart';
import 'package:premarital_match/domain/services/booking_submission_service.dart';
import 'package:premarital_match/domain/services/scenario_lab_scoring_service.dart';
import 'package:premarital_match/presentation/providers/app_state.dart';
import 'package:premarital_match/presentation/screens/content/heritage_awareness_screen.dart';
import 'package:premarital_match/presentation/screens/content/in_laws_guide_screen.dart';
import 'package:premarital_match/presentation/screens/content/marriage_readiness_screen.dart';
import 'package:premarital_match/presentation/screens/counseling/counseling_booking_screen.dart';
import 'package:premarital_match/presentation/screens/forms/participant_form_screen.dart';
import 'package:premarital_match/presentation/screens/personality/personality_test_screen.dart';
import 'package:premarital_match/presentation/screens/settings/privacy_policy_screen.dart';
import 'package:premarital_match/presentation/screens/settings/settings_screen.dart';
import 'package:premarital_match/presentation/screens/tools/budget_planner_screen.dart';
import 'package:premarital_match/presentation/screens/tools/scenario_lab_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows welcome then navigates to home screen', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(storage)..initialize(),
        child: const PreMaritalMatchApp(),
      ),
    );

    expect(find.text('Start Usage'), findsOneWidget);

    await tester.tap(find.text('Start Usage'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();

    expect(find.text('Quick access'), findsOneWidget);
    expect(find.text('Personality test'), findsOneWidget);
  });

  test('clears stale result after profile data changes', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();
    final answers = {
      for (final question in compatibilityQuestions) question.id: 4,
    };

    await appState.saveProfile(
      ParticipantSlot.userA,
      ParticipantProfile(
        name: 'A',
        age: 25,
        job: 'Engineer',
        education: 'College',
        answers: answers,
      ),
    );
    await appState.saveProfile(
      ParticipantSlot.userB,
      ParticipantProfile(
        name: 'B',
        age: 24,
        job: 'Designer',
        education: 'College',
        answers: answers,
      ),
    );

    expect(await appState.calculateCompatibility(), isTrue);
    expect(appState.result, isA<CompatibilityResult>());

    await appState.saveProfile(
      ParticipantSlot.userA,
      appState.userA!.copyWith(job: 'Doctor'),
    );

    expect(appState.result, isNull);
    expect(storage.readResult(), isNull);
  });

  test('requires all questions before calculating compatibility', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await appState.saveProfile(
      ParticipantSlot.userA,
      const ParticipantProfile(
        name: 'A',
        age: 25,
        job: 'Engineer',
        education: 'College',
        answers: {},
      ),
    );
    await appState.saveProfile(
      ParticipantSlot.userB,
      const ParticipantProfile(
        name: 'B',
        age: 24,
        job: 'Designer',
        education: 'College',
        answers: {},
      ),
    );

    expect(appState.canCalculateCompatibility, isFalse);
    expect(await appState.calculateCompatibility(), isFalse);
    expect(appState.result, isNull);
  });

  test(
    'builds richer personality profile insights in compatibility result',
    () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.create();
      final appState = AppState(storage)..initialize();
      final answersA = {
        for (final question in compatibilityQuestions) question.id: 5,
      };
      final answersB = {
        for (final question in compatibilityQuestions) question.id: 4,
      };

      await appState.saveProfile(
        ParticipantSlot.userA,
        ParticipantProfile(
          name: 'A',
          age: 26,
          job: 'Engineer',
          education: 'College',
          answers: answersA,
        ),
      );
      await appState.saveProfile(
        ParticipantSlot.userB,
        ParticipantProfile(
          name: 'B',
          age: 25,
          job: 'Designer',
          education: 'College',
          answers: answersB,
        ),
      );

      expect(await appState.calculateCompatibility(), isTrue);
      expect(appState.result!.partnerArchetypes['userA'], isNotEmpty);
      expect(appState.result!.partnerArchetypes['userB'], isNotEmpty);
      expect(appState.result!.partnerProfiles['userA'], isNotEmpty);
      expect(appState.result!.partnerProfiles['userB'], isNotEmpty);
      expect(appState.result!.relationshipDynamics, isNotEmpty);
    },
  );

  test(
    'critical regulation weaknesses reduce readiness and trigger readiness support',
    () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.create();
      final appState = AppState(storage)..initialize();
      final answersA = {
        for (final question in compatibilityQuestions) question.id: 4,
      };
      final answersB = {
        for (final question in compatibilityQuestions) question.id: 4,
      };

      answersA['anger_pause'] = 1;
      answersA['anger_repair'] = 1;
      answersA['emotion_self_awareness'] = 2;
      answersA['responsibility_commitment'] = 2;

      await appState.saveProfile(
        ParticipantSlot.userA,
        ParticipantProfile(
          name: 'A',
          age: 26,
          job: 'Engineer',
          education: 'College',
          answers: answersA,
        ),
      );
      await appState.saveProfile(
        ParticipantSlot.userB,
        ParticipantProfile(
          name: 'B',
          age: 25,
          job: 'Designer',
          education: 'College',
          answers: answersB,
        ),
      );

      expect(await appState.calculateCompatibility(), isTrue);
      expect(
        appState.result!.marriageReadinessScore,
        lessThan(appState.result!.compatibilityPercentage),
      );
      expect(appState.result!.riskAreas, contains('risk:angerManagement'));
      expect(
        appState.result!.suggestedSessions,
        contains('session:individualReadiness'),
      );
    },
  );

  test(
    'stable high-quality answers avoid risk flags and keep alignment coaching only',
    () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.create();
      final appState = AppState(storage)..initialize();
      final answers = {
        for (final question in compatibilityQuestions) question.id: 4,
      };

      await appState.saveProfile(
        ParticipantSlot.userA,
        ParticipantProfile(
          name: 'A',
          age: 26,
          job: 'Engineer',
          education: 'College',
          answers: answers,
        ),
      );
      await appState.saveProfile(
        ParticipantSlot.userB,
        ParticipantProfile(
          name: 'B',
          age: 25,
          job: 'Designer',
          education: 'College',
          answers: answers,
        ),
      );

      expect(await appState.calculateCompatibility(), isTrue);
      expect(appState.result!.riskAreas, contains('risk:none'));
      expect(appState.result!.suggestedSessions, contains('session:alignment'));
      expect(
        appState.result!.compatibilityPercentage,
        greaterThanOrEqualTo(80),
      );
    },
  );

  test(
    'branching questions appear and prune answers when trigger changes',
    () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.create();
      final appState = AppState(storage)..initialize();

      await appState.saveProfile(
        ParticipantSlot.userA,
        const ParticipantProfile(
          name: 'A',
          age: 25,
          job: 'Engineer',
          education: 'College',
          answers: {},
        ),
      );
      await appState.saveProfile(
        ParticipantSlot.userB,
        const ParticipantProfile(
          name: 'B',
          age: 24,
          job: 'Designer',
          education: 'College',
          answers: {},
        ),
      );

      final initialCount = appState.totalQuestionCount;
      await appState.updateAnswer(ParticipantSlot.userA, 'anger_pause', 2);
      expect(appState.totalQuestionCount, greaterThan(initialCount));

      await appState.updateAnswer(ParticipantSlot.userA, 'anger_escalation', 4);
      expect(appState.userA!.answers.containsKey('anger_escalation'), isTrue);

      await appState.updateAnswer(ParticipantSlot.userA, 'anger_pause', 4);
      expect(appState.userA!.answers.containsKey('anger_escalation'), isFalse);
    },
  );

  test('loads latest booking from storage and updates app state', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await appState.saveBooking({
      'sessionType': 'family',
      'phone': '+201234567890',
      'preferredDate': '05/05/2026',
      'message': 'Need a consultation',
      'createdAt': '2026-05-01T12:00:00.000',
    });

    expect(appState.latestBooking, isNotNull);
    expect(appState.latestBooking!['sessionType'], 'family');

    final reloaded = AppState(storage)..initialize();
    expect(reloaded.latestBooking, isNotNull);
    expect(reloaded.latestBooking!['phone'], '+201234567890');
    expect(reloaded.latestBooking!['preferredDate'], '05/05/2026');
  });

  test('stores booking history with newest booking first', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await appState.saveBooking({
      'sessionType': 'family',
      'phone': '11111111',
      'preferredDate': '05/05/2026',
      'message': 'First',
      'createdAt': '2026-05-01T10:00:00.000',
    });
    await appState.saveBooking({
      'sessionType': 'coaching',
      'phone': '22222222',
      'preferredDate': '06/05/2026',
      'message': 'Second',
      'createdAt': '2026-05-01T11:00:00.000',
    });

    expect(appState.bookingHistory, hasLength(2));
    expect(appState.bookingHistory.first['message'], 'Second');
    expect(appState.bookingHistory.last['message'], 'First');

    final reloaded = AppState(storage)..initialize();
    expect(reloaded.bookingHistory, hasLength(2));
    expect(reloaded.bookingHistory.first['sessionType'], 'coaching');
  });

  test(
    'persists personality stage index between app state instances',
    () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.create();
      final appState = AppState(storage)..initialize();

      await appState.setPersonalityStageIndex(3);

      final reloaded = AppState(storage)..initialize();
      expect(reloaded.personalityStageIndex, 3);

      await reloaded.clearAssessment();

      final cleared = AppState(storage)..initialize();
      expect(cleared.personalityStageIndex, 0);
    },
  );

  testWidgets(
    'personality test shows one question at a time and unlocks next question after both answers',
    (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final storage = await LocalStorageService.create();
      final appState = AppState(storage)..initialize();

      await appState.saveProfile(
        ParticipantSlot.userA,
        const ParticipantProfile(
          name: 'A',
          age: 25,
          job: 'Engineer',
          education: 'College',
          answers: {},
        ),
      );
      await appState.saveProfile(
        ParticipantSlot.userB,
        const ParticipantProfile(
          name: 'B',
          age: 24,
          job: 'Designer',
          education: 'College',
          answers: {},
        ),
      );

      await tester.pumpWidget(
        _buildTestApp(appState, const PersonalityTestScreen()),
      );

      expect(find.text('Question 1 of 2'), findsOneWidget);
      expect(
        find.text(
          'After a demanding week, I recharge best by going out and staying around people.',
        ),
        findsOneWidget,
      );
      expect(
        find.text('This question is still waiting for one or both answers.'),
        findsWidgets,
      );

      await appState.updateAnswer(
        ParticipantSlot.userA,
        'personality_social_energy',
        4,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('This question is still waiting for one or both answers.'),
        findsWidgets,
      );

      await appState.updateAnswer(
        ParticipantSlot.userB,
        'personality_social_energy',
        4,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Both answers are set. You can keep moving.'),
        findsWidgets,
      );
    },
  );

  testWidgets('participant form updates progress as fields are filled', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      _buildTestApp(
        appState,
        const ParticipantFormScreen(slot: ParticipantSlot.userA),
      ),
    );

    expect(find.text('0 of 4 fields complete'), findsWidgets);

    await tester.enterText(find.byType(TextFormField).first, 'Sara');
    await tester.pumpAndSettle();
    expect(find.text('1 of 4 fields complete'), findsWidgets);
    expect(
      find.text(
        'Complete the remaining fields to unlock the next step smoothly.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('in-laws guide screen renders its core sections', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(home: const InLawsGuideScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Handle family pressure before it shapes the marriage'),
      findsOneWidget,
    );
    expect(find.text('First-contact expectations'), findsOneWidget);
  });

  testWidgets('marriage readiness screen renders its core sections', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(home: const MarriageReadinessScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Readiness should be checked before promises grow heavier'),
      findsOneWidget,
    );
    expect(find.text('Self-awareness first'), findsOneWidget);
  });

  testWidgets('heritage awareness screen renders its core sections', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(home: const HeritageAwarenessScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Use culture to support the family, not to excuse harm'),
      findsOneWidget,
    );
    expect(find.text('Useful wisdom vs harmful inheritance'), findsOneWidget);
  });

  testWidgets('budget planner screen renders without layout crash', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(home: const BudgetPlannerScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Budget Planner'), findsOneWidget);
    expect(find.text('Current summary'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test(
    'love language quiz saves and loads the primary result locally',
    () async {
      SharedPreferences.setMockInitialValues({});
      const repository = RelationshipToolsRepository();
      const service = LoveLanguageQuizService();
      final result = LoveLanguageQuizResult.fromSelections(
        questions: repository.loveLanguageQuestions(),
        selectedOptionIds: const {
          'after_long_week': 'after_long_week_affirmation',
          'ordinary_day': 'ordinary_day_affirmation',
          'during_conflict': 'during_conflict_affirmation',
          'busy_season': 'busy_season_affirmation',
          'special_memory': 'special_memory_affirmation',
        },
      );

      await service.saveResult(result);

      final savedResult = await service.readResult();
      expect(savedResult, isNotNull);
      expect(savedResult!.primaryLanguageId, 'affirmation');
      expect(
        savedResult.selectedOptionIds,
        containsPair('after_long_week', 'after_long_week_affirmation'),
      );
    },
  );

  test(
    'weekly challenge progress saves and loads completed ids locally',
    () async {
      SharedPreferences.setMockInitialValues({});
      const service = WeeklyChallengeProgressService();
      const progress = WeeklyChallengeProgress(
        completedIds: ['listening_15_minutes', 'no_phone_meal'],
        updatedAtIso: '2026-05-09T22:00:00.000',
      );

      await service.saveProgress(progress);

      final savedProgress = await service.readProgress();
      expect(savedProgress, isNotNull);
      expect(savedProgress!.completedIds, contains('listening_15_minutes'));
      expect(savedProgress.completedIds, contains('no_phone_meal'));
      expect(savedProgress.updatedAtIso, '2026-05-09T22:00:00.000');
    },
  );

  test(
    'gratitude bank summary counts total notes and notes in current month',
    () {
      const service = GratitudeBankService();
      final summary = service.buildSummary(const [
        GratitudeNote(
          id: '1',
          text: 'Recent note',
          createdAtIso: '2026-05-08T12:00:00.000',
        ),
        GratitudeNote(
          id: '2',
          text: 'Older note',
          createdAtIso: '2026-04-20T12:00:00.000',
        ),
      ], now: DateTime(2026, 5, 9));

      expect(summary.totalNotes, 2);
      expect(summary.notesThisMonth, 1);
      expect(summary.latestCreatedAtIso, '2026-05-08T12:00:00.000');
    },
  );

  test(
    'budget planner summary finds monthly count and top expense category',
    () {
      const service = BudgetPlannerService();
      final summary = service.buildSummary(const [
        BudgetEntry(
          id: '1',
          title: 'Salary',
          amount: 5000,
          type: 'income',
          category: 'Work',
          createdAtIso: '2026-05-08T12:00:00.000',
        ),
        BudgetEntry(
          id: '2',
          title: 'Rent',
          amount: 2000,
          type: 'expense',
          category: 'Housing',
          createdAtIso: '2026-05-07T12:00:00.000',
        ),
        BudgetEntry(
          id: '3',
          title: 'Groceries',
          amount: 700,
          type: 'expense',
          category: 'Food',
          createdAtIso: '2026-05-06T12:00:00.000',
        ),
        BudgetEntry(
          id: '4',
          title: 'Older bill',
          amount: 300,
          type: 'expense',
          category: 'Housing',
          createdAtIso: '2026-04-28T12:00:00.000',
        ),
      ], now: DateTime(2026, 5, 10));

      expect(summary.incomeTotal, 5000);
      expect(summary.expenseTotal, 3000);
      expect(summary.balance, 2000);
      expect(summary.entriesThisMonth, 3);
      expect(summary.topExpenseCategory, 'Housing');
      expect(summary.topExpenseAmount, 2300);
    },
  );

  test('reminders center summary finds monthly count and top category', () {
    const service = RemindersCenterService();
    final summary = service.buildSummary(const [
      ReminderEntry(
        id: '1',
        title: 'Friday check-in',
        scheduleLabel: 'Every Friday',
        category: 'checkIn',
        note: '',
        createdAtIso: '2026-05-09T12:00:00.000',
      ),
      ReminderEntry(
        id: '2',
        title: 'Budget review',
        scheduleLabel: 'End of month',
        category: 'budget',
        note: '',
        createdAtIso: '2026-05-08T12:00:00.000',
      ),
      ReminderEntry(
        id: '3',
        title: 'Sunday check-in',
        scheduleLabel: 'Every Sunday',
        category: 'checkIn',
        note: '',
        createdAtIso: '2026-04-08T12:00:00.000',
      ),
    ], now: DateTime(2026, 5, 10));

    expect(summary.totalEntries, 3);
    expect(summary.entriesThisMonth, 2);
    expect(summary.usedCategoriesCount, 2);
    expect(summary.topCategory, 'checkIn');
  });

  test('scenario lab summary separates aligned and gap scenarios', () {
    const repository = ScenarioLabRepository();
    const service = ScenarioLabScoringService();
    final summary = service.buildSummary(
      scenarios: repository.scenarios(),
      userAAnswers: const {
        'job_offer_move': 'job_offer_move_needs_structure',
        'family_boundary_visit': 'family_boundary_joint',
      },
      userBAnswers: const {
        'job_offer_move': 'job_offer_move_needs_structure',
        'family_boundary_visit': 'family_boundary_hard',
      },
    );

    expect(summary.answeredScenarios, 2);
    expect(summary.alignedCount, 1);
    expect(summary.closeCount, 0);
    expect(summary.gapCount, 1);
    expect(summary.recommendations, hasLength(1));
    expect(summary.recommendations.first.scenario.id, 'family_boundary_visit');
  });

  test('scenario lab progress saves and loads answers locally', () async {
    SharedPreferences.setMockInitialValues({});
    const service = ScenarioLabProgressService();
    const progress = ScenarioLabProgress(
      userAAnswers: {'job_offer_move': 'job_offer_move_needs_structure'},
      userBAnswers: {'family_boundary_visit': 'family_boundary_hard'},
    );

    await service.saveProgress(progress);

    final savedProgress = await service.readProgress();
    expect(
      savedProgress.userAAnswers,
      containsPair('job_offer_move', 'job_offer_move_needs_structure'),
    );
    expect(
      savedProgress.userBAnswers,
      containsPair('family_boundary_visit', 'family_boundary_hard'),
    );
  });

  testWidgets('scenario lab screen renders core sections', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(home: const ScenarioLabScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Stress-test the fit with realistic scenarios'),
      findsOneWidget,
    );
    expect(find.text('Compatibility radar'), findsOneWidget);
  });

  testWidgets('scenario lab shows discussion recommendations when gaps exist', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(
          home: ScenarioLabScreen(
            progressService: _FakeScenarioLabProgressService(
              progress: const ScenarioLabProgress(
                userAAnswers: {
                  'family_boundary_visit': 'family_boundary_joint',
                },
                userBAnswers: {'family_boundary_visit': 'family_boundary_hard'},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Discussion recommendations'), findsOneWidget);
    expect(find.text('Discuss first'), findsOneWidget);
    expect(find.text('Repeated family interference'), findsOneWidget);
  });

  testWidgets('settings opens the privacy policy screen', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(
          home: const SettingsScreen(),
          routes: {'/privacy-policy': (_) => const PrivacyPolicyScreen()},
        ),
      ),
    );

    await tester.tap(find.text('Privacy policy'));
    await tester.pumpAndSettle();

    expect(find.text('Privacy policy'), findsAtLeastNWidgets(1));
    expect(find.text('Data handled by the app'), findsOneWidget);
  });

  testWidgets('booking submit saves the real send status', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();
    final fakeService = _FakeBookingSubmissionService(
      result: const BookingSubmissionResult(
        success: true,
        channel: 'whatsapp',
        messageText: 'submitted text',
      ),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(
          home: CounselingBookingScreen(submissionService: fakeService),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    final textFields = tester.widgetList<TextFormField>(fields).toList();
    final submitLabel = find.text('Confirm booking');
    await tester.enterText(fields.at(0), '+201234567890');
    textFields[1].controller!.text = '05/05/2026';
    await tester.pump();
    await tester.enterText(fields.at(2), 'Need a consultation');

    await tester.scrollUntilVisible(
      submitLabel,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(submitLabel);
    await tester.pumpAndSettle();

    expect(fakeService.submitCallCount, 1);
    expect(appState.latestBooking?['sendStatus'], 'whatsapp');
    expect(appState.bookingHistory.first['sendStatus'], 'whatsapp');
    expect(find.text('Booking request ready'), findsAtLeastNWidgets(1));
  });

  testWidgets('booking confirmation syncs status without duplicating history', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.create();
    final appState = AppState(storage)..initialize();
    final fakeService = _FakeBookingSubmissionService(
      result: const BookingSubmissionResult(
        success: false,
        channel: 'failed',
        messageText: 'submitted text',
      ),
      openWhatsAppResult: true,
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: appState,
        child: MaterialApp(
          home: CounselingBookingScreen(submissionService: fakeService),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    final textFields = tester.widgetList<TextFormField>(fields).toList();
    final submitLabel = find.text('Confirm booking');
    await tester.enterText(fields.at(0), '+201234567890');
    textFields[1].controller!.text = '05/05/2026';
    await tester.pump();
    await tester.enterText(fields.at(2), 'Need a consultation');

    await tester.scrollUntilVisible(
      submitLabel,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(submitLabel);
    await tester.pumpAndSettle();

    expect(appState.latestBooking?['sendStatus'], 'failed');
    expect(appState.bookingHistory, hasLength(1));

    await tester.tap(find.text('Open WhatsApp'));
    await tester.pumpAndSettle();

    expect(fakeService.openWhatsAppCallCount, 1);
    expect(appState.latestBooking?['sendStatus'], 'whatsapp');
    expect(appState.bookingHistory, hasLength(1));
    expect(appState.bookingHistory.first['sendStatus'], 'whatsapp');
  });
}

Widget _buildTestApp(AppState appState, Widget home) {
  return ChangeNotifierProvider.value(
    value: appState,
    child: MaterialApp(home: home),
  );
}

class _FakeBookingSubmissionService extends BookingSubmissionService {
  _FakeBookingSubmissionService({
    required this.result,
    this.openWhatsAppResult = false,
  });

  final BookingSubmissionResult result;
  int submitCallCount = 0;
  final bool openWhatsAppResult;
  int openWhatsAppCallCount = 0;
  int openSmsCallCount = 0;
  int openCallCount = 0;

  @override
  Future<BookingSubmissionResult> submit({
    required String sessionTypeLabel,
    required String clientPhone,
    required String preferredDate,
    required String message,
    String? recommendedReason,
    String? resultVerdict,
  }) async {
    submitCallCount++;
    return result;
  }

  @override
  Future<bool> openWhatsApp(String text) async {
    openWhatsAppCallCount++;
    return openWhatsAppResult;
  }

  @override
  Future<bool> openSms(String text) async {
    openSmsCallCount++;
    return false;
  }

  @override
  Future<bool> openCall() async {
    openCallCount++;
    return false;
  }
}

class _FakeScenarioLabProgressService extends ScenarioLabProgressService {
  const _FakeScenarioLabProgressService({required this.progress});

  final ScenarioLabProgress progress;

  @override
  Future<ScenarioLabProgress> readProgress() async => progress;

  @override
  Future<void> saveProgress(ScenarioLabProgress progress) async {}
}
