import '../../domain/models/content_item.dart';

class RelationshipToolsRepository {
  const RelationshipToolsRepository();

  List<ContentItem> loveLanguages() {
    return const [
      ContentItem(
        titleEn: 'Words of affirmation',
        titleAr: 'كلمات التقدير',
        bodyEn:
            'This person feels most seen when appreciation is spoken clearly. Useful actions: specific praise, calm reassurance, and direct gratitude.',
        bodyAr:
            'هذا الطرف يشعر بالتقدير عندما يُقال له بوضوح. الأفعال المفيدة هنا: مدح محدد، طمأنة هادئة، وشكر مباشر.',
        tagEn: 'Language 1',
        tagAr: 'اللغة 1',
      ),
      ContentItem(
        titleEn: 'Quality time',
        titleAr: 'الوقت النوعي',
        bodyEn:
            'Attention matters more than duration. The useful pattern is uninterrupted presence, intentional listening, and shared moments without distraction.',
        bodyAr:
            'الانتباه هنا أهم من طول الوقت. النمط المفيد هو حضور كامل، وإنصات مقصود، ووقت مشترك بدون تشتيت.',
        tagEn: 'Language 2',
        tagAr: 'اللغة 2',
      ),
      ContentItem(
        titleEn: 'Acts of service',
        titleAr: 'أفعال المساندة',
        bodyEn:
            'Care is felt through effort and helpful action. Small practical support often means more than long explanations.',
        bodyAr:
            'الاهتمام يُفهم هنا من خلال الفعل والمساندة. المساعدة العملية الصغيرة قد تكون أبلغ من الشرح الطويل.',
        tagEn: 'Language 3',
        tagAr: 'اللغة 3',
      ),
      ContentItem(
        titleEn: 'Thoughtful gifts',
        titleAr: 'الهدايا ذات المعنى',
        bodyEn:
            'The point is not price. A simple gift with timing and intention can communicate memory, attention, and care.',
        bodyAr:
            'الفكرة ليست في السعر. الهدية البسيطة حين تأتي في توقيت ومعنى مناسبين قد تعبّر عن تذكر واهتمام ومودة.',
        tagEn: 'Language 4',
        tagAr: 'اللغة 4',
      ),
      ContentItem(
        titleEn: 'Physical closeness',
        titleAr: 'القرب الجسدي',
        bodyEn:
            'Warmth is communicated through presence, affection, and emotional safety in closeness. Respect for boundaries remains essential.',
        bodyAr:
            'الدفء هنا يُفهم من خلال القرب والحنان والشعور بالأمان في المسافة القريبة، مع بقاء احترام الحدود أمرًا أساسيًا.',
        tagEn: 'Language 5',
        tagAr: 'اللغة 5',
      ),
    ];
  }

  List<ContentItem> weeklyChallenges() {
    return const [
      ContentItem(
        titleEn: '15-minute listening challenge',
        titleAr: 'تحدي الاستماع 15 دقيقة',
        bodyEn:
            'One person speaks about a real concern for 15 minutes while the other only listens and summarizes without defending or correcting.',
        bodyAr:
            'يتحدث أحد الطرفين 15 دقيقة عن أمر يشغله بصدق، بينما يكتفي الآخر بالإنصات والتلخيص دون دفاع أو تصحيح.',
        tagEn: 'Week 1',
        tagAr: 'الأسبوع 1',
      ),
      ContentItem(
        titleEn: 'Expectation reset challenge',
        titleAr: 'تحدي إعادة ضبط التوقعات',
        bodyEn:
            'Each person writes one expectation that should become explicit instead of staying implied. Discuss it calmly and agree on a realistic version.',
        bodyAr:
            'يكتب كل طرف توقعًا واحدًا يجب أن يصبح صريحًا بدل أن يظل ضمنيًا، ثم يناقشانه بهدوء ويصوغان نسخة واقعية منه.',
        tagEn: 'Week 2',
        tagAr: 'الأسبوع 2',
      ),
      ContentItem(
        titleEn: 'No-phone meal',
        titleAr: 'وجبة بلا هواتف',
        bodyEn:
            'Share one meal with no phones and no multitasking. The goal is not romance theater; it is presence and calmer attention.',
        bodyAr:
            'شاركا وجبة واحدة بدون هواتف ولا مهام موازية. الهدف ليس مشهدًا رومانسيًا، بل حضورًا وانتباهًا أهدأ.',
        tagEn: 'Week 3',
        tagAr: 'الأسبوع 3',
      ),
      ContentItem(
        titleEn: 'Repair after tension',
        titleAr: 'إصلاح بعد التوتر',
        bodyEn:
            'If a small disagreement happens this week, return later and ask: what exactly made this harder, and what would make repair faster next time?',
        bodyAr:
            'إذا حدث خلاف بسيط هذا الأسبوع، فارجعا إليه لاحقًا واسألا: ما الذي صعّب الموقف تحديدًا، وما الذي يجعل الإصلاح أسرع في المرة القادمة؟',
        tagEn: 'Week 4',
        tagAr: 'الأسبوع 4',
      ),
    ];
  }
}
