class PartnerOffer {
  const PartnerOffer({
    required this.merchantEn,
    required this.merchantAr,
    required this.titleEn,
    required this.titleAr,
    required this.summaryEn,
    required this.summaryAr,
    required this.claimHintEn,
    required this.claimHintAr,
    this.code,
    this.notesEn,
    this.notesAr,
  });

  final String merchantEn;
  final String merchantAr;
  final String titleEn;
  final String titleAr;
  final String summaryEn;
  final String summaryAr;
  final String claimHintEn;
  final String claimHintAr;
  final String? code;
  final String? notesEn;
  final String? notesAr;

  String merchant(String languageCode) =>
      languageCode == 'ar' ? merchantAr : merchantEn;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String summary(String languageCode) =>
      languageCode == 'ar' ? summaryAr : summaryEn;

  String claimHint(String languageCode) =>
      languageCode == 'ar' ? claimHintAr : claimHintEn;

  String? notes(String languageCode) =>
      languageCode == 'ar' ? notesAr : notesEn;
}
