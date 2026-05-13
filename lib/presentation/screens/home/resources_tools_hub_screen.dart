import 'package:flutter/material.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/budget_planner_service.dart';
import '../../../data/local/gratitude_bank_service.dart';
import '../../../data/local/reminders_center_service.dart';
import '../../../domain/models/budget_entry.dart';
import '../../../domain/models/gratitude_note.dart';
import '../../../domain/models/reminder_entry.dart';

class ResourcesToolsHubScreen extends StatelessWidget {
  const ResourcesToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: context.tr('resourcesToolsHub'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('resourcesToolsHubIntroTitle'),
            icon: Icons.widgets_outlined,
            child: Text(context.tr('resourcesToolsHubIntroBody')),
          ),
          const SizedBox(height: 16),
          const _ToolsOverviewSection(),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('resourcesToolsHubToolsSection'),
            icon: Icons.handyman_outlined,
            child: Column(
              children: [
                _HubNavTile(
                  title: context.tr('gratitudeBank'),
                  subtitle: context.tr('featureGratitudeBank'),
                  icon: Icons.volunteer_activism_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.gratitudeBank),
                ),
                const SizedBox(height: 12),
                _HubNavTile(
                  title: context.tr('budgetPlanner'),
                  subtitle: context.tr('featureBudgetPlanner'),
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.budgetPlanner),
                ),
                const SizedBox(height: 12),
                _HubNavTile(
                  title: context.tr('remindersCenter'),
                  subtitle: context.tr('featureRemindersCenter'),
                  icon: Icons.notifications_none_rounded,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.remindersCenter),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolsOverviewSection extends StatelessWidget {
  const _ToolsOverviewSection();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ToolsOverviewData>(
      future: _loadOverview(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SectionCard(
            title: context.tr('toolsOverviewTitle'),
            icon: Icons.insights_outlined,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data ?? const _ToolsOverviewData.empty();

        return SectionCard(
          title: context.tr('toolsOverviewTitle'),
          icon: Icons.insights_outlined,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('toolsOverviewBody'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final useSingleColumn = constraints.maxWidth < 430;
                  return GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: useSingleColumn ? 1 : 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: useSingleColumn ? 96 : 112,
                    ),
                    children: [
                      _OverviewMetricCard(
                        label: context.tr('gratitudeBank'),
                        value: data.noteCount.toString(),
                        helper: context.tr('toolsOverviewSavedItems'),
                        icon: Icons.volunteer_activism_outlined,
                        color: Colors.pink,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.gratitudeBank,
                        ),
                      ),
                      _OverviewMetricCard(
                        label: context.tr('budgetBalance'),
                        value: data.balanceLabel,
                        helper: context.tr('budgetPlanner'),
                        icon: Icons.account_balance_wallet_outlined,
                        color: Colors.teal,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.budgetPlanner,
                        ),
                      ),
                      _OverviewMetricCard(
                        label: context.tr('remindersCenter'),
                        value: data.reminderCount.toString(),
                        helper: context.tr('toolsOverviewSavedPlans'),
                        icon: Icons.notifications_none_rounded,
                        color: Colors.indigo,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.remindersCenter,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              Material(
                color: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.gratitudeBank),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.tr('toolsOverviewLatestNote'),
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data.latestNotePreview.isEmpty
                              ? context.tr('toolsOverviewNoData')
                              : data.latestNotePreview,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(height: 1.35),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<_ToolsOverviewData> _loadOverview() async {
    const gratitudeService = GratitudeBankService();
    const budgetService = BudgetPlannerService();
    const remindersService = RemindersCenterService();

    final results = await Future.wait([
      gratitudeService.readNotes(),
      budgetService.readEntries(),
      remindersService.readEntries(),
    ]);

    final notes = results[0] as List<GratitudeNote>;
    final budgetEntries = results[1] as List<BudgetEntry>;
    final reminders = results[2] as List<ReminderEntry>;

    var balance = 0.0;
    for (final entry in budgetEntries) {
      if (entry.type == 'income') {
        balance += entry.amount;
      } else {
        balance -= entry.amount;
      }
    }

    return _ToolsOverviewData(
      noteCount: notes.length,
      reminderCount: reminders.length,
      latestNotePreview: notes.isEmpty ? '' : notes.first.text,
      balanceLabel: balance.toStringAsFixed(
        balance.truncateToDouble() == balance ? 0 : 2,
      ),
    );
  }
}

class _OverviewMetricCard extends StatelessWidget {
  const _OverviewMetricCard({
    required this.label,
    required this.value,
    required this.helper,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String value;
  final String helper;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const Spacer(),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                helper,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolsOverviewData {
  const _ToolsOverviewData({
    required this.noteCount,
    required this.reminderCount,
    required this.latestNotePreview,
    required this.balanceLabel,
  });

  const _ToolsOverviewData.empty()
    : noteCount = 0,
      reminderCount = 0,
      latestNotePreview = '',
      balanceLabel = '0';

  final int noteCount;
  final int reminderCount;
  final String latestNotePreview;
  final String balanceLabel;
}

class _HubNavTile extends StatelessWidget {
  const _HubNavTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primary.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
