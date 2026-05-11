import '../models/connected_feature_contract_status.dart';

abstract class AiMediatorRepository {
  Future<ConnectedFeatureContractStatus> getContractStatus();
}
