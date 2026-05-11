import 'love_language_quiz_question.dart';

class LoveLanguageQuizResult {
  const LoveLanguageQuizResult({
    required this.primaryLanguageId,
    required this.scores,
    required this.selectedOptionIds,
    required this.createdAtIso,
  });

  final String primaryLanguageId;
  final Map<String, int> scores;
  final Map<String, String> selectedOptionIds;
  final String createdAtIso;

  factory LoveLanguageQuizResult.fromJson(Map<String, dynamic> json) {
    return LoveLanguageQuizResult(
      primaryLanguageId: json['primaryLanguageId'] as String,
      scores: Map<String, int>.from(json['scores'] as Map),
      selectedOptionIds: Map<String, String>.from(
        json['selectedOptionIds'] as Map,
      ),
      createdAtIso: json['createdAtIso'] as String,
    );
  }

  factory LoveLanguageQuizResult.fromSelections({
    required List<LoveLanguageQuizQuestion> questions,
    required Map<String, String> selectedOptionIds,
  }) {
    final scores = <String, int>{};
    final selectedByQuestion = <String, String>{};

    for (final question in questions) {
      final selectedOptionId = selectedOptionIds[question.id];
      if (selectedOptionId == null) continue;

      final option = question.options.where(
        (item) => item.id == selectedOptionId,
      );
      if (option.isEmpty) continue;

      final selectedOption = option.first;
      selectedByQuestion[question.id] = selectedOption.id;
      scores.update(
        selectedOption.languageId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    final rankedScores = scores.entries.toList()
      ..sort((a, b) {
        final byScore = b.value.compareTo(a.value);
        if (byScore != 0) return byScore;
        return a.key.compareTo(b.key);
      });

    final primaryLanguageId = rankedScores.isEmpty
        ? ''
        : rankedScores.first.key;

    return LoveLanguageQuizResult(
      primaryLanguageId: primaryLanguageId,
      scores: scores,
      selectedOptionIds: selectedByQuestion,
      createdAtIso: DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primaryLanguageId': primaryLanguageId,
      'scores': scores,
      'selectedOptionIds': selectedOptionIds,
      'createdAtIso': createdAtIso,
    };
  }
}
