import 'backend_mode.dart';

class ConnectedFeatureGates {
  const ConnectedFeatureGates({this.overrides = const {}});

  static const auth = 'auth';
  static const expertSupport = 'expert_support';
  static const expertSupportRequests = 'expert_support_requests';
  static const aiMediator = 'ai_mediator';
  static const anonymousProblemBox = 'anonymous_problem_box';
  static const problemBoxSubmissions = 'problem_box_submissions';
  static const emergencyButton = 'emergency_button';
  static const rewardsPartners = 'rewards_partners';

  final Map<String, bool> overrides;

  BackendMode get mode => BackendConfig.currentMode;

  static const Map<String, bool> _defaultFlags = {
    auth: true,
    expertSupport: false,
    expertSupportRequests: true,
    aiMediator: false,
    anonymousProblemBox: false,
    problemBoxSubmissions: true,
    emergencyButton: false,
    rewardsPartners: false,
  };

  bool isConnectedRuntimeAvailable({
    BackendMode? modeOverride,
    bool firebaseEnabled = true,
  }) {
    return firebaseEnabled && (modeOverride ?? mode) != BackendMode.localOnly;
  }

  bool isEnabled(
    String featureId, {
    BackendMode? modeOverride,
    bool firebaseEnabled = true,
  }) {
    if (!isConnectedRuntimeAvailable(
      modeOverride: modeOverride,
      firebaseEnabled: firebaseEnabled,
    )) {
      return false;
    }
    return overrides[featureId] ?? _defaultFlags[featureId] ?? false;
  }
}
