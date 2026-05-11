class LoveLanguageQuizQuestion {
  const LoveLanguageQuizQuestion({
    required this.id,
    required this.promptEn,
    required this.promptAr,
    required this.options,
  });

  final String id;
  final String promptEn;
  final String promptAr;
  final List<LoveLanguageQuizOption> options;

  String prompt(String languageCode) =>
      languageCode == 'ar' ? promptAr : promptEn;
}

class LoveLanguageQuizOption {
  const LoveLanguageQuizOption({
    required this.id,
    required this.languageId,
    required this.labelEn,
    required this.labelAr,
  });

  final String id;
  final String languageId;
  final String labelEn;
  final String labelAr;

  String label(String languageCode) => languageCode == 'ar' ? labelAr : labelEn;
}
