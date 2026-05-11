import '../../core/config/backend_mode.dart';
import '../../core/config/connected_feature_gates.dart';
import '../../domain/models/connected_feature_item.dart';

class ConnectedFeaturesService {
  const ConnectedFeaturesService({this.gates = const ConnectedFeatureGates()});

  final ConnectedFeatureGates gates;

  List<ConnectedFeatureItem> items() {
    return const [
      ConnectedFeatureItem(
        id: 'expert_support',
        titleEn: 'Expert chat and video',
        titleAr: 'دردشة ومكالمات الخبراء',
        summaryEn:
            'Requires identity, scheduling, expert operations, and a protected backend channel before any live counseling can be offered inside the app.',
        summaryAr:
            'تحتاج إلى هوية مستخدم، وجدولة، وتشغيل للخبراء، وقناة خلفية محمية قبل تقديم أي استشارات حية داخل التطبيق.',
        availability: ConnectedFeatureAvailability.planned,
        requirements: [
          ConnectedFeatureRequirement.auth,
          ConnectedFeatureRequirement.backendApi,
          ConnectedFeatureRequirement.privacyConsent,
          ConnectedFeatureRequirement.expertOperations,
        ],
      ),
      ConnectedFeatureItem(
        id: 'ai_mediator',
        titleEn: 'AI mediator',
        titleAr: 'وسيط ذكي',
        summaryEn:
            'Needs server-side orchestration, prompt controls, abuse handling, and consent rules before the app can offer conflict mediation safely.',
        summaryAr:
            'يحتاج إلى تشغيل من الخادم، وضوابط للموجهات، ومعالجة للإساءة، وقواعد موافقة قبل تقديم وساطة ذكية بشكل آمن.',
        availability: ConnectedFeatureAvailability.planned,
        requirements: [
          ConnectedFeatureRequirement.backendApi,
          ConnectedFeatureRequirement.privacyConsent,
          ConnectedFeatureRequirement.moderation,
        ],
      ),
      ConnectedFeatureItem(
        id: 'anonymous_problem_box',
        titleEn: 'Anonymous problem box',
        titleAr: 'صندوق مشاكل مجهول',
        summaryEn:
            'Needs intake moderation, privacy review, and backend storage boundaries before users can submit sensitive relationship issues.',
        summaryAr:
            'يحتاج إلى مراجعة للمحتوى، ومراجعة خصوصية، وحدود تخزين خلفي قبل السماح بإرسال مشكلات حساسة بين الأطراف.',
        availability: ConnectedFeatureAvailability.planned,
        requirements: [
          ConnectedFeatureRequirement.backendApi,
          ConnectedFeatureRequirement.privacyConsent,
          ConnectedFeatureRequirement.moderation,
        ],
      ),
      ConnectedFeatureItem(
        id: 'emergency_button',
        titleEn: 'Emergency button',
        titleAr: 'زر طوارئ',
        summaryEn:
            'Needs verified routing rules, safety operations, and explicit consent handling before the app can escalate emergency flows.',
        summaryAr:
            'يحتاج إلى قواعد توجيه موثقة، وتشغيل سلامة، وتعامل صريح مع الموافقة قبل رفع أي مسار طوارئ من داخل التطبيق.',
        availability: ConnectedFeatureAvailability.planned,
        requirements: [
          ConnectedFeatureRequirement.backendApi,
          ConnectedFeatureRequirement.privacyConsent,
          ConnectedFeatureRequirement.safetyRouting,
        ],
      ),
      ConnectedFeatureItem(
        id: 'rewards_partners',
        titleEn: 'Rewards and partner integrations',
        titleAr: 'المكافآت وتكاملات الشركاء',
        summaryEn:
            'Needs partner contracts, backend APIs, and consent-aware data boundaries before any reward or discount program can be activated.',
        summaryAr:
            'يحتاج إلى اتفاقات مع الشركاء، وواجهات خلفية، وحدود بيانات مرتبطة بالموافقة قبل تفعيل أي برنامج خصومات أو مكافآت.',
        availability: ConnectedFeatureAvailability.planned,
        requirements: [
          ConnectedFeatureRequirement.backendApi,
          ConnectedFeatureRequirement.privacyConsent,
          ConnectedFeatureRequirement.partnerOperations,
        ],
      ),
    ];
  }

  ConnectedFeaturesOverview buildOverview(List<ConnectedFeatureItem> items) {
    final enabledCount = items.where((item) => gates.isEnabled(item.id)).length;
    return ConnectedFeaturesOverview(
      mode: gates.mode,
      totalCount: items.length,
      enabledCount: enabledCount,
      gatedCount: items.length - enabledCount,
    );
  }

  ConnectedFeatureRuntimeStatus runtimeStatusFor(ConnectedFeatureItem item) {
    return gates.isEnabled(item.id)
        ? ConnectedFeatureRuntimeStatus.enabled
        : ConnectedFeatureRuntimeStatus.gated;
  }
}

enum ConnectedFeatureRuntimeStatus { gated, enabled }

class ConnectedFeaturesOverview {
  const ConnectedFeaturesOverview({
    required this.mode,
    required this.totalCount,
    required this.enabledCount,
    required this.gatedCount,
  });

  final BackendMode mode;
  final int totalCount;
  final int enabledCount;
  final int gatedCount;
}
