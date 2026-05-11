import '../models/connected_feature_contract_status.dart';

abstract class RewardsPartnersRepository {
  Future<ConnectedFeatureContractStatus> getContractStatus();
}
