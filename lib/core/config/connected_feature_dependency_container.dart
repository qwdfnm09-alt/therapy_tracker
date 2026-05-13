import 'package:firebase_core/firebase_core.dart';

import '../../data/local/local_auth_repository.dart';
import '../../data/local/connected_feature_stub_repositories.dart';
import '../../data/remote/firebase_auth_repository.dart';
import '../../data/remote/firebase_expert_support_request_repository.dart';
import '../../data/remote/firebase_problem_box_submission_repository.dart';
import '../../domain/services/auth_repository.dart';
import '../../domain/services/ai_mediator_repository.dart';
import '../../domain/services/anonymous_problem_box_repository.dart';
import '../../domain/services/emergency_button_repository.dart';
import '../../domain/services/expert_support_repository.dart';
import '../../domain/services/expert_support_request_repository.dart';
import '../../domain/services/problem_box_submission_repository.dart';
import '../../domain/services/rewards_partners_repository.dart';
import 'backend_mode.dart';
import 'connected_feature_gates.dart';
import 'firebase_environment.dart';

class ConnectedFeatureDependencyContainer {
  const ConnectedFeatureDependencyContainer({
    required this.gates,
    required this.auth,
    required this.expertSupport,
    required this.expertSupportRequests,
    required this.aiMediator,
    required this.anonymousProblemBox,
    required this.problemBoxSubmissions,
    required this.emergencyButton,
    required this.rewardsPartners,
  });

  factory ConnectedFeatureDependencyContainer.forCurrentMode({
    ConnectedFeatureGates gates = const ConnectedFeatureGates(),
    bool? firebaseAppReady,
    AuthRepository Function()? remoteAuthFactory,
    ExpertSupportRequestRepository Function()?
    remoteExpertSupportRequestFactory,
    ProblemBoxSubmissionRepository Function()?
    remoteProblemBoxSubmissionFactory,
  }) {
    return ConnectedFeatureDependencyContainer.configured(
      gates: gates,
      mode: BackendConfig.currentMode,
      firebaseEnabled: FirebaseEnvironment.enabled,
      firebaseAppReady: firebaseAppReady,
      remoteAuthFactory: remoteAuthFactory,
      remoteExpertSupportRequestFactory: remoteExpertSupportRequestFactory,
      remoteProblemBoxSubmissionFactory: remoteProblemBoxSubmissionFactory,
    );
  }

  factory ConnectedFeatureDependencyContainer.configured({
    ConnectedFeatureGates gates = const ConnectedFeatureGates(),
    required BackendMode mode,
    required bool firebaseEnabled,
    bool? firebaseAppReady,
    AuthRepository Function()? remoteAuthFactory,
    ExpertSupportRequestRepository Function()?
    remoteExpertSupportRequestFactory,
    ProblemBoxSubmissionRepository Function()?
    remoteProblemBoxSubmissionFactory,
  }) {
    final remoteRuntimeReady = firebaseAppReady ?? _isFirebaseAppReady();

    return ConnectedFeatureDependencyContainer(
      gates: gates,
      auth:
          gates.isEnabled(
            ConnectedFeatureGates.auth,
            modeOverride: mode,
            firebaseEnabled: firebaseEnabled && remoteRuntimeReady,
          )
          ? (remoteAuthFactory?.call() ?? FirebaseAuthRepository())
          : const LocalAuthRepository(),
      expertSupport: LocalExpertSupportRepository(gates: gates),
      expertSupportRequests:
          gates.isEnabled(
            ConnectedFeatureGates.expertSupportRequests,
            modeOverride: mode,
            firebaseEnabled: firebaseEnabled && remoteRuntimeReady,
          )
          ? (remoteExpertSupportRequestFactory?.call() ??
                FirebaseExpertSupportRequestRepository())
          : LocalExpertSupportRequestRepository(gates: gates),
      aiMediator: LocalAiMediatorRepository(gates: gates),
      anonymousProblemBox: LocalAnonymousProblemBoxRepository(gates: gates),
      problemBoxSubmissions:
          gates.isEnabled(
            ConnectedFeatureGates.problemBoxSubmissions,
            modeOverride: mode,
            firebaseEnabled: firebaseEnabled && remoteRuntimeReady,
          )
          ? (remoteProblemBoxSubmissionFactory?.call() ??
                FirebaseProblemBoxSubmissionRepository())
          : const LocalProblemBoxSubmissionRepository(),
      emergencyButton: LocalEmergencyButtonRepository(gates: gates),
      rewardsPartners: LocalRewardsPartnersRepository(gates: gates),
    );
  }

  factory ConnectedFeatureDependencyContainer.localOnly({
    ConnectedFeatureGates gates = const ConnectedFeatureGates(),
  }) {
    return ConnectedFeatureDependencyContainer.configured(
      gates: gates,
      mode: BackendMode.localOnly,
      firebaseEnabled: false,
      firebaseAppReady: false,
    );
  }

  factory ConnectedFeatureDependencyContainer.firebase({
    ConnectedFeatureGates gates = const ConnectedFeatureGates(),
    BackendMode mode = BackendMode.connectedPreview,
    bool? firebaseAppReady,
    AuthRepository Function()? remoteAuthFactory,
    ExpertSupportRequestRepository Function()?
    remoteExpertSupportRequestFactory,
    ProblemBoxSubmissionRepository Function()?
    remoteProblemBoxSubmissionFactory,
  }) {
    return ConnectedFeatureDependencyContainer.configured(
      gates: gates,
      mode: mode,
      firebaseEnabled: true,
      firebaseAppReady: firebaseAppReady,
      remoteAuthFactory: remoteAuthFactory,
      remoteExpertSupportRequestFactory: remoteExpertSupportRequestFactory,
      remoteProblemBoxSubmissionFactory: remoteProblemBoxSubmissionFactory,
    );
  }

  final ConnectedFeatureGates gates;
  final AuthRepository auth;
  final ExpertSupportRepository expertSupport;
  final ExpertSupportRequestRepository expertSupportRequests;
  final AiMediatorRepository aiMediator;
  final AnonymousProblemBoxRepository anonymousProblemBox;
  final ProblemBoxSubmissionRepository problemBoxSubmissions;
  final EmergencyButtonRepository emergencyButton;
  final RewardsPartnersRepository rewardsPartners;

  BackendMode get mode => gates.mode;
}

bool _isFirebaseAppReady() {
  try {
    return Firebase.apps.isNotEmpty;
  } catch (_) {
    return false;
  }
}
