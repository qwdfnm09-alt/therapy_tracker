import '../../domain/models/content_item.dart';
import '../../domain/models/love_language_quiz_question.dart';
import '../../domain/models/weekly_challenge_item.dart';

class RelationshipToolsRepository {
  const RelationshipToolsRepository();

  List<ContentItem> loveLanguages() {
    return _loveLanguages.values.toList(growable: false);
  }

  ContentItem? loveLanguageById(String id) {
    return _loveLanguages[id];
  }

  List<LoveLanguageQuizQuestion> loveLanguageQuestions() {
    return const [
      LoveLanguageQuizQuestion(
        id: 'after_long_week',
        promptEn:
            'After a long stressful week, what would make you feel most cared for?',
        promptAr: 'بعد أسبوع طويل ومجهد، ما الذي يجعلك تشعر بالاهتمام أكثر؟',
        options: [
          LoveLanguageQuizOption(
            id: 'after_long_week_affirmation',
            languageId: 'affirmation',
            labelEn: 'Hear direct appreciation and reassuring words.',
            labelAr: 'أن أسمع تقديرًا مباشرًا وكلمات مطمئنة.',
          ),
          LoveLanguageQuizOption(
            id: 'after_long_week_time',
            languageId: 'time',
            labelEn: 'Spend uninterrupted calm time together.',
            labelAr: 'أن نقضي وقتًا هادئًا معًا بدون مقاطعات.',
          ),
          LoveLanguageQuizOption(
            id: 'after_long_week_service',
            languageId: 'service',
            labelEn: 'Receive practical help that removes some pressure.',
            labelAr: 'أن أتلقى مساعدة عملية تخفف بعض الضغط.',
          ),
          LoveLanguageQuizOption(
            id: 'after_long_week_gifts',
            languageId: 'gifts',
            labelEn: 'Receive a simple thoughtful surprise.',
            labelAr: 'أن أتلقى لفتة أو هدية بسيطة لها معنى.',
          ),
          LoveLanguageQuizOption(
            id: 'after_long_week_closeness',
            languageId: 'closeness',
            labelEn: 'Feel warmth through closeness and affection.',
            labelAr: 'أن أشعر بالدفء عبر القرب والحنان.',
          ),
        ],
      ),
      LoveLanguageQuizQuestion(
        id: 'ordinary_day',
        promptEn:
            'On an ordinary day, which gesture stays with you the longest?',
        promptAr: 'في يوم عادي، أي لفتة تبقى معك في الذاكرة أطول؟',
        options: [
          LoveLanguageQuizOption(
            id: 'ordinary_day_affirmation',
            languageId: 'affirmation',
            labelEn: 'A specific compliment or grateful message.',
            labelAr: 'رسالة تقدير أو مجاملة محددة وواضحة.',
          ),
          LoveLanguageQuizOption(
            id: 'ordinary_day_time',
            languageId: 'time',
            labelEn: 'Focused conversation with full attention.',
            labelAr: 'حوار مركز بحضور كامل وانتباه حقيقي.',
          ),
          LoveLanguageQuizOption(
            id: 'ordinary_day_service',
            languageId: 'service',
            labelEn: 'Someone taking care of a task for you.',
            labelAr: 'أن يقوم الطرف الآخر بمهمة عنك أو يساعدك فيها.',
          ),
          LoveLanguageQuizOption(
            id: 'ordinary_day_gifts',
            languageId: 'gifts',
            labelEn: 'A small item that shows you were remembered.',
            labelAr: 'شيء بسيط يثبت أنك كنت في البال.',
          ),
          LoveLanguageQuizOption(
            id: 'ordinary_day_closeness',
            languageId: 'closeness',
            labelEn: 'A warm hug or gentle physical affection.',
            labelAr: 'حضن دافئ أو قرب جسدي لطيف.',
          ),
        ],
      ),
      LoveLanguageQuizQuestion(
        id: 'during_conflict',
        promptEn:
            'After a misunderstanding, what repair action feels most convincing to you?',
        promptAr: 'بعد سوء تفاهم، ما التصرف الإصلاحي الأكثر إقناعًا لك؟',
        options: [
          LoveLanguageQuizOption(
            id: 'during_conflict_affirmation',
            languageId: 'affirmation',
            labelEn: 'An honest apology with clear validating words.',
            labelAr: 'اعتذار صادق مع كلمات واضحة تعترف بما حدث.',
          ),
          LoveLanguageQuizOption(
            id: 'during_conflict_time',
            languageId: 'time',
            labelEn: 'Sitting together and talking it through calmly.',
            labelAr: 'الجلوس معًا ومناقشة ما حدث بهدوء.',
          ),
          LoveLanguageQuizOption(
            id: 'during_conflict_service',
            languageId: 'service',
            labelEn: 'A helpful action that eases the next step.',
            labelAr: 'تصرف عملي يساعد في إصلاح الوضع فعليًا.',
          ),
          LoveLanguageQuizOption(
            id: 'during_conflict_gifts',
            languageId: 'gifts',
            labelEn: 'A meaningful gesture that shows intention to repair.',
            labelAr: 'لفتة رمزية تحمل نية واضحة للإصلاح.',
          ),
          LoveLanguageQuizOption(
            id: 'during_conflict_closeness',
            languageId: 'closeness',
            labelEn: 'Gentle affection that restores emotional safety.',
            labelAr: 'قرب حنون يعيد الإحساس بالأمان العاطفي.',
          ),
        ],
      ),
      LoveLanguageQuizQuestion(
        id: 'busy_season',
        promptEn:
            'When life gets busy, what best proves that care is still present?',
        promptAr:
            'عندما تصبح الحياة مزدحمة، ما أكثر شيء يثبت لك أن الاهتمام ما زال حاضرًا؟',
        options: [
          LoveLanguageQuizOption(
            id: 'busy_season_affirmation',
            languageId: 'affirmation',
            labelEn: 'Still hearing appreciation even in pressure.',
            labelAr: 'أن أسمع التقدير حتى وقت الضغط.',
          ),
          LoveLanguageQuizOption(
            id: 'busy_season_time',
            languageId: 'time',
            labelEn: 'Making protected time despite the schedule.',
            labelAr: 'حجز وقت محفوظ لنا رغم الازدحام.',
          ),
          LoveLanguageQuizOption(
            id: 'busy_season_service',
            languageId: 'service',
            labelEn: 'Sharing the load without being asked repeatedly.',
            labelAr: 'تقاسم العبء دون طلب متكرر.',
          ),
          LoveLanguageQuizOption(
            id: 'busy_season_gifts',
            languageId: 'gifts',
            labelEn: 'Receiving a thoughtful token or note.',
            labelAr: 'تلقي هدية أو ملاحظة صغيرة ذات معنى.',
          ),
          LoveLanguageQuizOption(
            id: 'busy_season_closeness',
            languageId: 'closeness',
            labelEn: 'Staying physically warm and emotionally close.',
            labelAr: 'بقاء القرب الجسدي والدفء حاضرَين.',
          ),
        ],
      ),
      LoveLanguageQuizQuestion(
        id: 'special_memory',
        promptEn: 'What kind of moment would make you feel deeply remembered?',
        promptAr: 'أي نوع من اللحظات يجعلك تشعر أنك مذكور ومهم بعمق؟',
        options: [
          LoveLanguageQuizOption(
            id: 'special_memory_affirmation',
            languageId: 'affirmation',
            labelEn: 'Words that name exactly what is valued in you.',
            labelAr: 'كلمات تسمي بوضوح ما الذي يُقدَّر فيك.',
          ),
          LoveLanguageQuizOption(
            id: 'special_memory_time',
            languageId: 'time',
            labelEn: 'A meaningful shared experience together.',
            labelAr: 'تجربة مشتركة لها معنى نقضيها معًا.',
          ),
          LoveLanguageQuizOption(
            id: 'special_memory_service',
            languageId: 'service',
            labelEn: 'Someone making your day easier in a concrete way.',
            labelAr: 'أن يجعل الطرف الآخر يومك أسهل بشكل عملي واضح.',
          ),
          LoveLanguageQuizOption(
            id: 'special_memory_gifts',
            languageId: 'gifts',
            labelEn: 'A gift chosen with real attention to your taste.',
            labelAr: 'هدية مختارة باهتمام حقيقي لذوقك واهتماماتك.',
          ),
          LoveLanguageQuizOption(
            id: 'special_memory_closeness',
            languageId: 'closeness',
            labelEn: 'Tender closeness that feels safe and comforting.',
            labelAr: 'قرب حنون يمنحك أمانًا وراحة.',
          ),
        ],
      ),
    ];
  }

