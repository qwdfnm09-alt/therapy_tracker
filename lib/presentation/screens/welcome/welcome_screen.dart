import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final hasStarted = appState.userA != null || appState.userB != null;
    final theme = Theme.of(context);

    return AppPage(
      actions: [
        IconButton(
          tooltip: context.tr('settings'),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.favorite_rounded,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('appName'),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      context.tr('tagline'),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            context.tr('welcomeTitle'),
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            context.tr('welcomeBody'),
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
          const SizedBox(height: 24),
          SectionCard(
            child: Column(
              children: [
                _FeatureRow(
                  icon: Icons.psychology_alt_outlined,
                  text: 'Personality and emotional intelligence',
                ),
                _FeatureRow(
                  icon: Icons.forum_outlined,
                  text: 'Communication, anger, and conflict repair',
                ),
                _FeatureRow(
                  icon: Icons.account_balance_wallet_outlined,
                  text: 'Money, family boundaries, and future goals',
                ),
                _FeatureRow(
                  icon: Icons.verified_user_outlined,
                  text: context.tr('localOnly'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.userAForm),
            icon: const Icon(Icons.arrow_forward_rounded),
            label: Text(
              hasStarted
                  ? context.tr('continueAssessment')
                  : context.tr('startAssessment'),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: appState.result == null
                ? null
                : () => Navigator.pushNamed(context, AppRoutes.results),
            icon: const Icon(Icons.insights_outlined),
            label: Text(context.tr('result')),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
