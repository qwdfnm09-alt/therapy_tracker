import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/clinic_contact.dart';

class BookingSubmissionResult {
  const BookingSubmissionResult({
    required this.success,
    required this.channel,
    required this.messageText,
  });

  final bool success;
  final String channel;
  final String messageText;
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
    final text = buildMessage(
      sessionTypeLabel: sessionTypeLabel,
      clientPhone: clientPhone,
      preferredDate: preferredDate,
      message: message,
      recommendedReason: recommendedReason,
      resultVerdict: resultVerdict,
    );

    final whatsappUri = buildWhatsappUri(text);
    if (await _launchSafely(whatsappUri)) {
      return BookingSubmissionResult(
        success: true,
        channel: 'whatsapp',
        messageText: text,
      );
    }

    final smsUri = buildSmsUri(text);
    if (await _launchSafely(smsUri)) {
      return BookingSubmissionResult(
        success: true,
        channel: 'sms',
        messageText: text,
      );
    }

    final telUri = buildCallUri();
    if (await _launchSafely(telUri)) {
      return BookingSubmissionResult(
        success: true,
        channel: 'call',
        messageText: text,
      );
    }
    return BookingSubmissionResult(
      success: false,
      channel: 'failed',
      messageText: text,
    );
  }

  Uri buildWhatsappUri(String text) {
    return Uri.parse(
      'https://wa.me/$clinicWhatsappNumber?text=${Uri.encodeComponent(text)}',
    );
  }

  Uri buildSmsUri(String text) {
    return Uri(
      scheme: 'sms',
      path: clinicPhoneNumber,
      queryParameters: {'body': text},
    );
  }

  Uri buildCallUri() {
    return Uri(scheme: 'tel', path: clinicPhoneNumber);
  }

  Future<bool> openWhatsApp(String text) {
    return _launchSafely(buildWhatsappUri(text));
  }

  Future<bool> openSms(String text) {
    return _launchSafely(buildSmsUri(text));
  }

  Future<bool> openCall() {
    return _launchSafely(buildCallUri());
  }

  Future<bool> _launchSafely(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  String buildMessage({
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
