import '../../domain/models/content_item.dart';

class StaticContentRepository {
  const StaticContentRepository();

  List<ContentItem> premaritalGuide() {
    return const [
      ContentItem(
        titleEn: 'Use the result as a discussion map',
        titleAr: 'استخدم النتيجة كخريطة للنقاش',
        bodyEn:
            'The percentage is not the decision by itself. The useful part is the list of pressure points and what both people need to clarify before engagement.',
        bodyAr:
            'النسبة ليست القرار في حد ذاتها. القيمة الحقيقية هي نقاط الضغط وما الذي يحتاجه الطرفان من توضيح قبل الارتباط.',
        tagEn: 'First step',
        tagAr: 'الخطوة الأولى',
      ),
      ContentItem(
        titleEn: 'Discuss money and family early',
        titleAr: 'ناقش المال والعائلة مبكرًا',
        bodyEn:
            'Financial habits and family boundaries create repeated conflict when they stay vague. Push these topics forward instead of leaving them to goodwill.',
        bodyAr:
            'عادات المال وحدود العائلة تصنع خلافات متكررة إذا ظلت غامضة. قدّم هذه الموضوعات للنقاش ولا تؤجلها بحسن النية فقط.',
        tagEn: 'Core topic',
        tagAr: 'موضوع أساسي',
      ),
      ContentItem(
        titleEn: 'Watch repair, not only romance',
        titleAr: 'راقبوا طريقة الإصلاح لا الرومانسية فقط',
        bodyEn:
            'A stable relationship is not the one with zero disagreement. It is the one where both people can pause, repair, and return to respectful dialogue.',
        bodyAr:
            'العلاقة المستقرة ليست التي بلا خلاف، بل التي يستطيع فيها الطرفان التوقف والإصلاح والعودة إلى حوار محترم.',
        tagEn: 'Practical lens',
        tagAr: 'منظور عملي',
      ),
      ContentItem(
        titleEn: 'Write down the non-negotiables',
        titleAr: 'اكتب الخطوط غير القابلة للتنازل',
        bodyEn:
            'Each person should define what cannot stay implicit: work priorities, children, housing, privacy, debt, and responsibilities.',
        bodyAr:
            'من المهم أن يحدد كل طرف ما لا يصح أن يظل ضمنيًا: العمل، الأطفال، السكن، الخصوصية، الديون، والمسؤوليات.',
        tagEn: 'Before engagement',
        tagAr: 'قبل الخطوبة',
      ),
    ];
  }

