import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:premarital_match/app.dart';
import 'package:premarital_match/data/local/local_storage_service.dart';
import 'package:premarital_match/domain/models/compatibility_result.dart';
import 'package:premarital_match/domain/models/participant_profile.dart';
import 'package:premarital_match/domain/models/question.dart';
import 'package:premarital_match/presentation/providers/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows splash then navigates to home screen', (
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

    expect(find.text('Taalof'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Choose the feature you want to open'), findsOneWidget);
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

  test('builds richer personality profile insights in compatibility result', () async {
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
  });

  test('branching questions appear and prune answers when trigger changes', () async {
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

    await appState.updateAnswer(
      ParticipantSlot.userA,
      'anger_escalation',
      4,
    );
    expect(appState.userA!.answers.containsKey('anger_escalation'), isTrue);

    await appState.updateAnswer(ParticipantSlot.userA, 'anger_pause', 4);
    expect(appState.userA!.answers.containsKey('anger_escalation'), isFalse);
  });

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
}
