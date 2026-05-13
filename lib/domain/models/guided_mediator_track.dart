class GuidedMediatorTrack {
  const GuidedMediatorTrack({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.summaryEn,
    required this.summaryAr,
    required this.pauseEn,
    required this.pauseAr,
    required this.personAPromptEn,
    required this.personAPromptAr,
    required this.personBPromptEn,
    required this.personBPromptAr,
    required this.agreementPromptEn,
    required this.agreementPromptAr,
    required this.escalationNoteEn,
    required this.escalationNoteAr,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String summaryEn;
  final String summaryAr;
  final String pauseEn;
  final String pauseAr;
  final String personAPromptEn;
  final String personAPromptAr;
  final String personBPromptEn;
  final String personBPromptAr;
  final String agreementPromptEn;
  final String agreementPromptAr;
  final String escalationNoteEn;
  final String escalationNoteAr;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String summary(String languageCode) =>
      languageCode == 'ar' ? summaryAr : summaryEn;

  String pause(String languageCode) => languageCode == 'ar' ? pauseAr : pauseEn;

  String personAPrompt(String languageCode) =>
      languageCode == 'ar' ? personAPromptAr : personAPromptEn;

  String personBPrompt(String languageCode) =>
      languageCode == 'ar' ? personBPromptAr : personBPromptEn;

  String agreementPrompt(String languageCode) =>
      languageCode == 'ar' ? agreementPromptAr : agreementPromptEn;

  String escalationNote(String languageCode) =>
      languageCode == 'ar' ? escalationNoteAr : escalationNoteEn;
}
