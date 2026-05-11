class ScenarioLabItem {
  const ScenarioLabItem({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    required this.focusEn,
    required this.focusAr,
    required this.options,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String bodyEn;
  final String bodyAr;
  final String focusEn;
  final String focusAr;
  final List<ScenarioLabOption> options;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String body(String languageCode) => languageCode == 'ar' ? bodyAr : bodyEn;

  String focus(String languageCode) => languageCode == 'ar' ? focusAr : focusEn;
}

class ScenarioLabOption {
  const ScenarioLabOption({
    required this.id,
    required this.axis,
    required this.labelEn,
    required this.labelAr,
  });

  final String id;
  final String axis;
  final String labelEn;
  final String labelAr;

  String label(String languageCode) => languageCode == 'ar' ? labelAr : labelEn;
}