  List<WeeklyChallengeItem> weeklyChallenges() {
    return const [
      WeeklyChallengeItem(
        id: 'listening_15_minutes',
        content: ContentItem(
          titleEn: '15-minute listening challenge',
          titleAr: 'تحدي الاستماع 15 دقيقة',
          bodyEn:
              'One person speaks about a real concern for 15 minutes while the other only listens and summarizes without defending or correcting.',
          bodyAr:
              'يتحدث أحد الطرفين 15 دقيقة عن أمر يشغله بصدق، بينما يكتفي الآخر بالإنصات والتلخيص دون دفاع أو تصحيح.',
          tagEn: 'Week 1',
          tagAr: 'الأسبوع 1',
        ),
      ),
      WeeklyChallengeItem(
        id: 'expectation_reset',
        content: ContentItem(
          titleEn: 'Expectation reset challenge',
          titleAr: 'تحدي إعادة ضبط التوقعات',
          bodyEn:
              'Each person writes one expectation that should become explicit instead of staying implied. Discuss it calmly and agree on a realistic version.',
          bodyAr:
              'يكتب كل طرف توقعًا واحدًا يجب أن يصبح صريحًا بدل أن يظل ضمنيًا، ثم يناقشانه بهدوء ويصوغان نسخة واقعية منه.',
          tagEn: 'Week 2',
          tagAr: 'الأسبوع 2',
        ),
      ),
      WeeklyChallengeItem(
        id: 'no_phone_meal',
        content: ContentItem(
          titleEn: 'No-phone meal',
          titleAr: 'وجبة بلا هواتف',
          bodyEn:
              'Share one meal with no phones and no multitasking. The goal is not romance theater; it is presence and calmer attention.',
          bodyAr:
              'شاركا وجبة واحدة بدون هواتف ولا مهام موازية. الهدف ليس مشهدًا رومانسيًا، بل حضورًا وانتباهًا أهدأ.',
          tagEn: 'Week 3',
          tagAr: 'الأسبوع 3',
        ),
      ),
      WeeklyChallengeItem(
        id: 'repair_after_tension',
        content: ContentItem(
          titleEn: 'Repair after tension',
          titleAr: 'إصلاح بعد التوتر',
          bodyEn:
              'If a small disagreement happens this week, return later and ask: what exactly made this harder, and what would make repair faster next time?',
          bodyAr:
              'إذا حدث خلاف بسيط هذا الأسبوع، فارجعا إليه لاحقًا واسألا: ما الذي صعّب الموقف تحديدًا، وما الذي يجعل الإصلاح أسرع في المرة القادمة؟',
          tagEn: 'Week 4',
          tagAr: 'الأسبوع 4',
        ),
      ),
    ];
  }
}

