import '../../domain/models/scenario_lab_item.dart';

class ScenarioLabRepository {
  const ScenarioLabRepository();

  List<ScenarioLabItem> scenarios() {
    return const [
      ScenarioLabItem(
        id: 'job_offer_move',
        titleEn: 'Job offer in another city',
        titleAr: 'عرض عمل في مدينة أخرى',
        bodyEn:
            'A strong job offer appears in another city six months after marriage. The move would improve income, but it would distance you from both families and change the daily routine.',
        bodyAr:
            'يظهر عرض عمل قوي في مدينة أخرى بعد الزواج بستة أشهر. الانتقال سيحسن الدخل، لكنه سيبعدكما عن العائلتين ويغيّر الروتين اليومي بالكامل.',
        focusEn: 'Planning under change',
        focusAr: 'التخطيط وقت التغيير',
        options: [
          ScenarioLabOption(
            id: 'job_offer_move_fast_yes',
            axis: 'flex_high',
            labelEn: 'Move quickly if the opportunity is clearly stronger.',
            labelAr: 'ننتقل بسرعة إذا كانت الفرصة أقوى بوضوح.',
          ),
          ScenarioLabOption(
            id: 'job_offer_move_needs_structure',
            axis: 'plan_mid',
            labelEn:
                'Pause first and agree on a structured review before moving.',
            labelAr: 'نتوقف أولًا ونتفق على مراجعة منظمة قبل الانتقال.',
          ),
          ScenarioLabOption(
            id: 'job_offer_move_family_priority',
            axis: 'stability_high',
            labelEn:
                'Keep family stability first unless the need becomes urgent.',
            labelAr:
                'نُبقي استقرار العائلة أولًا إلا إذا أصبحت الحاجة ملحة جدًا.',
          ),
        ],
      ),
      ScenarioLabItem(
        id: 'family_boundary_visit',
        titleEn: 'Repeated family interference',
        titleAr: 'تدخل عائلي متكرر',
        bodyEn:
            'One family member keeps giving direct opinions about private couple decisions and expects frequent unplanned visits.',
        bodyAr:
            'أحد أفراد العائلة يستمر في إبداء رأي مباشر في قرارات خاصة بين الزوجين، ويتوقع زيارات متكررة غير مخطط لها.',
        focusEn: 'Family boundaries',
        focusAr: 'الحدود الأسرية',
        options: [
          ScenarioLabOption(
            id: 'family_boundary_soft',
            axis: 'soft_boundary',
            labelEn: 'Absorb the pressure and avoid direct confrontation.',
            labelAr: 'نستوعب الضغط ونتجنب المواجهة المباشرة.',
          ),
          ScenarioLabOption(
            id: 'family_boundary_joint',
            axis: 'joint_boundary',
            labelEn: 'Set one calm shared boundary and repeat it consistently.',
            labelAr: 'نضع حدًا مشتركًا بهدوء ونكرره بثبات.',
          ),
          ScenarioLabOption(
            id: 'family_boundary_hard',
            axis: 'hard_boundary',
            labelEn:
                'Respond firmly and reduce access if the pattern continues.',
            labelAr: 'نرد بحزم ونقلل الوصول إذا استمر النمط.',
          ),
        ],
      ),
      ScenarioLabItem(
        id: 'budget_stress_month',
        titleEn: 'Unexpected budget pressure',
        titleAr: 'ضغط مالي مفاجئ',
        bodyEn:
            'A difficult month happens with one emergency expense and one delayed payment. Both people feel pressure and want different priorities.',
        bodyAr:
            'يمر شهر صعب فيه مصروف طارئ وتأخر في أحد المدفوعات. يشعر الطرفان بالضغط، ولكل طرف أولوية مختلفة.',
        focusEn: 'Money under pressure',
        focusAr: 'المال تحت الضغط',
        options: [
          ScenarioLabOption(
            id: 'budget_stress_control',
            axis: 'control_high',
            labelEn:
                'Freeze optional spending immediately and centralize decisions.',
            labelAr: 'نوقف الإنفاق الاختياري فورًا ونركز القرار في جهة واحدة.',
          ),
          ScenarioLabOption(
            id: 'budget_stress_shared',
            axis: 'shared_review',
            labelEn:
                'Review the pressure together and split the tradeoffs clearly.',
            labelAr: 'نراجع الضغط معًا ونقسم التنازلات بوضوح.',
          ),
          ScenarioLabOption(
            id: 'budget_stress_flex',
            axis: 'flex_high',
            labelEn:
                'Keep the month flexible and avoid making hard restrictions too early.',
            labelAr: 'نبقي الشهر مرنًا ونتجنب القيود الصارمة مبكرًا.',
          ),
        ],
      ),
      ScenarioLabItem(
        id: 'conflict_after_tension',
        titleEn: 'Repair after a sharp disagreement',
        titleAr: 'إصلاح بعد خلاف حاد',
        bodyEn:
            'A sharp disagreement happens after a stressful day. The issue itself is small, but tone and timing make it heavier than it should be.',
        bodyAr:
            'يحدث خلاف حاد بعد يوم مرهق. أصل المشكلة صغير، لكن النبرة والتوقيت يجعلان الموقف أثقل مما ينبغي.',
        focusEn: 'Conflict repair',
        focusAr: 'إصلاح الخلاف',
        options: [
          ScenarioLabOption(
            id: 'conflict_after_tension_space',
            axis: 'space_first',
            labelEn:
                'Take space first and return later when both sides cool down.',
            labelAr: 'نأخذ مساحة أولًا ثم نعود لاحقًا بعد الهدوء.',
          ),
          ScenarioLabOption(
            id: 'conflict_after_tension_immediate',
            axis: 'repair_now',
            labelEn: 'Try to repair the issue the same day before it grows.',
            labelAr: 'نحاول إصلاح الأمر في نفس اليوم قبل أن يكبر.',
          ),
          ScenarioLabOption(
            id: 'conflict_after_tension_rules',
            axis: 'structured_repair',
            labelEn:
                'Pause the conflict and use agreed repair rules step by step.',
            labelAr: 'نوقف الخلاف ونستخدم قواعد إصلاح متفقًا عليها خطوة بخطوة.',
          ),
        ],
      ),
    ];
  }
}
