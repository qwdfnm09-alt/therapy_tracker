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
    required this.lowAnchorEn,
    required this.lowAnchorAr,
    required this.highAnchorEn,
    required this.highAnchorAr,
    required this.category,
    required this.mode,
    this.dependsOnQuestionId,
    this.showIfAnyAtLeast,
    this.showIfAnyAtMost,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String lowAnchorEn;
  final String lowAnchorAr;
  final String highAnchorEn;
  final String highAnchorAr;
  final QuestionCategory category;
  final ScoringMode mode;
  final String? dependsOnQuestionId;
  final int? showIfAnyAtLeast;
  final int? showIfAnyAtMost;

  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;

  String lowAnchor(String languageCode) =>
      languageCode == 'ar' ? lowAnchorAr : lowAnchorEn;

  String highAnchor(String languageCode) =>
      languageCode == 'ar' ? highAnchorAr : highAnchorEn;
}

const compatibilityQuestions = <CompatibilityQuestion>[
  CompatibilityQuestion(
    id: 'personality_social_energy',
    titleEn: 'After a demanding week, I recharge best by going out and staying around people.',
    titleAr: 'بعد أسبوع مرهق، أستعيد طاقتي أكثر عندما أخرج وأكون وسط الناس.',
    lowAnchorEn: 'Quiet time alone',
    lowAnchorAr: 'وقت هادئ بمفردي',
    highAnchorEn: 'People and activity',
    highAnchorAr: 'ناس وحركة',
    category: QuestionCategory.personality,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'personality_structure',
    titleEn: 'When life gets busy, I feel safer when there is a clear plan and structure.',
    titleAr: 'عندما تصبح الحياة مزدحمة، أشعر براحة أكبر عندما توجد خطة واضحة ونظام.',
    lowAnchorEn: 'Keep things open',
    lowAnchorAr: 'أترك الأمور مفتوحة',
    highAnchorEn: 'Need clear structure',
    highAnchorAr: 'أحتاج نظامًا واضحًا',
    category: QuestionCategory.personality,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'personality_structure_shift',
    titleEn:
        'If plans change suddenly, I can adapt without turning the whole day tense.',
    titleAr:
        'إذا تغيرت الخطط فجأة، أستطيع التكيف بدون أن يتحول اليوم كله إلى توتر.',
    lowAnchorEn: 'Sudden change drains me',
    lowAnchorAr: 'التغيير المفاجئ يرهقني',
    highAnchorEn: 'I adapt smoothly',
    highAnchorAr: 'أتكيف بسهولة',
    category: QuestionCategory.personality,
    mode: ScoringMode.healthyAverage,
    dependsOnQuestionId: 'personality_structure',
    showIfAnyAtLeast: 4,
  ),
  CompatibilityQuestion(
    id: 'emotion_self_awareness',
    titleEn: 'In tense moments, I can usually explain what I am feeling and why.',
    titleAr: 'في اللحظات المتوترة، أستطيع غالبًا شرح ما أشعر به ولماذا.',
    lowAnchorEn: 'Feelings are hard to name',
    lowAnchorAr: 'يصعب عليّ تسمية مشاعري',
    highAnchorEn: 'I name them clearly',
    highAnchorAr: 'أحددها بوضوح',
    category: QuestionCategory.emotionalIntelligence,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'emotion_empathy',
    titleEn: 'If my partner is upset, my first instinct is to understand before I respond.',
    titleAr: 'إذا كان شريك حياتي منزعجًا، فغريزتي الأولى هي أن أفهم قبل أن أرد.',
    lowAnchorEn: 'React first',
    lowAnchorAr: 'أرد أولًا',
    highAnchorEn: 'Listen deeply first',
    highAnchorAr: 'أستمع بعمق أولًا',
    category: QuestionCategory.emotionalIntelligence,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'anger_pause',
    titleEn: 'When I am angry, I can pause instead of reacting immediately.',
    titleAr: 'عندما أغضب، أستطيع التوقف بدلًا من الرد الفوري.',
    lowAnchorEn: 'I react quickly',
    lowAnchorAr: 'أرد بسرعة',
    highAnchorEn: 'I pause first',
    highAnchorAr: 'أتوقف أولًا',
    category: QuestionCategory.angerManagement,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'anger_repair',
    titleEn: 'After conflict, I tend to repair the connection instead of leaving distance unresolved.',
    titleAr: 'بعد الخلاف، أميل إلى إصلاح العلاقة بدل ترك المسافة والتوتر بدون حل.',
    lowAnchorEn: 'Repair takes time',
    lowAnchorAr: 'أحتاج وقتًا طويلًا للإصلاح',
    highAnchorEn: 'I repair quickly',
    highAnchorAr: 'أبادر بالإصلاح بسرعة',
    category: QuestionCategory.angerManagement,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'anger_escalation',
    titleEn:
        'If an argument gets sharper, I can stop escalation before saying something damaging.',
    titleAr:
        'إذا أصبح الخلاف أكثر حدة، أستطيع إيقاف التصعيد قبل قول شيء مؤذٍ.',
    lowAnchorEn: 'Escalation happens fast',
    lowAnchorAr: 'التصعيد يحدث بسرعة',
    highAnchorEn: 'I de-escalate early',
    highAnchorAr: 'أهدئ الموقف مبكرًا',
    category: QuestionCategory.angerManagement,
    mode: ScoringMode.healthyAverage,
    dependsOnQuestionId: 'anger_pause',
    showIfAnyAtMost: 2,
  ),
  CompatibilityQuestion(
    id: 'communication_direct',
    titleEn: 'When something matters, I prefer saying it clearly instead of hinting.',
    titleAr: 'عندما يكون الأمر مهمًا، أفضل أن أقوله بوضوح بدل التلميح.',
    lowAnchorEn: 'Indirect or subtle',
    lowAnchorAr: 'غير مباشر أو بالتلميح',
    highAnchorEn: 'Clear and direct',
    highAnchorAr: 'واضح ومباشر',
    category: QuestionCategory.communication,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'communication_daily',
    titleEn: 'Frequent emotional check-ins help me feel secure in a relationship.',
    titleAr: 'المتابعة العاطفية المتكررة تجعلني أشعر بالأمان داخل العلاقة.',
    lowAnchorEn: 'Need space most days',
    lowAnchorAr: 'أحتاج مساحة أغلب الأيام',
    highAnchorEn: 'Need regular check-ins',
    highAnchorAr: 'أحتاج متابعة منتظمة',
    category: QuestionCategory.communication,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'finance_budget',
    titleEn: 'Shared money feels healthiest when there is a clear budget and visible plan.',
    titleAr: 'المال المشترك يكون أكثر استقرارًا عندما توجد ميزانية واضحة وخطة ظاهرة.',
    lowAnchorEn: 'Flexible spending',
    lowAnchorAr: 'الإنفاق المرن',
    highAnchorEn: 'Clear budget',
    highAnchorAr: 'ميزانية واضحة',
    category: QuestionCategory.financialMindset,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'finance_saving',
    titleEn: 'When income arrives, I prefer protecting savings before comfort spending.',
    titleAr: 'عندما يدخل الدخل، أفضل حماية الادخار قبل مصروفات الراحة والكماليات.',
    lowAnchorEn: 'Enjoy now first',
    lowAnchorAr: 'أستمتع الآن أولًا',
    highAnchorEn: 'Save first',
    highAnchorAr: 'أدخر أولًا',
    category: QuestionCategory.financialMindset,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'family_boundaries',
    titleEn: 'A healthy marriage needs clear boundaries between the couple and extended family.',
    titleAr: 'الزواج الصحي يحتاج حدودًا واضحة بين الزوجين والعائلة الممتدة.',
    lowAnchorEn: 'Family stays deeply involved',
    lowAnchorAr: 'العائلة تبقى متدخلة بقوة',
    highAnchorEn: 'Couple boundaries first',
    highAnchorAr: 'حدود الزوجين أولًا',
    category: QuestionCategory.familyBoundaries,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'family_privacy',
    titleEn: 'Private conflict should usually be handled by the couple before others get involved.',
    titleAr: 'الخلاف الخاص يُفضل غالبًا أن يعالجه الزوجان قبل تدخل الآخرين.',
    lowAnchorEn: 'Ask others early',
    lowAnchorAr: 'أطلب تدخل الآخرين مبكرًا',
    highAnchorEn: 'Keep it private first',
    highAnchorAr: 'أحافظ على خصوصيته أولًا',
    category: QuestionCategory.familyBoundaries,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'family_interference',
    titleEn:
        'If relatives interfere in a private decision, I can still protect the couple\'s final word.',
    titleAr:
        'إذا تدخل الأقارب في قرار خاص، أستطيع رغم ذلك حماية الكلمة الأخيرة للزوجين.',
    lowAnchorEn: 'Family pressure leads',
    lowAnchorAr: 'ضغط العائلة يقود القرار',
    highAnchorEn: 'Couple decision stays central',
    highAnchorAr: 'قرار الزوجين يظل الأساس',
    category: QuestionCategory.familyBoundaries,
    mode: ScoringMode.healthyAverage,
    dependsOnQuestionId: 'family_boundaries',
    showIfAnyAtMost: 2,
  ),
  CompatibilityQuestion(
    id: 'future_children',
    titleEn: 'If marriage happens soon, I would prefer to move toward children early.',
    titleAr: 'إذا تم الزواج قريبًا، فأنا أميل إلى التوجه مبكرًا نحو الإنجاب.',
    lowAnchorEn: 'No rush',
    lowAnchorAr: 'لا أريد التسرع',
    highAnchorEn: 'Early children matter',
    highAnchorAr: 'الإنجاب المبكر مهم',
    category: QuestionCategory.futureGoals,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'future_career',
    titleEn: 'Over the next few years, career growth will stay a major priority in my decisions.',
    titleAr: 'خلال السنوات القادمة، سيظل النمو المهني أولوية كبيرة في قراراتي.',
    lowAnchorEn: 'Career can slow down',
    lowAnchorAr: 'يمكن تهدئة المسار المهني',
    highAnchorEn: 'Career stays a priority',
    highAnchorAr: 'العمل يظل أولوية',
    category: QuestionCategory.futureGoals,
    mode: ScoringMode.similarity,
  ),
  CompatibilityQuestion(
    id: 'future_career_tradeoff',
    titleEn:
        'If career and family timing clash, I am ready to negotiate openly instead of assuming my path comes first.',
    titleAr:
        'إذا تعارض توقيت العمل والأسرة، فأنا مستعد للتفاوض بصراحة بدل افتراض أن طريقي يأتي أولًا.',
    lowAnchorEn: 'My path stays fixed',
    lowAnchorAr: 'طريقي يظل ثابتًا',
    highAnchorEn: 'I negotiate priorities openly',
    highAnchorAr: 'أتفاوض على الأولويات بصراحة',
    category: QuestionCategory.futureGoals,
    mode: ScoringMode.healthyAverage,
    dependsOnQuestionId: 'future_career',
    showIfAnyAtLeast: 4,
  ),
  CompatibilityQuestion(
    id: 'responsibility_commitment',
    titleEn: 'When life gets hard, I still see keeping promises as part of my character.',
    titleAr: 'عندما تصبح الحياة صعبة، أعتبر الوفاء بالوعود جزءًا من شخصيتي.',
    lowAnchorEn: 'Promises shift with pressure',
    lowAnchorAr: 'الوعود تتغير مع الضغط',
    highAnchorEn: 'I keep commitments firmly',
    highAnchorAr: 'ألتزم بوعودي بثبات',
    category: QuestionCategory.responsibility,
    mode: ScoringMode.healthyAverage,
  ),
  CompatibilityQuestion(
    id: 'responsibility_household',
    titleEn: 'A stable home needs clear and fair sharing of daily responsibilities.',
    titleAr: 'البيت المستقر يحتاج إلى تقاسم واضح وعادل للمسؤوليات اليومية.',
    lowAnchorEn: 'Roles form naturally',
    lowAnchorAr: 'الأدوار تتشكل تلقائيًا',
    highAnchorEn: 'Fair division matters',
    highAnchorAr: 'التقسيم العادل مهم',
    category: QuestionCategory.responsibility,
    mode: ScoringMode.healthyAverage,
  ),
];
