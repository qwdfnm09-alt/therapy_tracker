import '../models/connected_feature_contract_status.dart';
import '../services/ai_mediator_repository.dart';
import '../services/anonymous_problem_box_repository.dart';
import '../services/emergency_button_repository.dart';
import '../services/expert_support_repository.dart';
import '../services/rewards_partners_repository.dart';

class GetExpertSupportStatusUseCase {
  const GetExpertSupportStatusUseCase(this.repository);

  final ExpertSupportRepository repository;

  Future<ConnectedFeatureContractStatus> execute() {
    return repository.getContractStatus();
  }
}

class GetAiMediatorStatusUseCase {
  const GetAiMediatorStatusUseCase(this.repository);

  final AiMediatorRepository repository;

  Future<ConnectedFeatureContractStatus> execute() {
    return repository.getContractStatus();
  }
}

class GetAnonymousProblemBoxStatusUseCase {
  const GetAnonymousProblemBoxStatusUseCase(this.repository);

  final AnonymousProblemBoxRepository repository;

  Future<ConnectedFeatureContractStatus> execute() {
    return repository.getContractStatus();
  }
}

class GetEmergencyButtonStatusUseCase {
  const GetEmergencyButtonStatusUseCase(this.repository);

  final EmergencyButtonRepository repository;

  Future<ConnectedFeatureContractStatus> execute() {
    return repository.getContractStatus();
  }
}

class GetRewardsPartnersStatusUseCase {
  const GetRewardsPartnersStatusUseCase(this.repository);

  final RewardsPartnersRepository repository;

  Future<ConnectedFeatureContractStatus> execute() {
    return repository.getContractStatus();
  }
}
