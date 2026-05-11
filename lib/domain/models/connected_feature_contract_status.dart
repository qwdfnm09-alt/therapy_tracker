import '../../core/config/backend_mode.dart';

class ConnectedFeatureContractStatus {
  const ConnectedFeatureContractStatus({
    required this.featureId,
    required this.mode,
    required this.enabled,
    required this.providerKey,
    required this.messageEn,
    required this.messageAr,
  });

  final String featureId;
  final BackendMode mode;
  final bool enabled;
  final String providerKey;
  final String messageEn;
  final String messageAr;

  String message(String languageCode) =>
      languageCode == 'ar' ? messageAr : messageEn;
}
