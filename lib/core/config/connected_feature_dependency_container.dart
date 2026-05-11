import '../../data/local/connected_feature_stub_repositories.dart';
import '../../domain/services/ai_mediator_repository.dart';
import '../../domain/services/anonymous_problem_box_repository.dart';
import '../../domain/services/emergency_button_repository.dart';
import '../../domain/services/expert_support_repository.dart';
import '../../domain/services/rewards_partners_repository.dart';
import 'backend_mode.dart';
import 'connected_feature_gates.dart';

class ConnectedFeatureDependencyContainer {
  const ConnectedFeatureDependencyContainer({
    required this.gates,
    required this.expertSupport,
    required this.aiMediator,
    required this.anonymousProblemBox,
    required this.emergencyButton,
    required this.rewardsPartners,
  });

  factory ConnectedFeatureDependencyContainer.forCurrentMode({
    ConnectedFeatureGates gates = const ConnectedFeatureGates(),
  }) {
    switch (BackendConfig.currentMode) {
      case BackendMode.localOnly:
      case BackendMode.connectedPreview:
      case BackendMode.connectedLive:
        return ConnectedFeatureDependencyContainer.localOnly(gates: gates);
    }
  }

  factory ConnectedFeatureDependencyContainer.localOnly({
    ConnectedFeatureGates gates = const ConnectedFeatureGates(),
  }) {
    return ConnectedFeatureDependencyContainer(
      gates: gates,
      expertSupport: LocalExpertSupportRepository(gates: gates),
      aiMediator: LocalAiMediatorRepository(gates: gates),
      anonymousProblemBox: LocalAnonymousProblemBoxRepository(gates: gates),
      emergencyButton: LocalEmergencyButtonRepository(gates: gates),
      rewardsPartners: LocalRewardsPartnersRepository(gates: gates),
    );
  }

  final ConnectedFeatureGates gates;
  final ExpertSupportRepository expertSupport;
  final AiMediatorRepository aiMediator;
  final AnonymousProblemBoxRepository anonymousProblemBox;
  final EmergencyButtonRepository emergencyButton;
  final RewardsPartnersRepository rewardsPartners;

  BackendMode get mode => gates.mode;
}