  List<ContentSection> goldenQuestionSections() {
    return const [
      ContentSection(
        titleEn: 'Values and life direction',
        titleAr: 'القيم واتجاه الحياة',
        descriptionEn:
            'Questions that surface the operating principles behind daily choices.',
        descriptionAr:
            'أسئلة تكشف المبادئ التي تحكم القرارات اليومية واتجاه الحياة.',
        items: [
          ContentItem(
            titleEn: 'What does a successful marriage look like to you?',
            titleAr: 'ما شكل الزواج الناجح من وجهة نظرك؟',
            bodyEn:
                'Look for the model behind the answer: companionship, stability, duty, affection, status, or teamwork.',
            bodyAr:
                'ابحث عن النموذج الكامن خلف الإجابة: صحبة، استقرار، واجب، مودة، مكانة اجتماعية، أم شراكة فعلية.',
          ),
          ContentItem(
            titleEn: 'What priorities should never be sacrificed?',
            titleAr: 'ما الأولويات التي لا تقبل التنازل؟',
            bodyEn:
                'This reveals hidden absolutes around religion, family, work, privacy, or lifestyle.',
            bodyAr:
                'هذا السؤال يكشف الثوابت الخفية حول الدين أو العائلة أو العمل أو الخصوصية أو نمط الحياة.',
          ),
          ContentItem(
            titleEn: 'How do you define fairness inside the home?',
            titleAr: 'كيف تعرّف العدل داخل البيت؟',
            bodyEn:
                'Useful for exposing assumptions around roles, effort, and what each side believes is naturally owed.',
            bodyAr:
                'سؤال مهم لإظهار الافتراضات المتعلقة بالأدوار وحجم الجهد وما يراه كل طرف حقًا طبيعيًا له أو عليه.',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Money and practical decisions',
        titleAr: 'المال والقرارات العملية',
        descriptionEn:
            'Questions that reduce later surprises around spending and pressure.',
        descriptionAr: 'أسئلة تقلل المفاجآت اللاحقة في الإنفاق والضغط العملي.',
        items: [
          ContentItem(
            titleEn: 'How should budgeting decisions be made?',
            titleAr: 'كيف يجب اتخاذ قرارات الميزانية؟',
            bodyEn:
                'Clarify whether decisions are joint, delegated, transparent, or emotionally driven.',
            bodyAr:
                'وضّح هل القرارات مشتركة أم مفوضة أم شفافة أم متروكة للانفعال والظروف.',
          ),
          ContentItem(
            titleEn: 'What kind of debt is acceptable?',
            titleAr: 'ما نوع الديون المقبول؟',
            bodyEn:
                'A vague answer here often becomes stress later. Ask for concrete limits and examples.',
            bodyAr:
                'الغموض هنا يتحول غالبًا إلى ضغط لاحق. اطلب حدودًا واضحة وأمثلة عملية.',
          ),
          ContentItem(
            titleEn:
                'If income changes suddenly, what should be protected first?',
            titleAr: 'إذا تغير الدخل فجأة، ما الذي يجب حمايته أولاً؟',
            bodyEn:
                'This reveals what each person protects first: savings, appearance, comfort, obligations, or family support.',
            bodyAr:
                'هذا السؤال يكشف ما الذي يحميه كل طرف أولاً: الادخار، المظهر، الراحة، الالتزامات، أم دعم العائلة.',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Family and boundaries',
        titleAr: 'العائلة والحدود',
        descriptionEn:
            'Questions that help both sides prevent repeated interference and resentment.',
        descriptionAr:
            'أسئلة تساعد الطرفين على منع التدخل المتكرر وتراكم الاستياء.',
        items: [
          ContentItem(
            titleEn:
                'When should family step in, and when should they stay out?',
            titleAr: 'متى تتدخل العائلة ومتى يجب أن تبقى خارج الخلاف؟',
            bodyEn: 'Ask for real scenarios, not ideal slogans.',
            bodyAr: 'اطلب مواقف واقعية لا شعارات مثالية فقط.',
          ),
          ContentItem(
            titleEn: 'How much privacy should the couple keep?',
            titleAr: 'ما مقدار الخصوصية الذي يجب أن يحتفظ به الزوجان؟',
            bodyEn:
                'The gap here matters more than the average answer. Watch for rigid or culturally assumed defaults.',
            bodyAr:
                'الفارق هنا أهم من متوسط الإجابة. راقب الافتراضات الجامدة أو الموروثة باعتبارها بديهيات.',
          ),
          ContentItem(
            titleEn:
                'What happens if parents disagree with a private decision?',
            titleAr: 'ماذا يحدث إذا اعترض الأهل على قرار خاص؟',
            bodyEn:
                'This exposes whether the final word belongs to the couple in practice or only in theory.',
            bodyAr: 'هذا يكشف هل الكلمة الأخيرة للزوجين عمليًا أم نظريًا فقط.',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Conflict and repair',
        titleAr: 'الخلاف والإصلاح',
        descriptionEn:
            'Questions that test emotional regulation, not just nice intentions.',
        descriptionAr: 'أسئلة تختبر تنظيم الانفعال لا مجرد النوايا الطيبة.',
        items: [
          ContentItem(
            titleEn: 'What do you usually do when you are angry?',
            titleAr: 'ماذا تفعل عادة عندما تغضب؟',
            bodyEn:
                'Listen for behavior, not labels. The useful answer includes pause, apology, repair, or escalation patterns.',
            bodyAr:
                'استمع إلى السلوك لا إلى الوصف العام. الإجابة المفيدة تكشف التوقف أو الاعتذار أو الإصلاح أو التصعيد.',
          ),
          ContentItem(
            titleEn: 'How do you want a disagreement to end?',
            titleAr: 'كيف تريد أن ينتهي الخلاف؟',
            bodyEn:
                'This question reveals whether the goal is truth, victory, emotional safety, or temporary silence.',
            bodyAr:
                'هذا السؤال يكشف هل الهدف هو الحقيقة أم الانتصار أم الأمان العاطفي أم مجرد الصمت المؤقت.',
          ),
          ContentItem(
            titleEn:
                'What words or behaviors are completely unacceptable in conflict?',
            titleAr: 'ما الكلمات أو التصرفات غير المقبولة تمامًا وقت الخلاف؟',
            bodyEn:
                'The answer defines the couple’s red lines before the first major pressure cycle.',
            bodyAr:
                'الإجابة تحدد الخطوط الحمراء قبل أول دورة ضغط كبيرة داخل العلاقة.',
          ),
        ],
      ),
    ];
  }

  List<ContentSection> redFlagSections() {
    return const [
      ContentSection(
        titleEn: 'Behavioral warning signs',
        titleAr: 'علامات سلوكية مقلقة',
        descriptionEn:
            'Patterns that usually get worse under pressure if they stay unnamed.',
        descriptionAr: 'أنماط تتفاقم غالبًا مع الضغط إذا ظلت بلا تسمية واضحة.',
        items: [
          ContentItem(
            titleEn: 'Repeated contempt or belittling',
            titleAr: 'الاحتقار أو التقليل المتكرر',
            bodyEn:
                'Mocking, insulting, or treating the other person as mentally smaller is not a style issue. It is a structural risk.',
            bodyAr:
                'السخرية أو الإهانة أو معاملة الطرف الآخر باعتباره أقل شأنًا ليست اختلاف أسلوب، بل خطر بنيوي في العلاقة.',
            tagEn: 'High risk',
            tagAr: 'خطورة عالية',
          ),
          ContentItem(
            titleEn: 'Fast escalation with no repair',
            titleAr: 'تصعيد سريع بلا إصلاح',
            bodyEn:
                'Anger alone is not the whole problem. The bigger issue is the absence of pause, apology, or repair afterward.',
            bodyAr:
                'الغضب وحده ليس كل المشكلة، بل غياب التوقف أو الاعتذار أو الإصلاح بعده.',
            tagEn: 'High risk',
            tagAr: 'خطورة عالية',
          ),
          ContentItem(
            titleEn: 'Control framed as care',
            titleAr: 'التحكم المتخفي في صورة اهتمام',
            bodyEn:
                'When surveillance, pressure, or isolation is explained as love, the relationship needs closer examination.',
            bodyAr:
                'عندما يُقدَّم التتبع أو الضغط أو العزل باعتباره حبًا، فالعلاقة تحتاج فحصًا أدق.',
            tagEn: 'Watch closely',
            tagAr: 'يحتاج انتباهًا',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Family and social pressure',
        titleAr: 'ضغط العائلة والمجتمع',
        descriptionEn:
            'These signs usually appear early but are often normalized too quickly.',
        descriptionAr:
            'هذه العلامات تظهر مبكرًا غالبًا لكن يجري تطبيعها بسرعة.',
        items: [
          ContentItem(
            titleEn: 'No real boundaries with family',
            titleAr: 'غياب حدود حقيقية مع العائلة',
            bodyEn:
                'If private decisions keep returning to family approval, marriage will struggle to form its own center.',
            bodyAr:
                'إذا ظلت القرارات الخاصة تعود إلى موافقة العائلة، فسيصعب على الزواج أن يبني مركزه الخاص.',
          ),
          ContentItem(
            titleEn: 'Public image matters more than private health',
            titleAr: 'الصورة أمام الناس أهم من سلامة العلاقة',
            bodyEn:
                'This often leads to denial, silence, and delayed intervention.',
            bodyAr:
                'هذا يقود غالبًا إلى الإنكار والصمت وتأخير التدخل في الوقت المناسب.',
          ),
          ContentItem(
            titleEn: 'One side cannot disagree safely',
            titleAr: 'أحد الطرفين لا يستطيع الاختلاف بأمان',
            bodyEn:
                'If honest disagreement feels dangerous, the relationship is already paying a hidden cost.',
            bodyAr:
                'إذا أصبح الاختلاف الصريح يشعر أحد الطرفين بالخطر، فالعلاقة تدفع ثمنًا خفيًا بالفعل.',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Practical and future red flags',
        titleAr: 'علامات حمراء عملية ومستقبلية',
        descriptionEn:
            'Not all risks are emotional. Some are visible in decision habits and accountability.',
        descriptionAr:
            'ليست كل المخاطر عاطفية؛ بعضها يظهر في العادات العملية وتحمل المسؤولية.',
        items: [
          ContentItem(
            titleEn: 'Constant ambiguity around money',
            titleAr: 'غموض دائم حول المال',
            bodyEn:
                'Avoiding direct answers about spending, debt, or income priorities is usually a serious warning sign.',
            bodyAr:
                'التهرب من الإجابة الصريحة حول الإنفاق أو الديون أو أولويات الدخل غالبًا علامة تحذير مهمة.',
          ),
          ContentItem(
            titleEn: 'Promises collapse under minor pressure',
            titleAr: 'الوعود تنهار مع أول ضغط بسيط',
            bodyEn:
                'Repeated inconsistency is more informative than impressive speeches.',
            bodyAr:
                'التذبذب المتكرر يكشف أكثر من الكلمات الجميلة أو الوعود الكبيرة.',
          ),
          ContentItem(
            titleEn: 'Major life goals stay intentionally vague',
            titleAr: 'الأهداف الكبرى تظل غامضة عمدًا',
            bodyEn:
                'If timing of work, children, housing, or relocation stays undefined on purpose, the later conflict is predictable.',
            bodyAr:
                'إذا ظل توقيت العمل أو الأطفال أو السكن أو الانتقال غامضًا عمدًا، فالصدام اللاحق يصبح متوقعًا.',
          ),
        ],
      ),
    ];
  }
}
