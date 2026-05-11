import '../models/connected_feature_contract_status.dart';

abstract class AnonymousProblemBoxRepository {
  Future<ConnectedFeatureContractStatus> getContractStatus();
}
