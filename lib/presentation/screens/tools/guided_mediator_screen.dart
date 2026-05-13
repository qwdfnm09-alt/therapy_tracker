import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/guided_mediator_repository.dart';
import '../../../domain/models/guided_mediator_track.dart';

class GuidedMediatorScreen extends StatefulWidget {
  const GuidedMediatorScreen({
    super.key,
    this.repository = const GuidedMediatorRepository(),
  });

  final GuidedMediatorRepository repository;

  @override
  State<GuidedMediatorScreen> createState() => _GuidedMediatorScreenState();
}

class _GuidedMediatorScreenState extends State<GuidedMediatorScreen> {
  late final List<GuidedMediatorTrack> _tracks;
  String? _selectedTrackId;

  @override
  void initState() {
    super.initState();
    _tracks = widget.repository.tracks();
    _selectedTrackId = _tracks.isEmpty ? null : _tracks.first.id;
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final selectedTrack = _selectedTrackId == null
        ? null
        : widget.repository.trackById(_selectedTrackId!);

    return AppPage(
      title: context.tr('guidedMediator'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('guidedMediatorIntroTitle'),
            icon: Icons.forum_outlined,
            child: Text(context.tr('guidedMediatorIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('guidedMediatorTracksTitle'),
            icon: Icons.tune_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('guidedMediatorTracksBody'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final track in _tracks)
                      ChoiceChip(
                        label: Text(track.title(languageCode)),
                        selected: track.id == _selectedTrackId,
                        onSelected: (_) {
                          setState(() {
                            _selectedTrackId = track.id;
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (selectedTrack != null)
            SectionCard(
              title: context.tr('guidedMediatorPlanTitle'),
              icon: Icons.route_outlined,
              child: _MediatorPlanBody(
                track: selectedTrack,
                languageCode: languageCode,
              ),
            ),
          if (selectedTrack != null) const SizedBox(height: 16),
          SectionCard(
            title: context.tr('guidedMediatorLocalNoteTitle'),
            icon: Icons.info_outline_rounded,
            child: Text(context.tr('guidedMediatorLocalNoteBody')),
          ),
        ],
      ),
    );
  }
}

class _MediatorPlanBody extends StatelessWidget {
  const _MediatorPlanBody({required this.track, required this.languageCode});

  final GuidedMediatorTrack track;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          track.title(languageCode),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          track.summary(languageCode),
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
        ),
        const SizedBox(height: 14),
        _PlanStepCard(
          title: context.tr('guidedMediatorPauseLabel'),
          body: track.pause(languageCode),
          color: Colors.indigo,
          icon: Icons.pause_circle_outline_rounded,
        ),
        const SizedBox(height: 12),
        _PlanStepCard(
          title: context.tr('guidedMediatorPersonALabel'),
          body: track.personAPrompt(languageCode),
          color: Colors.teal,
          icon: Icons.record_voice_over_outlined,
        ),
        const SizedBox(height: 12),
        _PlanStepCard(
          title: context.tr('guidedMediatorPersonBLabel'),
          body: track.personBPrompt(languageCode),
          color: Colors.orange,
          icon: Icons.hearing_outlined,
        ),
        const SizedBox(height: 12),
        _PlanStepCard(
          title: context.tr('guidedMediatorAgreementLabel'),
          body: track.agreementPrompt(languageCode),
          color: Colors.pink,
          icon: Icons.handshake_outlined,
        ),
        const SizedBox(height: 12),
        _PlanStepCard(
          title: context.tr('guidedMediatorEscalationLabel'),
          body: track.escalationNote(languageCode),
          color: Colors.redAccent,
          icon: Icons.support_agent_outlined,
        ),
      ],
    );
  }
}

class _PlanStepCard extends StatelessWidget {
  const _PlanStepCard({
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  });

  final String title;
  final String body;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 6),
                Text(
                  body,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
