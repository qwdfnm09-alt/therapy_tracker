import '../models/connected_feature_contract_status.dart';

abstract class EmergencyButtonRepository {
  Future<ConnectedFeatureContractStatus> getContractStatus();
}
