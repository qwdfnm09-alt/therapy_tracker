import '../models/connected_feature_contract_status.dart';

abstract class ExpertSupportRepository {
  Future<ConnectedFeatureContractStatus> getContractStatus();
}
