import '../models/compatibility_result.dart';
import '../models/participant_profile.dart';
import '../models/question.dart';

class CompatibilityScoringService {
  CompatibilityResult analyze(
    ParticipantProfile userA,
    ParticipantProfile userB,
  ) {
    final categoryScores = <String, int>{};

    for (final category in QuestionCategory.values) {
      final questions = compatibilityQuestions
          .where((q) => q.category == category)
          .toList();
      final scores = questions.map((q) {
        final a = userA.answers[q.id] ?? 3;
        final b = userB.answers[q.id] ?? 3;
        return switch (q.mode) {
          ScoringMode.similarity => _similarityScore(a, b),
          ScoringMode.healthyAverage => _healthyAverageScore(a, b),
        };
      });
      categoryScores[_categoryLabel(category)] = _average(scores);
    }

    final compatibility = _average(categoryScores.values);
    final readiness = _readinessScore(categoryScores);

    return CompatibilityResult(
      compatibilityPercentage: compatibility,
      marriageReadinessScore: readiness,
      categoryScores: categoryScores,
      strengthAreas: _strengths(categoryScores),
      riskAreas: _risks(categoryScores),
      psychologicalNotes: _notes(categoryScores, compatibility, readiness),
      suggestedSessions: _sessions(categoryScores, compatibility, readiness),
    );
  }

  int _similarityScore(int a, int b) {
    final distance = (a - b).abs();
    return (100 - (distance * 25)).clamp(0, 100);
  }

  int _healthyAverageScore(int a, int b) {
    final average = (a + b) / 2;
    final base = ((average - 1) / 4 * 100).round();
    final gapPenalty = (a - b).abs() * 8;
    return (base - gapPenalty).clamp(0, 100);
  }

  int _average(Iterable<int> values) {
    if (values.isEmpty) return 0;
    return (values.reduce((a, b) => a + b) / values.length).round();
  }

  int _readinessScore(Map<String, int> scores) {
    const weights = {
      'Emotional intelligence': 1.25,
      'Anger management': 1.25,
      'Communication': 1.2,
      'Responsibility': 1.15,
      'Family boundaries': 1.0,
      'Financial mindset': 0.95,
      'Future goals': 0.9,
      'Personality': 0.8,
    };

    var total = 0.0;
    var weightTotal = 0.0;
    scores.forEach((key, value) {
      final weight = weights[key] ?? 1.0;
      total += value * weight;
      weightTotal += weight;
    });
    return (total / weightTotal).round().clamp(0, 100);
  }

  List<String> _strengths(Map<String, int> scores) {
    final entries = scores.entries.where((entry) => entry.value >= 75).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (entries.isEmpty) {
      return [
        'Shared effort is visible, but no category is strongly aligned yet.',
      ];
    }
    return entries
        .map((entry) => '${entry.key}: ${entry.value}% alignment')
        .toList();
  }

  List<String> _risks(Map<String, int> scores) {
    final entries = scores.entries.where((entry) => entry.value < 60).toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    if (entries.isEmpty) {
      return ['No high-risk area detected by the current scoring profile.'];
    }
    return entries
        .map((entry) => '${entry.key}: needs structured discussion')
        .toList();
  }

  List<String> _notes(
    Map<String, int> scores,
    int compatibility,
    int readiness,
  ) {
    final notes = <String>[];
    if (compatibility >= 80) {
      notes.add(
        'The couple shows strong alignment, but expectations should still be discussed explicitly.',
      );
    } else if (compatibility >= 65) {
      notes.add(
        'The relationship has workable compatibility with several topics needing guided conversation.',
      );
    } else {
      notes.add(
        'Compatibility is currently fragile. A counselor should review the main gaps before commitment.',
      );
    }

    if ((scores['Anger management'] ?? 100) < 60) {
      notes.add(
        'Conflict repair and anger regulation need attention before marriage pressure increases.',
      );
    }
    if ((scores['Family boundaries'] ?? 100) < 60) {
      notes.add(
        'Family boundary expectations may cause repeated stress if they remain vague.',
      );
    }
    if (readiness < 65) {
      notes.add(
        'Marriage readiness is below the recommended threshold for a confident decision.',
      );
    }
    return notes;
  }

  List<String> _sessions(
    Map<String, int> scores,
    int compatibility,
    int readiness,
  ) {
    final sessions = <String>[];
    if ((scores['Communication'] ?? 100) < 70) {
      sessions.add('Communication and conflict dialogue session');
    }
    if ((scores['Family boundaries'] ?? 100) < 70) {
      sessions.add('Family boundaries consultation');
    }
    if ((scores['Financial mindset'] ?? 100) < 70 ||
        (scores['Future goals'] ?? 100) < 70) {
      sessions.add('Future planning and financial expectations session');
    }
    if (compatibility < 65 || readiness < 65) {
      sessions.add('Individual psychological readiness review');
    }
    return sessions.isEmpty
        ? ['One pre-marriage coaching session for final alignment']
        : sessions;
  }

  String _categoryLabel(QuestionCategory category) {
    return switch (category) {
      QuestionCategory.personality => 'Personality',
      QuestionCategory.emotionalIntelligence => 'Emotional intelligence',
      QuestionCategory.angerManagement => 'Anger management',
      QuestionCategory.communication => 'Communication',
      QuestionCategory.financialMindset => 'Financial mindset',
      QuestionCategory.familyBoundaries => 'Family boundaries',
      QuestionCategory.futureGoals => 'Future goals',
      QuestionCategory.responsibility => 'Responsibility',
    };
  }
}
