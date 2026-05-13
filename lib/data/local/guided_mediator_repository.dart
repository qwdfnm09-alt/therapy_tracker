import '../../domain/models/guided_mediator_track.dart';

class GuidedMediatorRepository {
  const GuidedMediatorRepository();

  List<GuidedMediatorTrack> tracks() {
    return const [
      GuidedMediatorTrack(
        id: 'money_tension',
        titleEn: 'Money tension',
        titleAr: 'توتر المال',
        summaryEn:
            'Use this when the disagreement is about spending, saving, or who carries the pressure.',
        summaryAr:
            'استخدم هذا المسار عندما يكون الخلاف حول الإنفاق أو الادخار أو من يتحمل الضغط المالي.',
        pauseEn:
            'Pause the argument long enough to name the concrete money issue in one sentence only.',
        pauseAr:
            'أوقف النقاش قليلًا بالقدر الذي يسمح بتسمية المشكلة المالية المباشرة في جملة واحدة فقط.',
        personAPromptEn:
            'Person A says: what exact number, payment, or habit feels risky right now?',
        personAPromptAr:
            'يقول الطرف الأول: ما الرقم أو المصروف أو العادة المحددة التي تبدو مقلقة الآن؟',
        personBPromptEn:
            'Person B says: what pressure or fear is driving the current position?',
        personBPromptAr:
            'يقول الطرف الثاني: ما الضغط أو الخوف الذي يدفع الموقف الحالي؟',
        agreementPromptEn:
            'End with one temporary agreement: a limit, a review date, or one category that needs approval first.',
        agreementPromptAr:
            'اختموا باتفاق مؤقت واحد: حد إنفاق، أو موعد مراجعة، أو فئة واحدة تحتاج موافقة مسبقة.',
        escalationNoteEn:
            'If the same argument repeats without numbers becoming clearer, move it to a budget planning or counseling session.',
        escalationNoteAr:
            'إذا تكرر نفس الخلاف دون أن تصبح الأرقام أوضح، انقلوه إلى جلسة تخطيط مالي أو استشارية.',
      ),
      GuidedMediatorTrack(
        id: 'family_pressure',
        titleEn: 'Family pressure',
        titleAr: 'ضغط العائلة',
        summaryEn:
            'Use this when the conflict is driven by parents, relatives, or outside expectations.',
        summaryAr:
            'استخدم هذا المسار عندما يكون الخلاف مدفوعًا بالوالدين أو الأقارب أو توقعات خارجية.',
        pauseEn:
            'Separate the outside voice from the couple voice before discussing solutions.',
        pauseAr: 'افصلوا صوت الخارج عن صوت الشريكين قبل مناقشة أي حلول.',
        personAPromptEn:
            'Person A says: what exact outside request or interference is causing the pressure?',
        personAPromptAr:
            'يقول الطرف الأول: ما الطلب أو التدخل الخارجي المحدد الذي يسبب الضغط؟',
        personBPromptEn:
            'Person B says: what boundary feels necessary, and what response still feels respectful?',
        personBPromptAr:
            'يقول الطرف الثاني: ما الحد الذي يبدو ضروريًا، وما الرد الذي ما زال محترمًا؟',
        agreementPromptEn:
            'Agree on one shared sentence both people can use with family, and one issue that stays strictly inside the couple.',
        agreementPromptAr:
            'اتفقوا على جملة مشتركة يستخدمها الطرفان مع العائلة، وعلى موضوع واحد يبقى داخل العلاقة فقط.',
        escalationNoteEn:
            'If one side cannot hold any boundary without panic or guilt, that needs slower counseling work before the pressure grows.',
        escalationNoteAr:
            'إذا كان أحد الطرفين لا يستطيع تثبيت أي حد دون ذعر أو شعور خانق بالذنب، فهذا يحتاج عملًا أهدأ مع مختص قبل زيادة الضغط.',
      ),
      GuidedMediatorTrack(
        id: 'anger_escalation',
        titleEn: 'Anger escalation',
        titleAr: 'تصاعد الغضب',
        summaryEn:
            'Use this when tone, interruption, or defensiveness starts rising too fast.',
        summaryAr:
            'استخدم هذا المسار عندما ترتفع النبرة أو المقاطعة أو الدفاعية بسرعة.',
        pauseEn:
            'Stop content first. Do not continue arguing about the topic while both sides are still physiologically escalated.',
        pauseAr:
            'أوقفوا المحتوى أولًا. لا تكملوا الجدال حول الموضوع بينما الطرفان ما زالا في حالة تصعيد واضحة.',
        personAPromptEn:
            'Person A says: what crossed the line in tone or behavior, without attacking character?',
        personAPromptAr:
            'يقول الطرف الأول: ما الذي تجاوز الحد في النبرة أو السلوك، بدون الهجوم على الشخصية؟',
        personBPromptEn:
            'Person B says: what sign showed that the conversation was no longer productive?',
        personBPromptAr:
            'يقول الطرف الثاني: ما العلامة التي أوضحت أن النقاش لم يعد منتجًا؟',
        agreementPromptEn:
            'Agree on a reset rule: pause length, how to return, and one behavior that must not repeat.',
        agreementPromptAr:
            'اتفقوا على قاعدة إعادة ضبط: مدة التوقف، وطريقة العودة، وسلوك واحد يجب ألا يتكرر.',
        escalationNoteEn:
            'If the anger repeatedly turns into intimidation, insults, or fear, move immediately to professional support.',
        escalationNoteAr:
            'إذا كان الغضب يتحول بشكل متكرر إلى ترهيب أو إهانة أو خوف، فانتقلوا فورًا إلى دعم مهني.',
      ),
      GuidedMediatorTrack(
        id: 'future_timing',
        titleEn: 'Future timing',
        titleAr: 'توقيت القرارات المستقبلية',
        summaryEn:
            'Use this when the conflict is about children, work timing, moving, or when a major step should happen.',
        summaryAr:
            'استخدم هذا المسار عندما يكون الخلاف حول الأطفال أو توقيت العمل أو الانتقال أو موعد أي خطوة كبيرة.',
        pauseEn:
            'Slow the timeline discussion down before turning it into a loyalty test.',
        pauseAr:
            'خففوا سرعة نقاش التوقيت قبل أن يتحول إلى اختبار ولاء أو ضغط عاطفي.',
        personAPromptEn:
            'Person A says: what exact timeline feels safe, and what makes it feel safe?',
        personAPromptAr:
            'يقول الطرف الأول: ما الجدول الزمني الذي يبدو آمنًا، ولماذا يبدو آمنًا؟',
        personBPromptEn:
            'Person B says: what would feel too slow or too fast, and what risk is attached to that pace?',
        personBPromptAr:
            'يقول الطرف الثاني: ما الذي يبدو بطيئًا جدًا أو سريعًا جدًا، وما الخطر المرتبط بهذه الوتيرة؟',
        agreementPromptEn:
            'End with one checkpoint date and one condition that must be clearer before the next major decision.',
        agreementPromptAr:
            'اختموا بموعد مراجعة واحد وشرط واحد يجب أن يصبح أوضح قبل القرار الكبير التالي.',
        escalationNoteEn:
            'If timing fights keep masking deeper disagreement about values, shift the discussion into a structured counseling session.',
        escalationNoteAr:
            'إذا كانت معارك التوقيت تخفي خلافًا أعمق حول القيم، فانقلوا النقاش إلى جلسة إرشاد منظمة.',
      ),
    ];
  }

  GuidedMediatorTrack trackById(String id) {
    return tracks().firstWhere((track) => track.id == id);
  }
}
