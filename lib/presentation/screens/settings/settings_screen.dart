import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return AppPage(
      title: context.tr('settings'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('appearance'),
            icon: Icons.contrast_outlined,
            child: SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_outlined),
                  label: Text(context.tr('system')),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: const Icon(Icons.light_mode_outlined),
                  label: Text(context.tr('light')),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_outlined),
                  label: Text(context.tr('dark')),
                ),
              ],
              selected: {appState.themeMode},
              onSelectionChanged: (selection) =>
                  context.read<AppState>().setThemeMode(selection.first),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('language'),
            icon: Icons.language_outlined,
            child: SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'en', label: Text(context.tr('english'))),
                ButtonSegment(value: 'ar', label: Text(context.tr('arabic'))),
              ],
              selected: {appState.languageCode},
              onSelectionChanged: (selection) =>
                  context.read<AppState>().setLanguage(selection.first),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: FilledButton.tonalIcon(
              onPressed: () async {
                await context.read<AppState>().clearAssessment();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr('clearData'))),
                );
              },
              icon: const Icon(Icons.delete_outline),
              label: Text(context.tr('clearData')),
            ),
          ),
        ],
      ),
    );
  }
}
