enum QuestionCategory {
  personality,
  emotionalIntelligence,
  angerManagement,
  communication,
  financialMindset,
  familyBoundaries,
  futureGoals,
  responsibility,
}

enum ScoringMode { similarity, healthyAverage }

class CompatibilityQuestion {
  const CompatibilityQuestion({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.category,
    required this.mode,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final QuestionCategory category;
  final ScoringMode mode;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;
}

const compatibilityQuestions = <CompatibilityQuestion>[
  CompatibilityQuestion(
    id: 'personality_social_energy',
    titleEn: 'I prefer an active social life.',
    titleAr: 'أفضل حياة اجتماعية نشطة.',
    category: QuestionCategory.personality,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'personality_structure',
    titleEn: 'I like planning and structure.',
    titleAr: 'أفضل التخطيط والنظام.',
    category: QuestionCategory.personality,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'emotion_self_awareness',
    titleEn: 'I can name my feelings clearly.',
    titleAr: 'أستطيع تحديد مشاعري بوضوح.',
    category: QuestionCategory.emotionalIntelligence,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'emotion_empathy',
    titleEn: 'I listen before judging.',
    titleAr: 'أستمع قبل الحكم على الموقف.',
    category: QuestionCategory.emotionalIntelligence,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'anger_pause',
    titleEn: 'I pause before reacting when angry.',
    titleAr: 'أتوقف قبل الرد عند الغضب.',
    category: QuestionCategory.angerManagement,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'anger_repair',
    titleEn: 'I apologize and repair after conflict.',
    titleAr: 'أعتذر وأصلح العلاقة بعد الخلاف.',
    category: QuestionCategory.angerManagement,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'communication_direct',
    titleEn: 'I prefer direct communication.',
    titleAr: 'أفضل التواصل المباشر.',
    category: QuestionCategory.communication,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'communication_daily',
    titleEn: 'Daily emotional check-ins matter to me.',
    titleAr: 'المتابعة العاطفية اليومية مهمة لي.',
    category: QuestionCategory.communication,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'finance_budget',
    titleEn: 'Budgeting is essential in marriage.',
    titleAr: 'الميزانية ضرورية في الزواج.',
    category: QuestionCategory.financialMindset,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'finance_saving',
    titleEn: 'Saving should come before luxury spending.',
    titleAr: 'الادخار يسبق المصروفات الكمالية.',
    category: QuestionCategory.financialMindset,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'family_boundaries',
    titleEn: 'A couple needs clear boundaries with relatives.',
    titleAr: 'يحتاج الزوجان إلى حدود واضحة مع الأقارب.',
    category: QuestionCategory.familyBoundaries,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'family_privacy',
    titleEn: 'Private conflicts should stay between the couple first.',
    titleAr: 'الخلافات الخاصة تبقى بين الزوجين أولاً.',
    category: QuestionCategory.familyBoundaries,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'future_children',
    titleEn: 'I want children early in marriage.',
    titleAr: 'أريد إنجاب الأطفال مبكراً بعد الزواج.',
    category: QuestionCategory.futureGoals,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'future_career',
    titleEn: 'Career growth will remain a high priority.',
    titleAr: 'النمو المهني سيظل أولوية كبيرة.',
    category: QuestionCategory.futureGoals,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'responsibility_commitment',
    titleEn: 'I keep promises even when it is difficult.',
    titleAr: 'ألتزم بوعودي حتى عندما يكون الأمر صعباً.',
    category: QuestionCategory.responsibility,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'responsibility_household',
    titleEn: 'Household duties should be shared fairly.',
    titleAr: 'يجب تقاسم مسؤوليات المنزل بعدل.',
    category: QuestionCategory.responsibility,
    mode: ScoringMode.healthyAverage,
  ),
];
