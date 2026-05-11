import 'scenario_lab_item.dart';

class ScenarioLabSummary {
  const ScenarioLabSummary({
    required this.answeredScenarios,
    required this.alignedCount,
    required this.closeCount,
    required this.gapCount,
    required this.recommendations,
  });

  final int answeredScenarios;
  final int alignedCount;
  final int closeCount;
  final int gapCount;
  final List<ScenarioLabRecommendation> recommendations;
}

enum ScenarioLabRecommendationType { close, gap }

class ScenarioLabRecommendation {
  const ScenarioLabRecommendation({
    required this.type,
    required this.scenario,
    required this.userAOptionId,
    required this.userBOptionId,
  });

  final ScenarioLabRecommendationType type;
  final ScenarioLabItem scenario;
  final String userAOptionId;
  final String userBOptionId;

  ScenarioLabOption get userAOption =>
      scenario.options.firstWhere((item) => item.id == userAOptionId);

  ScenarioLabOption get userBOption =>
      scenario.options.firstWhere((item) => item.id == userBOptionId);
}