const Map<String, ContentItem> _loveLanguages = {
  'affirmation': ContentItem(
    titleEn: 'Words of affirmation',
    titleAr: 'كلمات التقدير',
    bodyEn:
        'This person feels most seen when appreciation is spoken clearly. Useful actions: specific praise, calm reassurance, and direct gratitude.',
    bodyAr:
        'هذا الطرف يشعر بالتقدير عندما يُقال له بوضوح. الأفعال المفيدة هنا: مدح محدد، طمأنة هادئة، وشكر مباشر.',
    tagEn: 'Language 1',
    tagAr: 'اللغة 1',
  ),
  'time': ContentItem(
    titleEn: 'Quality time',
    titleAr: 'الوقت النوعي',
    bodyEn:
        'Attention matters more than duration. The useful pattern is uninterrupted presence, intentional listening, and shared moments without distraction.',
    bodyAr:
        'الانتباه هنا أهم من طول الوقت. النمط المفيد هو حضور كامل، وإنصات مقصود، ووقت مشترك بدون تشتيت.',
    tagEn: 'Language 2',
    tagAr: 'اللغة 2',
  ),
  'service': ContentItem(
    titleEn: 'Acts of service',
    titleAr: 'أفعال المساندة',
    bodyEn:
        'Care is felt through effort and helpful action. Small practical support often means more than long explanations.',
    bodyAr:
        'الاهتمام يُفهم هنا من خلال الفعل والمساندة. المساعدة العملية الصغيرة قد تكون أبلغ من الشرح الطويل.',
    tagEn: 'Language 3',
    tagAr: 'اللغة 3',
  ),
  'gifts': ContentItem(
    titleEn: 'Thoughtful gifts',
    titleAr: 'الهدايا ذات المعنى',
    bodyEn:
        'The point is not price. A simple gift with timing and intention can communicate memory, attention, and care.',
    bodyAr:
        'الفكرة ليست في السعر. الهدية البسيطة حين تأتي في توقيت ومعنى مناسبين قد تعبّر عن تذكر واهتمام ومودة.',
    tagEn: 'Language 4',
    tagAr: 'اللغة 4',
  ),
  'closeness': ContentItem(
    titleEn: 'Physical closeness',
    titleAr: 'القرب الجسدي',
    bodyEn:
        'Warmth is communicated through presence, affection, and emotional safety in closeness. Respect for boundaries remains essential.',
    bodyAr:
        'الدفء هنا يُفهم من خلال القرب والحنان والشعور بالأمان في المسافة القريبة، مع بقاء احترام الحدود أمرًا أساسيًا.',
    tagEn: 'Language 5',
    tagAr: 'اللغة 5',
  ),
};
