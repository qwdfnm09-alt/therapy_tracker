class WeeklyChallengeProgress {
  const WeeklyChallengeProgress({
    required this.completedIds,
    required this.updatedAtIso,
  });

  final List<String> completedIds;
  final String updatedAtIso;

  factory WeeklyChallengeProgress.fromJson(Map<String, dynamic> json) {
    return WeeklyChallengeProgress(
      completedIds: List<String>.from(json['completedIds'] as List<dynamic>),
      updatedAtIso: json['updatedAtIso'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'completedIds': completedIds, 'updatedAtIso': updatedAtIso};
  }
}
