import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/app_state.dart';

class AppStrings {
  static const _values = <String, Map<String, String>>{
    'en': {
      'appName': 'Taalof',
      'tagline': 'Marriage compatibility and family counseling',
      'startAssessment': 'Start assessment',
      'continueAssessment': 'Continue assessment',
      'settings': 'Settings',
      'welcomeTitle': 'Build a clearer marriage decision',
      'welcomeBody':
          'Evaluate personality, emotions, lifestyle, expectations, and family boundaries before marriage.',
      'homeTitle': 'Choose the feature you want to open',
      'homeBody':
          'Start the assessment flow, open the test, review the latest result, or go directly to counseling and settings.',
      'quickAccess': 'Quick access',
      'featurePersonality': 'Open the compatibility questions for both users',
      'featureResults': 'Review the latest calculated compatibility report',
      'featureCounseling': 'Book a counseling or coaching request',
      'featureSettings': 'Change language, theme, and clear saved data',
      'assessmentStatus': 'Assessment status',
      'latestBooking': 'Latest booking',
      'bookingHistory': 'Booking history',
      'bookingHistoryEmpty': 'No booking history yet.',
      'noBookingYet': 'No booking request has been saved yet.',
      'bookingDate': 'Preferred date',
      'bookingType': 'Session type',
      'bookingPhone': 'Phone',
      'bookingMessage': 'Message',
      'viewBookingDetails': 'View booking details',
      'viewBookingHistory': 'View booking history',
      'createdAt': 'Created at',
      'questionnaire': 'Questionnaire',
      'questionnaireProgress': 'Questionnaire progress',
      'scaleHint': '1 = low agreement, 5 = high agreement',
      'personalityIntro':
          'This version uses situational statements and clearer behavior anchors instead of plain generic ratings.',
      'selectClosestAnswer': 'Choose the answer that feels most like you',
      'personalityOnboardingTitle': 'A deeper personality journey',
      'personalityOnboardingBody':
          'This test is built as a staged journey. It reads style, emotional rhythm, conflict habits, and future pressure points instead of collecting flat ratings only.',
      'personalityOnboardingStagesTitle': 'Stage-based flow',
      'personalityOnboardingStagesBody':
          'You move through focused cards instead of one long page, so each block has a clear theme and pace.',
      'personalityOnboardingAdaptiveTitle': 'Adaptive branching',
      'personalityOnboardingAdaptiveBody':
          'Some later stages appear only when your answers reveal a tension, pressure area, or meaningful difference that needs deeper reading.',
      'personalityOnboardingArchetypeTitle': 'Archetype summary',
      'personalityOnboardingArchetypeBody':
          'At the end, each person gets a readable archetype and the relationship gets a clearer dynamic summary.',
      'startPersonalityJourney': 'Start personality journey',
      'resumePersonalityJourney': 'Resume personality journey',
      'restartPersonalityJourney': 'Restart from beginning',
      'stageProgress': 'Stage progress',
      'previousStage': 'Previous',
      'nextStage': 'Next',
      'stageComplete': 'This stage is complete',
      'adaptiveFocusTitle': 'Adaptive focus',
      'adaptiveStagePlanning': 'Planning under change',
      'adaptiveStageAnger': 'Escalation control',
      'adaptiveStageFamily': 'Family pressure handling',
      'adaptiveStageCareer': 'Career and family tradeoffs',
      'categoryAnalysis': 'Category analysis',
      'completeQuestionnaire': 'Complete all questions for both users first',
      'answeredQuestions': 'Answered questions',
      'relationshipDynamics': 'Relationship dynamics',
      'personalityProfile': 'Personality profile',
      'archetypeSummary': 'Archetype summary',
      'personalityMap': 'Visual personality map',
      'mapEnergy': 'Energy style',
      'mapStructure': 'Structure style',
      'mapEmotion': 'Emotional clarity',
      'mapConflict': 'Conflict regulation',
      'completed': 'Completed',
      'pending': 'Pending',
      'userA': 'User A',
      'userB': 'User B',
      'name': 'Name',
      'age': 'Age',
      'job': 'Job',
      'education': 'Education',
      'next': 'Next',
      'saveContinue': 'Save and continue',
      'personalityTest': 'Personality test',
      'result': 'Compatibility result',
      'compatibility': 'Compatibility',
      'readiness': 'Marriage readiness',
      'strengths': 'Strength areas',
      'risks': 'Risk areas',
      'notes': 'Psychological notes',
      'sessions': 'Suggested counseling sessions',
      'bookConsultation': 'Book family consultation',
      'individualTherapy': 'Book individual therapy',
      'coaching': 'Pre-marriage coaching',
      'sessionTypeFamily': 'Family consultation',
      'sessionTypeIndividual': 'Individual therapy',
      'sessionTypeCoaching': 'Pre-marriage coaching',
      'booking': 'Counseling booking',
      'preferredDate': 'Preferred date',
      'phone': 'Phone number',
      'message': 'Message',
      'confirmBooking': 'Confirm booking',
      'bookingSaved': 'Booking request saved locally',
      'pickDate': 'Pick date',
      'appearance': 'Appearance',
      'language': 'Language',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'english': 'English',
      'arabic': 'Arabic',
      'clearData': 'Clear saved assessment',
      'calculate': 'Calculate compatibility',
      'completeProfiles': 'Complete both profiles first',
      'resultEmptyBody':
          'Finish both profiles and answer all questions to generate a compatibility report.',
      'openAssessment': 'Open assessment',
      'fieldRequired': 'This field is required',
      'invalidAge': 'Age must be 18 or above',
      'invalidPhone': 'Enter a valid phone number',
      'selectPreferredDate': 'Select your preferred date',
      'categoryPersonality': 'Personality',
      'categoryEmotionalIntelligence': 'Emotional intelligence',
      'categoryAngerManagement': 'Anger management',
      'categoryCommunication': 'Communication',
      'categoryFinancialMindset': 'Financial mindset',
      'categoryFamilyBoundaries': 'Family boundaries',
      'categoryFutureGoals': 'Future goals',
      'categoryResponsibility': 'Responsibility',
      'noHighRisk': 'No high-risk area detected by the current scoring profile.',
      'noStrongAlignmentYet':
          'Shared effort is visible, but no category is strongly aligned yet.',
      'alignmentLabel': 'alignment',
      'needsStructuredDiscussion': 'needs structured discussion',
      'noteStrongAlignment':
          'The couple shows strong alignment, but expectations should still be discussed explicitly.',
      'noteWorkableCompatibility':
          'The relationship has workable compatibility with several topics needing guided conversation.',
      'noteFragileCompatibility':
          'Compatibility is currently fragile. A counselor should review the main gaps before commitment.',
      'noteAngerManagement':
          'Conflict repair and anger regulation need attention before marriage pressure increases.',
      'noteFamilyBoundaries':
          'Family boundary expectations may cause repeated stress if they remain vague.',
      'noteReadinessThreshold':
          'Marriage readiness is below the recommended threshold for a confident decision.',
      'sessionCommunication': 'Communication and conflict dialogue session',
      'sessionFamilyBoundaries': 'Family boundaries consultation',
      'sessionFuturePlanning':
          'Future planning and financial expectations session',
      'sessionIndividualReadiness':
          'Individual psychological readiness review',
      'sessionAlignment': 'One pre-marriage coaching session for final alignment',
      'profileEnergyOutgoing':
          'Gets energy from people, movement, and visible interaction.',
      'profileEnergyReserved':
          'Recharges better through calm space and lower social intensity.',
      'profileEnergyBalanced':
          'Can enjoy both social activity and quiet recovery time.',
      'profileStructureStructured':
          'Feels safer with planning, clarity, and visible structure.',
      'profileStructureFlexible':
          'Prefers adaptability and keeping room for change.',
      'profileStructureBalanced':
          'Uses structure when needed without becoming rigid.',
      'profileEmotionAware':
          'Usually understands feelings and can express them clearly.',
      'profileEmotionGuarded':
          'May need more time to identify and verbalize emotions.',
      'profileEmotionGrowing':
          'Shows awareness, with room to deepen emotional clarity.',
      'profileConflictSteady':
          'Tends to slow conflict down and repair the connection.',
      'profileConflictReactive':
          'May react quickly under pressure before calming down.',
      'profileConflictDeveloping':
          'Shows mixed conflict habits and can improve with practice.',
      'dynamicEnergyAligned':
          'Their social pace is naturally close, so shared routines may feel easier.',
      'dynamicEnergyBridge':
          'Their social energy differs enough that they will need intentional balance.',
      'dynamicPlanningAligned':
          'They approach structure and planning at a similar pace.',
      'dynamicPlanningBridge':
          'Their planning style differs, so expectations should be negotiated early.',
      'dynamicRepairStrong':
          'Their conflict-repair capacity looks strong and protective for the relationship.',
      'dynamicRepairFragile':
          'Conflict repair looks fragile and needs conscious work before stress rises.',
      'dynamicRepairDeveloping':
          'Repair skills exist, but the relationship will benefit from clearer conflict habits.',
      'archetypePlanner': 'Planner',
      'archetypeFlexible': 'Flexible',
      'archetypeBalanced': 'Balanced',
      'archetypeWarmCommunicator': 'Warm Communicator',
      'archetypeReflectivePartner': 'Reflective Partner',
      'archetypeSteadyResponder': 'Steady Responder',
      'archetypeDirectProcessor': 'Direct Processor',
      'localOnly': 'Local prototype. Firebase can be connected later.',
    },
    'ar': {
      'appName': 'Taalof',
      'tagline': 'توافق الزواج والاستشارات الأسرية',
      'startAssessment': 'ابدأ التقييم',
      'continueAssessment': 'استكمال التقييم',
      'settings': 'الإعدادات',
      'welcomeTitle': 'اتخذ قرار زواج أوضح',
      'welcomeBody':
          'قيّم الشخصية والمشاعر ونمط الحياة والتوقعات والحدود الأسرية قبل الزواج.',
      'homeTitle': 'اختر الميزة التي تريد فتحها',
      'homeBody':
          'ابدأ التقييم، وافتح الاختبار، وراجع آخر نتيجة، أو ادخل مباشرة إلى الحجز والإعدادات.',
      'quickAccess': 'وصول سريع',
      'featurePersonality': 'افتح أسئلة التوافق للشخصين',
      'featureResults': 'راجع آخر تقرير توافق تم حسابه',
      'featureCounseling': 'أرسل طلب حجز استشارة أو جلسة تأهيل',
      'featureSettings': 'غيّر اللغة والمظهر وامسح البيانات المحفوظة',
      'assessmentStatus': 'حالة التقييم',
      'latestBooking': 'آخر طلب حجز',
      'bookingHistory': 'سجل الحجوزات',
      'bookingHistoryEmpty': 'لا يوجد سجل حجوزات حتى الآن.',
      'noBookingYet': 'لا يوجد طلب حجز محفوظ حتى الآن.',
      'bookingDate': 'الموعد المفضل',
      'bookingType': 'نوع الجلسة',
      'bookingPhone': 'الهاتف',
      'bookingMessage': 'الرسالة',
      'viewBookingDetails': 'عرض تفاصيل الحجز',
      'viewBookingHistory': 'عرض سجل الحجوزات',
      'createdAt': 'تاريخ الإنشاء',
      'questionnaire': 'الاستبيان',
      'questionnaireProgress': 'تقدم الاستبيان',
      'scaleHint': '1 = موافقة منخفضة، 5 = موافقة عالية',
      'personalityIntro':
          'هذه النسخة تعتمد على مواقف سلوكية وحدود أوضح للإجابة بدل التقييمات العامة التقليدية.',
      'selectClosestAnswer': 'اختر الإجابة الأقرب لطبيعتك',
      'personalityOnboardingTitle': 'رحلة شخصية أعمق',
      'personalityOnboardingBody':
          'هذا الاختبار مبني كرحلة على مراحل. يقرأ أسلوب الشخصية والإيقاع العاطفي وعادات الخلاف ونقاط الضغط المستقبلية بدل جمع تقييمات سطحية فقط.',
      'personalityOnboardingStagesTitle': 'تدفق على مراحل',
      'personalityOnboardingStagesBody':
          'ستتحرك بين بطاقات مركزة بدل صفحة طويلة واحدة، بحيث يكون لكل جزء موضوع وإيقاع واضح.',
      'personalityOnboardingAdaptiveTitle': 'تفرع ذكي',
      'personalityOnboardingAdaptiveBody':
          'بعض المراحل اللاحقة تظهر فقط عندما تكشف الإجابات عن توتر أو ضغط أو اختلاف يستحق قراءة أعمق.',
      'personalityOnboardingArchetypeTitle': 'ملخص النمط',
      'personalityOnboardingArchetypeBody':
          'في النهاية يحصل كل طرف على نمط واضح وتظهر ديناميكية العلاقة بصورة أقرب للحقيقة.',
      'startPersonalityJourney': 'ابدأ رحلة الشخصية',
      'resumePersonalityJourney': 'استكمل رحلة الشخصية',
      'restartPersonalityJourney': 'ابدأ من البداية',
      'stageProgress': 'تقدم المراحل',
      'previousStage': 'السابق',
      'nextStage': 'التالي',
      'stageComplete': 'هذه المرحلة مكتملة',
      'adaptiveFocusTitle': 'تركيز متكيف',
      'adaptiveStagePlanning': 'التخطيط وقت التغيير',
      'adaptiveStageAnger': 'التحكم في التصعيد',
      'adaptiveStageFamily': 'التعامل مع ضغط العائلة',
      'adaptiveStageCareer': 'موازنة العمل والأسرة',
      'categoryAnalysis': 'تحليل الفئات',
      'completeQuestionnaire': 'أكمل كل الأسئلة للشخصين أولاً',
      'answeredQuestions': 'الأسئلة المجابة',
      'relationshipDynamics': 'ديناميكية العلاقة',
      'personalityProfile': 'الملف الشخصي',
      'archetypeSummary': 'ملخص النمط',
      'personalityMap': 'الخريطة البصرية للشخصية',
      'mapEnergy': 'أسلوب الطاقة',
      'mapStructure': 'أسلوب النظام',
      'mapEmotion': 'الوضوح العاطفي',
      'mapConflict': 'تنظيم الخلاف',
      'completed': 'مكتمل',
      'pending': 'قيد الانتظار',
      'userA': 'الشخص الأول',
      'userB': 'الشخص الثاني',
      'name': 'الاسم',
      'age': 'العمر',
      'job': 'الوظيفة',
      'education': 'التعليم',
      'next': 'التالي',
      'saveContinue': 'حفظ ومتابعة',
      'personalityTest': 'اختبار الشخصية',
      'result': 'نتيجة التوافق',
      'compatibility': 'التوافق',
      'readiness': 'جاهزية الزواج',
      'strengths': 'نقاط القوة',
      'risks': 'مناطق الخطر',
      'notes': 'ملاحظات نفسية',
      'sessions': 'جلسات مقترحة',
      'bookConsultation': 'حجز استشارة أسرية',
      'individualTherapy': 'حجز علاج فردي',
      'coaching': 'جلسات تأهيل قبل الزواج',
      'sessionTypeFamily': 'استشارة أسرية',
      'sessionTypeIndividual': 'علاج فردي',
      'sessionTypeCoaching': 'تأهيل قبل الزواج',
      'booking': 'حجز استشارة',
      'preferredDate': 'الموعد المفضل',
      'phone': 'رقم الهاتف',
      'message': 'رسالة',
      'confirmBooking': 'تأكيد الحجز',
      'bookingSaved': 'تم حفظ طلب الحجز محلياً',
      'pickDate': 'اختر التاريخ',
      'appearance': 'المظهر',
      'language': 'اللغة',
      'light': 'فاتح',
      'dark': 'داكن',
      'system': 'النظام',
      'english': 'English',
      'arabic': 'العربية',
      'clearData': 'مسح التقييم المحفوظ',
      'calculate': 'حساب التوافق',
      'completeProfiles': 'أكمل بيانات الشخصين أولاً',
      'resultEmptyBody':
          'أكمل بيانات الشخصين وأجب عن كل الأسئلة لتوليد تقرير التوافق.',
      'openAssessment': 'افتح التقييم',
      'fieldRequired': 'هذا الحقل مطلوب',
      'invalidAge': 'يجب أن يكون العمر 18 سنة أو أكثر',
      'invalidPhone': 'أدخل رقم هاتف صحيح',
      'selectPreferredDate': 'اختر موعدك المفضل',
      'categoryPersonality': 'الشخصية',
      'categoryEmotionalIntelligence': 'الذكاء العاطفي',
      'categoryAngerManagement': 'إدارة الغضب',
      'categoryCommunication': 'التواصل',
      'categoryFinancialMindset': 'التفكير المالي',
      'categoryFamilyBoundaries': 'الحدود الأسرية',
      'categoryFutureGoals': 'الأهداف المستقبلية',
      'categoryResponsibility': 'المسؤولية',
      'noHighRisk': 'لا توجد منطقة خطورة عالية حسب التقييم الحالي.',
      'noStrongAlignmentYet':
          'يوجد مجهود مشترك واضح، لكن لا توجد فئة متوافقة بقوة حتى الآن.',
      'alignmentLabel': 'توافق',
      'needsStructuredDiscussion': 'تحتاج إلى نقاش منظم',
      'noteStrongAlignment':
          'يوجد انسجام قوي بين الطرفين، لكن ما زال من المهم مناقشة التوقعات بوضوح.',
      'noteWorkableCompatibility':
          'العلاقة قابلة للنجاح، لكن توجد موضوعات تحتاج إلى حوار موجّه.',
      'noteFragileCompatibility':
          'التوافق الحالي هش، ويُفضل مراجعة الفجوات الأساسية مع مختص قبل اتخاذ قرار الارتباط.',
      'noteAngerManagement':
          'إدارة الغضب وإصلاح الخلافات تحتاج إلى اهتمام قبل زيادة ضغوط الزواج.',
      'noteFamilyBoundaries':
          'توقعات الحدود الأسرية قد تسبب ضغطاً متكرراً إذا ظلت غير واضحة.',
      'noteReadinessThreshold':
          'جاهزية الزواج أقل من الحد الموصى به لاتخاذ قرار مطمئن.',
      'sessionCommunication': 'جلسة تواصل وحوار وقت الخلاف',
      'sessionFamilyBoundaries': 'جلسة استشارة للحدود الأسرية',
      'sessionFuturePlanning': 'جلسة للتخطيط المستقبلي والتوقعات المالية',
      'sessionIndividualReadiness': 'مراجعة فردية للجاهزية النفسية',
      'sessionAlignment': 'جلسة تأهيل قبل الزواج للمراجعة النهائية',
      'profileEnergyOutgoing':
          'يستمد طاقته من الناس والحركة والتفاعل الواضح.',
      'profileEnergyReserved':
          'يستعيد طاقته بشكل أفضل عبر الهدوء وتقليل الكثافة الاجتماعية.',
      'profileEnergyBalanced':
          'يستمتع بالتفاعل الاجتماعي وبالوقت الهادئ أيضًا.',
      'profileStructureStructured':
          'يشعر بالأمان أكثر مع التخطيط والوضوح والنظام.',
      'profileStructureFlexible':
          'يفضل المرونة وترك مساحة للتغيير.',
      'profileStructureBalanced':
          'يستخدم النظام عند الحاجة بدون جمود زائد.',
      'profileEmotionAware':
          'يفهم مشاعره غالبًا ويستطيع التعبير عنها بوضوح.',
      'profileEmotionGuarded':
          'قد يحتاج وقتًا أكبر لفهم مشاعره والتعبير عنها.',
      'profileEmotionGrowing':
          'يمتلك وعيًا جيدًا مع مساحة لتعميق الوضوح العاطفي.',
      'profileConflictSteady':
          'يميل إلى تهدئة الخلاف وإصلاح العلاقة.',
      'profileConflictReactive':
          'قد يتفاعل بسرعة تحت الضغط قبل أن يهدأ.',
      'profileConflictDeveloping':
          'عادات الخلاف لديه مختلطة ويمكن تطويرها بالممارسة.',
      'dynamicEnergyAligned':
          'الإيقاع الاجتماعي بينهما متقارب، وهذا يسهل بناء روتين مشترك.',
      'dynamicEnergyBridge':
          'الطاقة الاجتماعية بينهما مختلفة بما يكفي لتحتاج إلى توازن واعٍ.',
      'dynamicPlanningAligned':
          'يتعاملان مع التخطيط والنظام بوتيرة متقاربة.',
      'dynamicPlanningBridge':
          'أسلوب التخطيط بينهما مختلف، لذلك يجب الاتفاق على التوقعات مبكرًا.',
      'dynamicRepairStrong':
          'قدرة الطرفين على إصلاح الخلاف تبدو قوية وتحمي العلاقة.',
      'dynamicRepairFragile':
          'إصلاح الخلاف يبدو هشًا ويحتاج عملًا واعيًا قبل زيادة الضغوط.',
      'dynamicRepairDeveloping':
          'توجد مهارات إصلاح، لكن العلاقة ستستفيد من عادات أوضح وقت الخلاف.',
      'archetypePlanner': 'المخطط',
      'archetypeFlexible': 'المرن',
      'archetypeBalanced': 'المتوازن',
      'archetypeWarmCommunicator': 'المتواصل الدافئ',
      'archetypeReflectivePartner': 'الشريك المتأمل',
      'archetypeSteadyResponder': 'الهادئ في الاستجابة',
      'archetypeDirectProcessor': 'المباشر في المعالجة',
      'localOnly': 'نموذج محلي. يمكن ربط Firebase لاحقاً.',
    },
  };

  static String of(BuildContext context, String key) {
    final languageCode = context.watch<AppState>().languageCode;
    return _values[languageCode]?[key] ?? _values['en']?[key] ?? key;
  }
}

extension AppStringsContext on BuildContext {
  String tr(String key) => AppStrings.of(this, key);
}
