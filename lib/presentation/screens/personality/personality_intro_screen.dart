import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class PersonalityIntroScreen extends StatelessWidget {
  const PersonalityIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final theme = Theme.of(context);

    return AppPage(
      title: context.tr('personalityTest'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('personalityOnboardingTitle'),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  context.tr('personalityOnboardingBody'),
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _IntroCard(
            icon: Icons.layers_outlined,
            title: context.tr('personalityOnboardingStagesTitle'),
            body: context.tr('personalityOnboardingStagesBody'),
          ),
          const SizedBox(height: 16),
          _IntroCard(
            icon: Icons.alt_route_outlined,
            title: context.tr('personalityOnboardingAdaptiveTitle'),
            body: context.tr('personalityOnboardingAdaptiveBody'),
          ),
          const SizedBox(height: 16),
          _IntroCard(
            icon: Icons.auto_awesome_outlined,
            title: context.tr('personalityOnboardingArchetypeTitle'),
            body: context.tr('personalityOnboardingArchetypeBody'),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.personalityQuestions),
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(
              appState.hasPersonalityProgress
                  ? context.tr('resumePersonalityJourney')
                  : context.tr('startPersonalityJourney'),
            ),
          ),
          if (appState.hasPersonalityProgress) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                await context.read<AppState>().setPersonalityStageIndex(0);
                if (!context.mounted) return;
                Navigator.pushNamed(context, AppRoutes.personalityQuestions);
              },
              icon: const Icon(Icons.restart_alt_rounded),
              label: Text(context.tr('restartPersonalityJourney')),
            ),
          ],
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: title,
      icon: icon,
      child: Text(body),
    );
  }
}
