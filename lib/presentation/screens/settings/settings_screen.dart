import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isArabic = appState.languageCode == 'ar';
    final privacyLabel = isArabic ? 'سياسة الخصوصية' : 'Privacy policy';
    final privacyBody = isArabic
        ? 'راجع ما الذي يُحفظ على الجهاز وكيفية حذف البيانات.'
        : 'Review what is stored on device and how to clear saved data.';

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
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.cloud_outlined),
              title: Text(context.tr('connectedFeatures')),
              subtitle: Text(context.tr('connectedFeaturesTileBody')),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.connectedFeatures),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(privacyLabel),
              subtitle: Text(privacyBody),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.privacyPolicy),
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
