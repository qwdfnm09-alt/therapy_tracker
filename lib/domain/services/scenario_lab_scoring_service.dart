import '../models/scenario_lab_item.dart';
import '../models/scenario_lab_summary.dart';

class ScenarioLabScoringService {
  const ScenarioLabScoringService();

  ScenarioLabSummary buildSummary({
    required List<ScenarioLabItem> scenarios,
    required Map<String, String> userAAnswers,
    required Map<String, String> userBAnswers,
  }) {
    var answeredScenarios = 0;
    var alignedCount = 0;
    var closeCount = 0;
    var gapCount = 0;
    final recommendations = <ScenarioLabRecommendation>[];

    for (final scenario in scenarios) {
      final userA = userAAnswers[scenario.id];
      final userB = userBAnswers[scenario.id];
      if (userA == null || userB == null) continue;

      answeredScenarios++;
      if (userA == userB) {
        alignedCount++;
        continue;
      }

      final userAOption = scenario.options.where((item) => item.id == userA);
      final userBOption = scenario.options.where((item) => item.id == userB);
      if (userAOption.isEmpty || userBOption.isEmpty) continue;

      if (userAOption.first.axis == userBOption.first.axis) {
        closeCount++;
        recommendations.add(
          ScenarioLabRecommendation(
            type: ScenarioLabRecommendationType.close,
            scenario: scenario,
            userAOptionId: userA,
            userBOptionId: userB,
          ),
        );
      } else {
        gapCount++;
        recommendations.add(
          ScenarioLabRecommendation(
            type: ScenarioLabRecommendationType.gap,
            scenario: scenario,
            userAOptionId: userA,
            userBOptionId: userB,
          ),
        );
      }
    }

    return ScenarioLabSummary(
      answeredScenarios: answeredScenarios,
      alignedCount: alignedCount,
      closeCount: closeCount,
      gapCount: gapCount,
      recommendations: [
        ...recommendations.where(
          (item) => item.type == ScenarioLabRecommendationType.gap,
        ),
        ...recommendations.where(
          (item) => item.type == ScenarioLabRecommendationType.close,
        ),
      ],
    );
  }
}
