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

  List<ContentSection> rightsAndDutiesSections() {
    return const [
      ContentSection(
        titleEn: 'Before marriage clarity',
        titleAr: 'الوضوح قبل الزواج',
        descriptionEn:
            'These points help both sides define expectations early instead of discovering them under pressure later.',
        descriptionAr:
            'هذه النقاط تساعد الطرفين على تعريف التوقعات مبكرًا بدل اكتشافها تحت الضغط لاحقًا.',
        items: [
          ContentItem(
            titleEn: 'Financial expectations should be explicit',
            titleAr: 'التوقعات المالية يجب أن تكون صريحة',
            bodyEn:
                'Discuss housing, core expenses, debt boundaries, work priorities, and what each side considers a basic obligation before commitment.',
            bodyAr:
                'ينبغي مناقشة السكن، والمصروفات الأساسية، وحدود الديون، وأولوية العمل، وما يراه كل طرف التزامًا أساسيًا قبل الارتباط.',
            tagEn: 'Core clarity',
            tagAr: 'وضوح أساسي',
          ),
          ContentItem(
            titleEn: 'Private boundaries need agreement',
            titleAr: 'الحدود الخاصة تحتاج اتفاقًا',
            bodyEn:
                'Privacy, communication with family, and how disagreements leave the couple circle should be discussed clearly, not left to assumption.',
            bodyAr:
                'الخصوصية، والتواصل مع العائلة، وكيفية خروج الخلافات خارج دائرة الزوجين، كلها أمور تحتاج نقاشًا واضحًا لا افتراضات ضمنية.',
            tagEn: 'Boundaries',
            tagAr: 'حدود',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Inside the marriage relationship',
        titleAr: 'داخل العلاقة الزوجية',
        descriptionEn:
            'A stable relationship depends on fairness, responsibility, and respectful conflict repair, not only good intentions.',
        descriptionAr:
            'استقرار العلاقة يعتمد على العدل والمسؤولية وإصلاح الخلاف باحترام، وليس على النوايا الحسنة فقط.',
        items: [
          ContentItem(
            titleEn: 'Respect is a daily duty',
            titleAr: 'الاحترام واجب يومي',
            bodyEn:
                'No one should normalize contempt, humiliation, or using anger as a license to harm the other person verbally or emotionally.',
            bodyAr:
                'لا يصح تطبيع الاحتقار أو الإهانة أو اعتبار الغضب تصريحًا لإيذاء الطرف الآخر لفظيًا أو نفسيًا.',
            tagEn: 'Protection',
            tagAr: 'حماية',
          ),
          ContentItem(
            titleEn: 'Responsibilities should be visible',
            titleAr: 'المسؤوليات يجب أن تكون واضحة',
            bodyEn:
                'Daily roles, home effort, child-related expectations, and repair after mistakes should be visible and discussable instead of vague.',
            bodyAr:
                'الأدوار اليومية، والجهد داخل البيت، وتوقعات الأطفال، والإصلاح بعد الخطأ، يجب أن تكون واضحة وقابلة للنقاش بدل الغموض.',
            tagEn: 'Fairness',
            tagAr: 'عدل',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'When outside support is needed',
        titleAr: 'عند الحاجة إلى دعم خارجي',
        descriptionEn:
            'Legal or counseling guidance is most useful before conflict becomes chronic or damaging.',
        descriptionAr:
            'الاستشارة القانونية أو الأسرية تكون أكثر فائدة قبل أن يتحول الخلاف إلى نمط مزمن أو مؤذٍ.',
        items: [
          ContentItem(
            titleEn: 'Serious repeated harm should not be minimized',
            titleAr: 'الأذى الجاد المتكرر لا يصح التقليل منه',
            bodyEn:
                'If repeated intimidation, insult, coercion, or financial manipulation appears, the right next step is structured support, not denial.',
            bodyAr:
                'إذا ظهر ترهيب متكرر أو إهانة أو إكراه أو تلاعب مالي، فالخطوة الصحيحة هي طلب دعم منظم لا الإنكار أو التهوين.',
            tagEn: 'Escalate early',
            tagAr: 'تصعيد مبكر',
          ),
          ContentItem(
            titleEn: 'Use qualified advice for legal details',
            titleAr: 'ارجع لمتخصص مؤهل في التفاصيل القانونية',
            bodyEn:
                'This section is a practical awareness layer, not a substitute for a qualified lawyer or licensed counselor when a real case needs exact legal advice.',
            bodyAr:
                'هذا القسم طبقة توعوية عملية، وليس بديلًا عن محامٍ مؤهل أو مستشار مرخص عندما تحتاج الحالة الفعلية إلى رأي قانوني دقيق.',
            tagEn: 'Scope',
            tagAr: 'نطاق',
          ),
        ],
      ),
    ];
  }

  List<ContentSection> inLawsGuideSections() {
    return const [
      ContentSection(
        titleEn: 'First-contact expectations',
        titleAr: 'توقعات البداية',
        descriptionEn:
            'Tension with family often starts from vague boundaries, not from one dramatic event.',
        descriptionAr:
            'التوتر مع الأهل يبدأ غالبًا من غموض الحدود، لا من موقف واحد كبير فقط.',
        items: [
          ContentItem(
            titleEn: 'Define what belongs to the couple first',
            titleAr: 'حددا ما يخص الزوجين أولًا',
            bodyEn:
                'Private decisions, small disagreements, and day-to-day arrangements should not automatically move to family opinion before the couple discusses them clearly.',
            bodyAr:
                'القرارات الخاصة، والخلافات الصغيرة، والترتيبات اليومية، لا ينبغي أن تنتقل تلقائيًا إلى رأي الأهل قبل أن يناقشها الزوجان بوضوح.',
            tagEn: 'Boundaries',
            tagAr: 'حدود',
          ),
          ContentItem(
            titleEn: 'Agree on how information leaves the home',
            titleAr: 'اتفقا كيف تخرج المعلومات من البيت',
            bodyEn:
                'It is safer to agree early on what can be shared, with whom, and under what circumstances, instead of deciding in the middle of tension.',
            bodyAr:
                'الأكثر أمانًا هو الاتفاق مبكرًا على ما الذي يمكن مشاركته، ومع من، وفي أي ظرف، بدل اتخاذ القرار وسط التوتر.',
            tagEn: 'Privacy',
            tagAr: 'خصوصية',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Managing interference calmly',
        titleAr: 'إدارة التدخل بهدوء',
        descriptionEn:
            'The useful goal is not confrontation for its own sake, but reducing repeated friction without disrespect.',
        descriptionAr:
            'الهدف المفيد ليس الصدام لذاته، بل تقليل الاحتكاك المتكرر بدون إساءة أو كسر احترام.',
        items: [
          ContentItem(
            titleEn: 'Respond as a united pair when possible',
            titleAr: 'ردا كفريق واحد متى أمكن',
            bodyEn:
                'If one side always leaves the other alone in front of family pressure, resentment grows quickly. A calm shared position is usually stronger than separate reactions.',
            bodyAr:
                'إذا ترك أحد الطرفين الآخر وحده دائمًا أمام ضغط الأهل، يتراكم الاستياء بسرعة. الموقف الهادئ المشترك أقوى غالبًا من ردود الأفعال المنفصلة.',
            tagEn: 'Alignment',
            tagAr: 'اصطفاف',
          ),
          ContentItem(
            titleEn: 'Name the behavior, not the person',
            titleAr: 'سمّيا السلوك لا الشخص',
            bodyEn:
                'It is usually safer to say a specific behavior is harmful than to turn the conversation into a total judgment on a parent or relative.',
            bodyAr:
                'غالبًا يكون الأكثر أمانًا وصف سلوك محدد بأنه مؤذٍ، بدل تحويل الحديث إلى حكم كامل على الأب أو الأم أو القريب.',
            tagEn: 'De-escalation',
            tagAr: 'تهدئة',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'When stronger action is needed',
        titleAr: 'متى نحتاج موقفًا أقوى',
        descriptionEn:
            'Some patterns need firmer limits or outside support before they damage the marriage structure itself.',
        descriptionAr:
            'بعض الأنماط تحتاج حدودًا أوضح أو دعمًا خارجيًا قبل أن تضر ببنية الزواج نفسها.',
        items: [
          ContentItem(
            titleEn: 'Repeated humiliation should not be normalized',
            titleAr: 'الإهانة المتكررة لا تُطبَّع',
            bodyEn:
                'Mocking, undermining, or deliberate shaming from relatives should not be absorbed silently as a normal family style.',
            bodyAr:
                'السخرية أو التقليل أو الإحراج المتعمد من الأقارب لا ينبغي امتصاصه بصمت باعتباره أسلوبًا عائليًا عاديًا.',
            tagEn: 'High risk',
            tagAr: 'خطورة عالية',
          ),
          ContentItem(
            titleEn: 'Use counseling before the pattern hardens',
            titleAr: 'الجأوا للاستشارة قبل أن يتصلب النمط',
            bodyEn:
                'If family pressure keeps deciding private choices, an early counseling conversation is usually more useful than waiting for repeated resentment.',
            bodyAr:
                'إذا ظل ضغط الأهل يقرر الخيارات الخاصة، فجلسة استشارية مبكرة تكون غالبًا أنفع من انتظار تكرار الاستياء وتراكمه.',
            tagEn: 'Early support',
            tagAr: 'دعم مبكر',
          ),
        ],
      ),
    ];
  }

  List<ContentSection> marriageReadinessSections() {
    return const [
      ContentSection(
        titleEn: 'Self-awareness first',
        titleAr: 'الوعي بالذات أولًا',
        descriptionEn:
            'Marriage readiness starts before choosing a partner. It begins with naming your own patterns and limits honestly.',
        descriptionAr:
            'جاهزية الزواج تبدأ قبل اختيار الشريك. البداية تكون بتسمية أنماطك وحدودك أنت بصدق.',
        items: [
          ContentItem(
            titleEn: 'Know your non-negotiables clearly',
            titleAr: 'اعرف خطوطك غير القابلة للتنازل بوضوح',
            bodyEn:
                'Define what cannot stay vague: religion, work rhythm, children, privacy, family boundaries, and financial obligations.',
            bodyAr:
                'حدد ما لا يصح أن يظل غامضًا: الدين، وإيقاع العمل، والأطفال، والخصوصية، وحدود العائلة، والالتزامات المالية.',
            tagEn: 'Step 1',
            tagAr: 'الخطوة 1',
          ),
          ContentItem(
            titleEn: 'Distinguish desire from capacity',
            titleAr: 'فرّق بين الرغبة والقدرة',
            bodyEn:
                'Wanting marriage is not the same as being ready for its daily responsibility, repair, compromise, and pressure.',
            bodyAr:
                'الرغبة في الزواج ليست هي الجاهزية لمسؤوليته اليومية، والإصلاح، والتنازل، والضغط المتكرر.',
            tagEn: 'Step 2',
            tagAr: 'الخطوة 2',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Practical readiness',
        titleAr: 'الجاهزية العملية',
        descriptionEn:
            'A stable decision needs more than feelings. It needs visible habits that can carry a household over time.',
        descriptionAr:
            'القرار المستقر يحتاج أكثر من المشاعر. يحتاج عادات واضحة قادرة على حمل بيت مع الوقت.',
        items: [
          ContentItem(
            titleEn: 'Check responsibility under pressure',
            titleAr: 'اختبر المسؤولية تحت الضغط',
            bodyEn:
                'Ask how you usually behave when commitments become inconvenient. Reliability matters more than ideal self-description.',
            bodyAr:
                'اسأل نفسك كيف تتصرف عادة عندما تصبح الالتزامات مرهقة أو غير مريحة. الاعتمادية أهم من الوصف المثالي للنفس.',
            tagEn: 'Reality check',
            tagAr: 'اختبار واقعي',
          ),
          ContentItem(
            titleEn: 'Look at conflict habits honestly',
            titleAr: 'انظر بصدق إلى عادات الخلاف',
            bodyEn:
                'If anger, withdrawal, or blame dominates your conflict style, readiness needs work before commitment becomes heavier.',
            bodyAr:
                'إذا كان الغضب أو الانسحاب أو اللوم يسيطر على أسلوب الخلاف، فهذه الجاهزية تحتاج عملًا قبل أن يصبح الالتزام أثقل.',
            tagEn: 'Regulation',
            tagAr: 'تنظيم',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Decision checkpoint',
        titleAr: 'نقطة مراجعة القرار',
        descriptionEn:
            'The useful question is not only “Do we like each other?” but also “Can we carry the structure of marriage responsibly?”',
        descriptionAr:
            'السؤال المفيد ليس فقط: هل نحب بعضنا؟ بل أيضًا: هل نستطيع حمل بنية الزواج بمسؤولية؟',
        items: [
          ContentItem(
            titleEn: 'Slow down when basics are still unclear',
            titleAr: 'اهدأ عندما تكون الأساسيات ما زالت غير واضحة',
            bodyEn:
                'If expectations around money, family, timing, or repair are still blurry, slowing down is usually wiser than rushing toward commitment.',
            bodyAr:
                'إذا ظلت التوقعات حول المال أو العائلة أو التوقيت أو الإصلاح ضبابية، فالإبطاء يكون غالبًا أحكم من الاستعجال نحو الالتزام.',
            tagEn: 'Decision rule',
            tagAr: 'قاعدة قرار',
          ),
          ContentItem(
            titleEn: 'Use counseling early when needed',
            titleAr: 'استخدم الاستشارة مبكرًا عند الحاجة',
            bodyEn:
                'Readiness is not proven by avoiding help. In many cases, early structured support prevents larger confusion later.',
            bodyAr:
                'الجاهزية لا تُثبت بتجنب المساعدة. في حالات كثيرة، الدعم المنظم المبكر يمنع ارتباكًا أكبر لاحقًا.',
            tagEn: 'Support',
            tagAr: 'دعم',
          ),
        ],
      ),
    ];
  }

  List<ContentSection> heritageAwarenessSections() {
    return const [
      ContentSection(
        titleEn: 'Useful wisdom vs harmful inheritance',
        titleAr: 'الحكمة النافعة مقابل الإرث المؤذي',
        descriptionEn:
            'Not every inherited phrase deserves to run the marriage. Some sayings protect the family, and some quietly damage it.',
        descriptionAr:
            'ليست كل عبارة موروثة تصلح لقيادة الزواج. بعض الأقوال تحمي الأسرة، وبعضها يضرها بصمت.',
        items: [
          ContentItem(
            titleEn: 'Keep the value, not the harshness',
            titleAr: 'احتفظ بالقيمة لا بالقسوة',
            bodyEn:
                'Tradition can support loyalty, patience, and family care. It should not be used to justify humiliation, forced silence, or one-sided control.',
            bodyAr:
                'يمكن للتراث أن يدعم الوفاء والصبر ورعاية الأسرة، لكنه لا ينبغي أن يُستخدم لتبرير الإهانة أو الصمت القسري أو السيطرة من طرف واحد.',
            tagEn: 'Filter',
            tagAr: 'فلترة',
          ),
          ContentItem(
            titleEn: 'Question what is treated as obvious',
            titleAr: 'راجع ما يُعامل كأنه بديهي',
            bodyEn:
                'When a social rule cannot be explained without fear, shame, or domination, it deserves review instead of blind repetition.',
            bodyAr:
                'عندما لا يمكن شرح قاعدة اجتماعية إلا بالخوف أو العار أو الهيمنة، فهي تستحق المراجعة لا التكرار الأعمى.',
            tagEn: 'Review',
            tagAr: 'مراجعة',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Modern reading with family sensitivity',
        titleAr: 'قراءة عصرية مع حساسية أسرية',
        descriptionEn:
            'The goal is not to insult the past, but to read it in a way that protects the present family structure better.',
        descriptionAr:
            'الهدف ليس إهانة الماضي، بل قراءته بطريقة تحمي بنية الأسرة الحالية بشكل أفضل.',
        items: [
          ContentItem(
            titleEn: 'Use stories to open discussion gently',
            titleAr: 'استخدم القصص لفتح النقاش بهدوء',
            bodyEn:
                'Family stories and proverbs can become useful openings for discussing respect, fairness, and repair without turning the talk into accusation.',
            bodyAr:
                'القصص العائلية والأمثال يمكن أن تصبح مدخلًا مفيدًا لمناقشة الاحترام والعدل والإصلاح بدون تحويل الكلام إلى اتهام مباشر.',
            tagEn: 'Dialogue',
            tagAr: 'حوار',
          ),
          ContentItem(
            titleEn: 'Prefer principles that build stability',
            titleAr: 'قدّم المبادئ التي تبني الاستقرار',
            bodyEn:
                'Give more weight to inherited ideas that strengthen trust, mercy, responsibility, and clear roles than to those that glorify ego or stubbornness.',
            bodyAr:
                'أعط وزنًا أكبر للأفكار الموروثة التي تقوي الثقة والرحمة والمسؤولية ووضوح الأدوار، لا لتلك التي تمجد الأنا أو العناد.',
            tagEn: 'Selection',
            tagAr: 'اختيار',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'What this means in practice',
        titleAr: 'ماذا يعني هذا عمليًا',
        descriptionEn:
            'Cultural awareness becomes useful only when it changes how couples speak, decide, and repair.',
        descriptionAr:
            'الوعي الثقافي لا يصبح مفيدًا إلا عندما يغيّر طريقة الكلام والقرار والإصلاح بين الزوجين.',
        items: [
          ContentItem(
            titleEn: 'Do not hide harm behind respect language',
            titleAr: 'لا تخفِ الأذى خلف لغة الاحترام',
            bodyEn:
                'Respect for family does not require accepting chronic injustice inside the marriage. The distinction must stay clear.',
            bodyAr:
                'احترام العائلة لا يعني قبول ظلم مزمن داخل الزواج. يجب أن يبقى هذا الفرق واضحًا.',
            tagEn: 'Boundary',
            tagAr: 'حد',
          ),
          ContentItem(
            titleEn: 'Translate values into behavior',
            titleAr: 'حوّل القيم إلى سلوك',
            bodyEn:
                'Mercy, loyalty, and responsibility should appear in speech and action, not stay as slogans repeated only when convenient.',
            bodyAr:
                'الرحمة والوفاء والمسؤولية يجب أن تظهر في الكلام والسلوك، لا أن تبقى شعارات تُكرر وقت الحاجة فقط.',
            tagEn: 'Practice',
            tagAr: 'ممارسة',
          ),
        ],
      ),
    ];
  }
}
