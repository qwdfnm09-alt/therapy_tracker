import '../../core/config/connected_feature_gates.dart';
import '../../domain/models/connected_feature_contract_status.dart';
import '../../domain/models/expert_support_request.dart';
import '../../domain/models/expert_support_submission_result.dart';
import '../../domain/models/problem_box_submission.dart';
import '../../domain/models/problem_box_submission_result.dart';
import '../../domain/services/ai_mediator_repository.dart';
import '../../domain/services/anonymous_problem_box_repository.dart';
import '../../domain/services/emergency_button_repository.dart';
import '../../domain/services/expert_support_repository.dart';
import '../../domain/services/expert_support_request_repository.dart';
import '../../domain/services/problem_box_submission_repository.dart';
import '../../domain/services/rewards_partners_repository.dart';

class LocalExpertSupportRepository implements ExpertSupportRepository {
  const LocalExpertSupportRepository({
    this.gates = const ConnectedFeatureGates(),
  });

  final ConnectedFeatureGates gates;

  @override
  Future<ConnectedFeatureContractStatus> getContractStatus() async {
    return _buildStatus(
      featureId: 'expert_support',
      gates: gates,
      messageEn:
          'Local stub only. Expert chat and video are intentionally blocked until auth, scheduling, and backend delivery are introduced.',
      messageAr:
          'هذه مجرد وصلة محلية بديلة. دردشة ومكالمات الخبراء مقفولة عمدًا إلى أن تتم إضافة الهوية والجدولة والتنفيذ الخلفي.',
    );
  }
}

class LocalExpertSupportRequestRepository
    implements ExpertSupportRequestRepository {
  const LocalExpertSupportRequestRepository({
    this.gates = const ConnectedFeatureGates(),
  });

  final ConnectedFeatureGates gates;

  @override
  Future<ExpertSupportSubmissionResult> submitRequest(
    ExpertSupportRequest request,
  ) async {
    return const ExpertSupportSubmissionResult(
      submitted: false,
      channel: 'local_stub',
      message: 'remote_request_disabled_in_local_mode',
    );
  }
}

class LocalAiMediatorRepository implements AiMediatorRepository {
  const LocalAiMediatorRepository({this.gates = const ConnectedFeatureGates()});

  final ConnectedFeatureGates gates;

  @override
  Future<ConnectedFeatureContractStatus> getContractStatus() async {
    return _buildStatus(
      featureId: 'ai_mediator',
      gates: gates,
      messageEn:
          'Local stub only. AI mediation is intentionally blocked until server orchestration and moderation policy exist.',
      messageAr:
          'هذه مجرد وصلة محلية بديلة. الوسيط الذكي مقفول عمدًا إلى أن توجد طبقة تشغيل خادمية وسياسة مراجعة واضحة.',
    );
  }
}

class LocalAnonymousProblemBoxRepository
    implements AnonymousProblemBoxRepository {
  const LocalAnonymousProblemBoxRepository({
    this.gates = const ConnectedFeatureGates(),
  });

  final ConnectedFeatureGates gates;

  @override
  Future<ConnectedFeatureContractStatus> getContractStatus() async {
    return _buildStatus(
      featureId: 'anonymous_problem_box',
      gates: gates,
      messageEn:
          'Local stub only. Anonymous submissions are intentionally blocked until moderation and protected backend storage exist.',
      messageAr:
          'هذه مجرد وصلة محلية بديلة. الإرسال المجهول مقفول عمدًا إلى أن توجد مراجعة محتوى وتخزين خلفي محمي.',
    );
  }
}

class LocalProblemBoxSubmissionRepository
    implements ProblemBoxSubmissionRepository {
  const LocalProblemBoxSubmissionRepository();

  @override
  Future<ProblemBoxSubmissionResult> submit(
    ProblemBoxSubmission submission,
  ) async {
    return const ProblemBoxSubmissionResult(
      submitted: false,
      providerKey: 'local_stub',
      message: 'problemBoxDisabled',
    );
  }
}

class LocalEmergencyButtonRepository implements EmergencyButtonRepository {
  const LocalEmergencyButtonRepository({
    this.gates = const ConnectedFeatureGates(),
  });

  final ConnectedFeatureGates gates;

  @override
  Future<ConnectedFeatureContractStatus> getContractStatus() async {
    return _buildStatus(
      featureId: 'emergency_button',
      gates: gates,
      messageEn:
          'Local stub only. Emergency escalation is intentionally blocked until verified routing and safety operations exist.',
      messageAr:
          'هذه مجرد وصلة محلية بديلة. تصعيد الطوارئ مقفول عمدًا إلى أن توجد مسارات موثقة وتشغيل سلامة واضح.',
    );
  }
}

class LocalRewardsPartnersRepository implements RewardsPartnersRepository {
  const LocalRewardsPartnersRepository({
    this.gates = const ConnectedFeatureGates(),
  });

  final ConnectedFeatureGates gates;

  @override
  Future<ConnectedFeatureContractStatus> getContractStatus() async {
    return _buildStatus(
      featureId: 'rewards_partners',
      gates: gates,
      messageEn:
          'Local stub only. Rewards and partner integrations are intentionally blocked until partner contracts and backend APIs exist.',
      messageAr:
          'هذه مجرد وصلة محلية بديلة. المكافآت وتكاملات الشركاء مقفولة عمدًا إلى أن توجد اتفاقات الشركاء وواجهات الخلفية.',
    );
  }
}

class LocalConnectedFeatureRepositoryRegistry {
  const LocalConnectedFeatureRepositoryRegistry({
    this.expertSupport = const LocalExpertSupportRepository(),
    this.expertSupportRequests = const LocalExpertSupportRequestRepository(),
    this.aiMediator = const LocalAiMediatorRepository(),
    this.anonymousProblemBox = const LocalAnonymousProblemBoxRepository(),
    this.problemBoxSubmissions = const LocalProblemBoxSubmissionRepository(),
    this.emergencyButton = const LocalEmergencyButtonRepository(),
    this.rewardsPartners = const LocalRewardsPartnersRepository(),
  });

  final ExpertSupportRepository expertSupport;
  final ExpertSupportRequestRepository expertSupportRequests;
  final AiMediatorRepository aiMediator;
  final AnonymousProblemBoxRepository anonymousProblemBox;
  final ProblemBoxSubmissionRepository problemBoxSubmissions;
  final EmergencyButtonRepository emergencyButton;
  final RewardsPartnersRepository rewardsPartners;
}

ConnectedFeatureContractStatus _buildStatus({
  required String featureId,
  required ConnectedFeatureGates gates,
  required String messageEn,
  required String messageAr,
}) {
  return ConnectedFeatureContractStatus(
    featureId: featureId,
    mode: gates.mode,
    enabled: gates.isEnabled(featureId),
    providerKey: 'local_stub',
    messageEn: messageEn,
    messageAr: messageAr,
  );
}
