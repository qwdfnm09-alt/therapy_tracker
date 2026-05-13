import '../../domain/models/partner_offer.dart';

class PartnerOffersRepository {
  const PartnerOffersRepository();

  List<PartnerOffer> all() {
    return const [
      PartnerOffer(
        merchantEn: 'Calm Session Studio',
        merchantAr: 'استوديو الجلسة الهادئة',
        titleEn: 'Premarital session preparation bundle',
        titleAr: 'باقة تجهيز جلسات ما قبل الزواج',
        summaryEn:
            'A fixed discount on a short preparation bundle focused on communication and expectations.',
        summaryAr:
            'خصم ثابت على باقة قصيرة لتجهيز ما قبل الزواج تركز على التواصل وتوضيح التوقعات.',
        claimHintEn:
            'Mention the code when booking and confirm the current availability before payment.',
        claimHintAr: 'اذكر الكود وقت الحجز وتأكد من التوافر الحالي قبل أي دفع.',
        code: 'MEETHAQ10',
        notesEn: 'Use once per booking cycle.',
        notesAr: 'يستخدم مرة واحدة لكل دورة حجز.',
      ),
      PartnerOffer(
        merchantEn: 'Family Notes Print',
        merchantAr: 'فاميلي نوتس برنت',
        titleEn: 'Shared planning notebook discount',
        titleAr: 'خصم على دفتر التخطيط المشترك',
        summaryEn:
            'A small stationery offer for couples who want a shared notebook for budgeting and agreements.',
        summaryAr:
            'عرض بسيط على أدوات مكتبية للأزواج الذين يريدون دفترًا مشتركًا للميزانية والاتفاقات.',
        claimHintEn:
            'Copy the code and use it directly with the partner sales contact.',
        claimHintAr: 'انسخ الكود واستخدمه مباشرة مع جهة البيع الخاصة بالشريك.',
        code: 'FAMILY15',
        notesEn: 'Delivery fees may still apply separately.',
        notesAr: 'قد تطبق رسوم التوصيل بشكل منفصل.',
      ),
      PartnerOffer(
        merchantEn: 'Weekend Retreat Guide',
        merchantAr: 'دليل الويك إند الهادئ',
        titleEn: 'Conversation retreat checklist',
        titleAr: 'قائمة تجهيز ليوم نقاش هادئ',
        summaryEn:
            'A free printable checklist from a partner guide to help plan a calm discussion day before commitment.',
        summaryAr:
            'قائمة مجانية قابلة للطباعة من دليل شريك للمساعدة في التخطيط ليوم نقاش هادئ قبل الارتباط.',
        claimHintEn:
            'This offer does not need a discount code. Review the checklist details inside the card.',
        claimHintAr:
            'هذا العرض لا يحتاج إلى كود خصم. راجع تفاصيل القائمة داخل البطاقة.',
        notesEn: 'Useful as a low-pressure first step before paid counseling.',
        notesAr: 'مفيد كخطوة أولى منخفضة الضغط قبل أي استشارة مدفوعة.',
      ),
    ];
  }
}
