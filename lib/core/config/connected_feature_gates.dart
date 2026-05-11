import 'backend_mode.dart';

class ConnectedFeatureGates {
  const ConnectedFeatureGates();

  BackendMode get mode => BackendConfig.currentMode;

  static const Map<String, bool> _flags = {
    'expert_support': false,
    'ai_mediator': false,
    'anonymous_problem_box': false,
    'emergency_button': false,
    'rewards_partners': false,
  };

  bool isEnabled(String featureId) {
    if (mode == BackendMode.localOnly) return false;
    return _flags[featureId] ?? false;
  }
}
