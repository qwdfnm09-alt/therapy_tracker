import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/app_state.dart';
import 'presentation/screens/counseling/counseling_booking_screen.dart';
import 'presentation/screens/forms/participant_form_screen.dart';
import 'presentation/screens/personality/personality_test_screen.dart';
import 'presentation/screens/results/compatibility_result_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'presentation/screens/welcome/welcome_screen.dart';

class PreMaritalMatchApp extends StatelessWidget {
  const PreMaritalMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PreMarital Match',
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
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.welcome: (_) => const WelcomeScreen(),
        AppRoutes.userAForm: (_) =>
            const ParticipantFormScreen(slot: ParticipantSlot.userA),
        AppRoutes.userBForm: (_) =>
            const ParticipantFormScreen(slot: ParticipantSlot.userB),
        AppRoutes.personalityTest: (_) => const PersonalityTestScreen(),
        AppRoutes.results: (_) => const CompatibilityResultScreen(),
        AppRoutes.counseling: (_) => const CounselingBookingScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}
