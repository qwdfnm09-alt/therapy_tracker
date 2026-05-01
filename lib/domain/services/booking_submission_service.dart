import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/clinic_contact.dart';

class BookingSubmissionResult {
  const BookingSubmissionResult({required this.success, required this.channel});

  final bool success;
  final String channel;
}

class BookingSubmissionService {
  Future<BookingSubmissionResult> submit({
    required String sessionTypeLabel,
    required String clientPhone,
    required String preferredDate,
    required String message,
    String? recommendedReason,
    String? resultVerdict,
  }) async {
    final text = _buildMessage(
      sessionTypeLabel: sessionTypeLabel,
      clientPhone: clientPhone,
      preferredDate: preferredDate,
      message: message,
      recommendedReason: recommendedReason,
      resultVerdict: resultVerdict,
    );

    final whatsappUri = Uri.parse(
      'https://wa.me/$clinicWhatsappNumber?text=${Uri.encodeComponent(text)}',
    );
    if (await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      return const BookingSubmissionResult(success: true, channel: 'whatsapp');
    }

    final smsUri = Uri(
      scheme: 'sms',
      path: clinicPhoneNumber,
      queryParameters: {'body': text},
    );
    if (await launchUrl(smsUri, mode: LaunchMode.externalApplication)) {
      return const BookingSubmissionResult(success: true, channel: 'sms');
    }

    final telUri = Uri(scheme: 'tel', path: clinicPhoneNumber);
    if (await launchUrl(telUri, mode: LaunchMode.externalApplication)) {
      return const BookingSubmissionResult(success: true, channel: 'call');
    }
    return const BookingSubmissionResult(success: false, channel: 'failed');
  }

  String _buildMessage({
    required String sessionTypeLabel,
    required String clientPhone,
    required String preferredDate,
    required String message,
    String? recommendedReason,
    String? resultVerdict,
  }) {
    final lines = <String>[
      'New counseling booking request',
      'Clinic phone: $clinicPhoneNumber',
      'Session type: $sessionTypeLabel',
      'Client phone: $clientPhone',
      'Preferred date: $preferredDate',
    ];
    if ((resultVerdict ?? '').trim().isNotEmpty) {
      lines.add('Result verdict: ${resultVerdict!.trim()}');
    }
    if ((recommendedReason ?? '').trim().isNotEmpty) {
      lines.add('Recommendation context: ${recommendedReason!.trim()}');
    }
    if (message.trim().isNotEmpty) {
      lines.add('Message: ${message.trim()}');
    }
    return lines.join('\n');
  }
}
