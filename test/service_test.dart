import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:premarital_match/core/constants/clinic_contact.dart';
import 'package:premarital_match/domain/services/booking_submission_service.dart';
import 'package:premarital_match/domain/services/compatibility_pdf_export_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BookingSubmissionService', () {
    test('buildMessage includes optional context when present', () {
      final service = BookingSubmissionService();

      final message = service.buildMessage(
        sessionTypeLabel: 'Family consultation',
        clientPhone: '+201234567890',
        preferredDate: '05/05/2026',
        message: 'Need a consultation',
        recommendedReason: 'Family boundaries need discussion',
        resultVerdict: 'Promising with discussion',
      );

      expect(message, contains('New counseling booking request'));
      expect(message, contains('Clinic phone: $clinicPhoneNumber'));
      expect(
        message,
        contains(
          'Requested action: Please review this request and confirm the most suitable counseling follow-up.',
        ),
      );
      expect(message, contains('Booking details:'));
      expect(message, contains('Assessment context:'));
      expect(message, contains('Session type: Family consultation'));
      expect(message, contains('Client phone: +201234567890'));
      expect(message, contains('Preferred date: 05/05/2026'));
      expect(message, contains('Result verdict: Promising with discussion'));
      expect(
        message,
        contains('Recommendation context: Family boundaries need discussion'),
      );
      expect(message, contains('Client note:'));
      expect(message, contains('Message: Need a consultation'));
    });

    test('URI builders target the configured clinic channels', () {
      final service = BookingSubmissionService();
      final whatsappUri = service.buildWhatsappUri('Hello there');
      final smsUri = service.buildSmsUri('Hello there');
      final callUri = service.buildCallUri();

      expect(
        whatsappUri.toString(),
        contains('https://wa.me/$clinicWhatsappNumber'),
      );
      expect(whatsappUri.toString(), contains('Hello%20there'));
      expect(smsUri.scheme, 'sms');
      expect(smsUri.path, clinicPhoneNumber);
      expect(smsUri.queryParameters['body'], 'Hello there');
      expect(callUri.scheme, 'tel');
      expect(callUri.path, clinicPhoneNumber);
    });
  });

  group('CompatibilityPdfExportService', () {
    test('buildPdfBytes returns non-empty PDF data', () async {
      final service = CompatibilityPdfExportService();

      final bytes = await service.buildPdfBytes(_sampleReportData());

      expect(bytes, isNotEmpty);
      expect(bytes.length, greaterThan(1000));
    });

    test(
      'saveReport delegates bytes and generated filename to share',
      () async {
        final service = _RecordingPdfExportService();

        final result = await service.saveReport(_sampleReportData());

        expect(result, isTrue);
        expect(service.savedFilenames, ['Taalof-report.pdf']);
        expect(service.savedBytes.single, Uint8List.fromList([1, 2, 3]));
      },
    );
  });
}

CompatibilityPdfReportData _sampleReportData() {
  return const CompatibilityPdfReportData(
    isRtl: false,
    appName: 'Taalof',
    reportTitle: 'Compatibility Report',
    generatedAt: '2026-05-02 12:00',
    participantALabel: 'User A',
    participantAName: 'Sara',
    participantBLabel: 'User B',
    participantBName: 'Omar',
    compatibilityLabel: 'Compatibility',
    compatibilityScore: 82,
    readinessLabel: 'Readiness',
    readinessScore: 78,
    verdictTitle: 'Verdict',
    verdictHeadline: 'Strong base',
    verdictBody: 'The relationship shows a stable base for marriage.',
    conversationPrepTitle: 'Conversation prep',
    decisionCheckpointTitle: 'Decision checkpoint',
    decisionCheckpointBody:
        'Use the result to confirm expectations before making a final decision.',
    discussionChecklistTitle: 'Checklist before a final decision',
    discussionChecklistItems: [
      'Name the biggest difference clearly.',
      'Agree on the next practical step.',
    ],
    conversationGroundRulesTitle: 'Ground rules for the next conversation',
    conversationGroundRules: [
      'Discuss one topic at a time.',
      'Use concrete examples.',
    ],
    nextStepTitle: 'Next step',
    nextStepBody: 'Hold one guided conversation to confirm expectations.',
    topicsTitle: 'Discussion topics',
    discussionTopics: ['Family boundaries', 'Money planning'],
    categoryTitle: 'Category analysis',
    categoryScores: {'Communication': 84, 'Family boundaries': 77},
    archetypeTitle: 'Archetypes',
    participantAArchetype: 'planner+warmCommunicator',
    participantBArchetype: 'balanced+steadyResponder',
    participantProfileTitle: 'profile',
    participantAProfile: ['Outgoing', 'Structured'],
    participantBProfile: ['Balanced', 'Steady'],
    dynamicsTitle: 'Dynamics',
    dynamics: ['Aligned planning rhythm'],
    strengthsTitle: 'Strengths',
    strengths: ['Communication alignment'],
    risksTitle: 'Risks',
    risks: ['Family pressure needs discussion'],
    notesTitle: 'Notes',
    notes: ['Keep expectations explicit'],
    sessionsTitle: 'Sessions',
    sessions: ['Family consultation'],
  );
}

class _RecordingPdfExportService extends CompatibilityPdfExportService {
  final List<Uint8List> savedBytes = [];
  final List<String> savedFilenames = [];

  @override
  Future<Uint8List> buildPdfBytes(CompatibilityPdfReportData data) async {
    return Uint8List.fromList([1, 2, 3]);
  }

  @override
  Future<bool> sharePdfBytes(Uint8List bytes, String filename) async {
    savedBytes.add(bytes);
    savedFilenames.add(filename);
    return true;
  }
}
