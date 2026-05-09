import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/app_state.dart';
import 'presentation/screens/counseling/booking_history_screen.dart';
import 'presentation/screens/counseling/counseling_booking_screen.dart';
import 'presentation/screens/content/educational_hub_screen.dart';
import 'presentation/screens/content/golden_questions_screen.dart';
import 'presentation/screens/content/red_flags_screen.dart';
import 'presentation/screens/forms/participant_form_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/home/resources_tools_hub_screen.dart';
import 'presentation/screens/personality/personality_intro_screen.dart';
import 'presentation/screens/personality/personality_test_screen.dart';
import 'presentation/screens/results/compatibility_result_screen.dart';
import 'presentation/screens/settings/privacy_policy_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/tools/budget_planner_screen.dart';
import 'presentation/screens/tools/gratitude_bank_screen.dart';
import 'presentation/screens/tools/reminders_center_screen.dart';
import 'presentation/screens/tools/relationship_tools_screen.dart';
import 'presentation/screens/welcome/welcome_screen.dart';

class PreMaritalMatchApp extends StatelessWidget {
  const PreMaritalMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ميثاق',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: appState.themeMode,
      locale: Locale(appState.languageCode),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (_) => const WelcomeScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.userAForm: (_) =>
            const ParticipantFormScreen(slot: ParticipantSlot.userA),
        AppRoutes.userBForm: (_) =>
            const ParticipantFormScreen(slot: ParticipantSlot.userB),
        AppRoutes.personalityTest: (_) => const PersonalityIntroScreen(),
        AppRoutes.personalityQuestions: (_) => const PersonalityTestScreen(),
        AppRoutes.results: (_) => const CompatibilityResultScreen(),
        AppRoutes.counseling: (_) => const CounselingBookingScreen(),
        AppRoutes.bookingHistory: (_) => const BookingHistoryScreen(),
        AppRoutes.educationalHub: (_) => const EducationalHubScreen(),
        AppRoutes.resourcesToolsHub: (_) => const ResourcesToolsHubScreen(),
        AppRoutes.goldenQuestions: (_) => const GoldenQuestionsScreen(),
        AppRoutes.redFlags: (_) => const RedFlagsScreen(),
        AppRoutes.relationshipTools: (_) => const RelationshipToolsScreen(),
        AppRoutes.gratitudeBank: (_) => const GratitudeBankScreen(),
        AppRoutes.budgetPlanner: (_) => const BudgetPlannerScreen(),
        AppRoutes.remindersCenter: (_) => const RemindersCenterScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
        AppRoutes.privacyPolicy: (_) => const PrivacyPolicyScreen(),
      },
    );
  }
}
