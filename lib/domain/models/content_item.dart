class ContentItem {
  const ContentItem({
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    this.tagEn,
    this.tagAr,
  });

  final String titleEn;
  final String titleAr;
  final String bodyEn;
  final String bodyAr;
  final String? tagEn;
  final String? tagAr;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String body(String languageCode) => languageCode == 'ar' ? bodyAr : bodyEn;

  String? tag(String languageCode) => languageCode == 'ar' ? tagAr : tagEn;
}

class ContentSection {
  const ContentSection({
    required this.titleEn,
    required this.titleAr,
    required this.items,
    this.descriptionEn,
    this.descriptionAr,
  });

  final String titleEn;
  final String titleAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final List<ContentItem> items;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String? description(String languageCode) =>
      languageCode == 'ar' ? descriptionAr : descriptionEn;
}
