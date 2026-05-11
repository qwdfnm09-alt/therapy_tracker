enum ConnectedFeatureAvailability { planned }

enum ConnectedFeatureRequirement {
  auth,
  backendApi,
  privacyConsent,
  moderation,
  expertOperations,
  safetyRouting,
  partnerOperations,
}

class ConnectedFeatureItem {
  const ConnectedFeatureItem({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.summaryEn,
    required this.summaryAr,
    required this.availability,
    required this.requirements,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String summaryEn;
  final String summaryAr;
  final ConnectedFeatureAvailability availability;
  final List<ConnectedFeatureRequirement> requirements;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String summary(String languageCode) =>
      languageCode == 'ar' ? summaryAr : summaryEn;
}
