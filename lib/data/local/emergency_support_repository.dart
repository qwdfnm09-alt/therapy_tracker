import '../../domain/models/content_item.dart';

class EmergencySupportRepository {
  const EmergencySupportRepository();

  List<ContentSection> guidanceSections() {
    return const [
      ContentSection(
        titleEn: 'Use this screen for fast routing only',
        titleAr: 'استخدم هذه الشاشة للتوجيه السريع فقط',
        descriptionEn:
            'This is not an automated emergency system. It only helps you open the right support action quickly.',
        descriptionAr:
            'هذه ليست منظومة طوارئ آلية. هي فقط تساعدك على فتح وسيلة الدعم المناسبة بسرعة.',
        items: [
          ContentItem(
            titleEn: 'Call when direct conversation is the safest next step',
            titleAr:
                'اتصل عندما تكون المحادثة المباشرة هي الخطوة الأكثر أمانًا',
            bodyEn:
                'Use the call action when the situation needs a fast human response and text is too slow or likely to create more confusion.',
            bodyAr:
                'استخدم الاتصال عندما يحتاج الموقف إلى رد بشري سريع ويكون النص بطيئًا أو قد يزيد الالتباس.',
          ),
          ContentItem(
            titleEn: 'Use WhatsApp when written context will help',
            titleAr: 'استخدم واتساب عندما يفيد الشرح المكتوب',
            bodyEn:
                'Open WhatsApp if you need to send a short summary first before a follow-up call or appointment.',
            bodyAr:
                'افتح واتساب إذا كنت تحتاج إلى إرسال ملخص قصير أولًا قبل مكالمة متابعة أو موعد.',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'Pause before you send',
        titleAr: 'توقف قليلًا قبل الإرسال',
        descriptionEn:
            'A short pause can prevent escalation and make the request clearer.',
        descriptionAr: 'توقف قصير قد يمنع التصعيد ويجعل الطلب أوضح.',
        items: [
          ContentItem(
            titleEn: 'State the concrete risk, not the full history',
            titleAr: 'اذكر الخطر أو المشكلة المباشرة لا التاريخ كله',
            bodyEn:
                'Focus on what is happening now, what kind of support is needed, and whether the situation is urgent.',
            bodyAr:
                'ركز على ما يحدث الآن، وما نوع الدعم المطلوب، وهل الموقف عاجل.',
          ),
          ContentItem(
            titleEn:
                'If there is immediate physical danger, use local emergency services first',
            titleAr:
                'إذا كان هناك خطر جسدي فوري فابدأ بخدمات الطوارئ المحلية أولًا',
            bodyEn:
                'The app does not dispatch emergency responders or monitor incidents in the background.',
            bodyAr:
                'التطبيق لا يرسل جهات استجابة للطوارئ ولا يراقب الحوادث في الخلفية.',
          ),
        ],
      ),
      ContentSection(
        titleEn: 'After the urgent step',
        titleAr: 'بعد الخطوة العاجلة',
        descriptionEn:
            'Stability usually requires one clear follow-up action after the first contact.',
        descriptionAr:
            'الاستقرار يحتاج غالبًا إلى خطوة متابعة واضحة بعد أول تواصل.',
        items: [
          ContentItem(
            titleEn: 'Book a counseling follow-up if the pattern is repeating',
            titleAr: 'احجز متابعة استشارية إذا كان النمط يتكرر',
            bodyEn:
                'If the same conflict or harm pattern keeps coming back, move from reaction to a scheduled support plan.',
            bodyAr:
                'إذا كان نفس نمط الخلاف أو الأذى يتكرر، فانتقل من رد الفعل إلى خطة دعم مجدولة.',
          ),
          ContentItem(
            titleEn: 'Write down key facts while they are still clear',
            titleAr: 'دوّن الحقائق الأساسية ما دامت واضحة',
            bodyEn:
                'Keep a short factual note about what happened, what was tried, and what support is still needed.',
            bodyAr:
                'احتفظ بملاحظة قصيرة وواقعية عمّا حدث، وما الذي جُرّب، وما الدعم الذي ما زال مطلوبًا.',
          ),
        ],
      ),
    ];
  }
}
