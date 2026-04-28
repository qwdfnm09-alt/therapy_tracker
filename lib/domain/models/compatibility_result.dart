class CompatibilityResult {
  const CompatibilityResult({
    required this.compatibilityPercentage,
    required this.marriageReadinessScore,
    required this.categoryScores,
    required this.strengthAreas,
    required this.riskAreas,
    required this.psychologicalNotes,
    required this.suggestedSessions,
  });

  final int compatibilityPercentage;
  final int marriageReadinessScore;
  final Map<String, int> categoryScores;
  final List<String> strengthAreas;
  final List<String> riskAreas;
  final List<String> psychologicalNotes;
  final List<String> suggestedSessions;

  Map<String, dynamic> toJson() {
    return {
      'compatibilityPercentage': compatibilityPercentage,
      'marriageReadinessScore': marriageReadinessScore,
      'categoryScores': categoryScores,
      'strengthAreas': strengthAreas,
      'riskAreas': riskAreas,
      'psychologicalNotes': psychologicalNotes,
      'suggestedSessions': suggestedSessions,
    };
  }

  factory CompatibilityResult.fromJson(Map<String, dynamic> json) {
    final rawScores = json['categoryScores'] as Map<String, dynamic>? ?? {};
    return CompatibilityResult(
      compatibilityPercentage:
          (json['compatibilityPercentage'] as num?)?.toInt() ?? 0,
      marriageReadinessScore:
          (json['marriageReadinessScore'] as num?)?.toInt() ?? 0,
      categoryScores: rawScores.map(
        (key, value) => MapEntry(key, (value as num).toInt()),
      ),
      strengthAreas: List<String>.from(
        json['strengthAreas'] as List? ?? const [],
      ),
      riskAreas: List<String>.from(json['riskAreas'] as List? ?? const []),
      psychologicalNotes: List<String>.from(
        json['psychologicalNotes'] as List? ?? const [],
      ),
      suggestedSessions: List<String>.from(
        json['suggestedSessions'] as List? ?? const [],
      ),
    );
  }
}
