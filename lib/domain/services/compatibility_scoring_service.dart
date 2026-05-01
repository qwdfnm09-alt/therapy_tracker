import '../models/compatibility_result.dart';
import '../models/participant_profile.dart';
import '../models/question.dart';

class CompatibilityScoringService {
  CompatibilityResult analyze(
    ParticipantProfile userA,
    ParticipantProfile userB,
    List<CompatibilityQuestion> activeQuestions,
  ) {
    final categoryScores = <String, int>{};
    final criticalPressures = _criticalPressureCategories(userA, userB);

    for (final category in QuestionCategory.values) {
      final questions = activeQuestions
          .where((q) => q.category == category)
          .toList();
      final weightedScores = questions.map((q) {
        final a = userA.answers[q.id] ?? 3;
        final b = userB.answers[q.id] ?? 3;
        final score = switch (q.mode) {
          ScoringMode.similarity => _similarityScore(q.id, a, b),
          ScoringMode.healthyAverage => _healthyAverageScore(q.id, a, b),
        };
        return (score, _questionWeight(q.id));
      });
      categoryScores[_categoryKey(category)] = _weightedAverage(weightedScores);
    }

    final compatibility = _compatibilityScore(userA, userB, categoryScores);
    final readiness = _readinessScore(
      userA,
      userB,
      categoryScores,
      criticalPressures,
    );

    return CompatibilityResult(
      compatibilityPercentage: compatibility,
      marriageReadinessScore: readiness,
      categoryScores: categoryScores,
      partnerArchetypes: {
        'userA': _partnerArchetype(userA),
        'userB': _partnerArchetype(userB),
      },
      partnerProfiles: {
        'userA': _partnerProfile(userA),
        'userB': _partnerProfile(userB),
      },
      relationshipDynamics: _relationshipDynamics(userA, userB),
      strengthAreas: _strengths(categoryScores),
      riskAreas: _risks(categoryScores, criticalPressures),
      psychologicalNotes: _notes(
        categoryScores,
        compatibility,
        readiness,
        criticalPressures,
      ),
      suggestedSessions: _sessions(
        categoryScores,
        compatibility,
        readiness,
        criticalPressures,
      ),
    );
  }

  int _similarityScore(String questionId, int a, int b) {
    final distance = (a - b).abs();
    final average = (a + b) / 2;
    final base = 100 - (distance * 25);
    final alignmentBonus = distance <= 1 && average >= 3 ? 6 : 0;
    final extremeGapPenalty = distance >= 3 ? 10 : 0;
    final fragileLowPenalty = _isCriticalQuestion(questionId) && average <= 2.5
        ? 8
        : 0;
    return (base + alignmentBonus - extremeGapPenalty - fragileLowPenalty)
        .clamp(0, 100);
  }

  int _healthyAverageScore(String questionId, int a, int b) {
    final average = (a + b) / 2;
    final base = ((average - 1) / 4 * 100).round();
    final gapPenalty = (a - b).abs() * 10;
    final lowFloorPenalty =
        (a <= 2 ? 12 : 0) + (b <= 2 ? 12 : 0) + (a == 1 || b == 1 ? 8 : 0);
    final criticalPenalty =
        _isCriticalQuestion(questionId) && (a <= 2 || b <= 2) ? 10 : 0;
    final regulationBonus = a >= 4 && b >= 4 ? 6 : 0;
    return (base -
            gapPenalty -
            lowFloorPenalty -
            criticalPenalty +
            regulationBonus)
        .clamp(0, 100);
  }

  int _average(Iterable<int> values) {
    if (values.isEmpty) return 0;
    return (values.reduce((a, b) => a + b) / values.length).round();
  }

  int _weightedAverage(Iterable<(int score, double weight)> values) {
    var total = 0.0;
    var weightTotal = 0.0;
    for (final entry in values) {
      total += entry.$1 * entry.$2;
      weightTotal += entry.$2;
    }
    if (weightTotal == 0) return 0;
    return (total / weightTotal).round();
  }

  int _compatibilityScore(
    ParticipantProfile userA,
    ParticipantProfile userB,
    Map<String, int> scores,
  ) {
    var score = _average(scores.values);
    score -= _gapPressurePenalty(userA, userB);
    score += _stableAlignmentBonus(userA, userB);
    return score.clamp(0, 100);
  }

  int _readinessScore(
    ParticipantProfile userA,
    ParticipantProfile userB,
    Map<String, int> scores,
    Set<String> criticalPressures,
  ) {
    const weights = {
      'emotionalIntelligence': 1.25,
      'angerManagement': 1.25,
      'communication': 1.2,
      'responsibility': 1.15,
      'familyBoundaries': 1.0,
      'financialMindset': 0.95,
      'futureGoals': 0.9,
      'personality': 0.8,
    };

    var total = 0.0;
    var weightTotal = 0.0;
    scores.forEach((key, value) {
      final weight = weights[key] ?? 1.0;
      total += value * weight;
      weightTotal += weight;
    });
    var score = (total / weightTotal).round();
    score -= criticalPressures.length * 4;
    score -= _individualReadinessPenalty(userA);
    score -= _individualReadinessPenalty(userB);
    score += _sharedStabilityBonus(userA, userB);
    return score.clamp(0, 100);
  }

  List<String> _strengths(Map<String, int> scores) {
    final entries = scores.entries.where((entry) => entry.value >= 75).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    if (entries.isEmpty) {
      return const ['strength:none'];
    }
    return entries
        .map((entry) => 'strength:${entry.key}:${entry.value}')
        .toList();
  }

  List<String> _risks(Map<String, int> scores, Set<String> criticalPressures) {
    final entries =
        scores.entries
            .where(
              (entry) =>
                  entry.value < 60 || criticalPressures.contains(entry.key),
            )
            .toList()
          ..sort((a, b) => a.value.compareTo(b.value));
    if (entries.isEmpty) {
      return const ['risk:none'];
    }
    return {for (final entry in entries) 'risk:${entry.key}'}.toList();
  }

  List<String> _notes(
    Map<String, int> scores,
    int compatibility,
    int readiness,
    Set<String> criticalPressures,
  ) {
    final notes = <String>[];
    if (compatibility >= 80) {
      notes.add('note:strongAlignment');
    } else if (compatibility >= 65) {
      notes.add('note:workableCompatibility');
    } else {
      notes.add('note:fragileCompatibility');
    }

    if ((scores['angerManagement'] ?? 100) < 60 ||
        criticalPressures.contains('angerManagement')) {
      notes.add('note:angerManagement');
    }
    if ((scores['familyBoundaries'] ?? 100) < 60 ||
        criticalPressures.contains('familyBoundaries')) {
      notes.add('note:familyBoundaries');
    }
    if (readiness < 65) {
      notes.add('note:readinessThreshold');
    }
    return notes;
  }

  List<String> _sessions(
    Map<String, int> scores,
    int compatibility,
    int readiness,
    Set<String> criticalPressures,
  ) {
    final sessions = <String>[];
    if ((scores['communication'] ?? 100) < 70 ||
        criticalPressures.contains('communication')) {
      sessions.add('session:communication');
    }
    if ((scores['familyBoundaries'] ?? 100) < 70 ||
        criticalPressures.contains('familyBoundaries')) {
      sessions.add('session:familyBoundaries');
    }
    if ((scores['financialMindset'] ?? 100) < 70 ||
        (scores['futureGoals'] ?? 100) < 70 ||
        criticalPressures.contains('futureGoals')) {
      sessions.add('session:futurePlanning');
    }
    if (compatibility < 65 ||
        readiness < 65 ||
        criticalPressures.contains('angerManagement') ||
        criticalPressures.contains('emotionalIntelligence')) {
      sessions.add('session:individualReadiness');
    }
    return sessions.isEmpty ? const ['session:alignment'] : sessions;
  }

  String _categoryKey(QuestionCategory category) {
    return switch (category) {
      QuestionCategory.personality => 'personality',
      QuestionCategory.emotionalIntelligence => 'emotionalIntelligence',
      QuestionCategory.angerManagement => 'angerManagement',
      QuestionCategory.communication => 'communication',
      QuestionCategory.financialMindset => 'financialMindset',
      QuestionCategory.familyBoundaries => 'familyBoundaries',
      QuestionCategory.futureGoals => 'futureGoals',
      QuestionCategory.responsibility => 'responsibility',
    };
  }

  double _questionWeight(String questionId) {
    return switch (questionId) {
      'anger_pause' ||
      'anger_repair' ||
      'emotion_self_awareness' ||
      'emotion_empathy' ||
      'family_boundaries' ||
      'responsibility_commitment' => 1.25,
      'future_career_tradeoff' ||
      'family_interference' ||
      'anger_escalation' => 1.15,
      'communication_direct' ||
      'communication_daily' ||
      'finance_budget' ||
      'future_career' => 1.05,
      _ => 1.0,
    };
  }

  bool _isCriticalQuestion(String questionId) {
    return switch (questionId) {
      'anger_pause' ||
      'anger_repair' ||
      'anger_escalation' ||
      'emotion_self_awareness' ||
      'emotion_empathy' ||
      'family_boundaries' ||
      'family_interference' ||
      'responsibility_commitment' ||
      'future_career_tradeoff' => true,
      _ => false,
    };
  }

  Set<String> _criticalPressureCategories(
    ParticipantProfile userA,
    ParticipantProfile userB,
  ) {
    final pressures = <String>{};

    void checkLow(String category, String questionId, {int threshold = 2}) {
      final a = userA.answers[questionId] ?? 3;
      final b = userB.answers[questionId] ?? 3;
      if (a <= threshold || b <= threshold) {
        pressures.add(category);
      }
    }

    checkLow('angerManagement', 'anger_pause');
    checkLow('angerManagement', 'anger_repair');
    checkLow('emotionalIntelligence', 'emotion_self_awareness');
    checkLow('emotionalIntelligence', 'emotion_empathy');
    checkLow('familyBoundaries', 'family_boundaries');
    checkLow('responsibility', 'responsibility_commitment');
    checkLow('futureGoals', 'future_career_tradeoff');

    final directA = userA.answers['communication_direct'] ?? 3;
    final directB = userB.answers['communication_direct'] ?? 3;
    final dailyA = userA.answers['communication_daily'] ?? 3;
    final dailyB = userB.answers['communication_daily'] ?? 3;
    if ((directA - directB).abs() >= 3 || (dailyA - dailyB).abs() >= 3) {
      pressures.add('communication');
    }

    return pressures;
  }

  int _gapPressurePenalty(ParticipantProfile userA, ParticipantProfile userB) {
    final keyQuestions = const [
      'personality_structure',
      'communication_daily',
      'finance_budget',
      'family_boundaries',
      'future_children',
      'future_career',
    ];
    var penalty = 0;
    for (final questionId in keyQuestions) {
      final a = userA.answers[questionId] ?? 3;
      final b = userB.answers[questionId] ?? 3;
      final gap = (a - b).abs();
      if (gap >= 3) {
        penalty += 4;
      } else if (gap == 2) {
        penalty += 2;
      }
    }
    return penalty;
  }

  int _stableAlignmentBonus(
    ParticipantProfile userA,
    ParticipantProfile userB,
  ) {
    final repairA =
        ((userA.answers['anger_pause'] ?? 3) +
            (userA.answers['anger_repair'] ?? 3)) /
        2;
    final repairB =
        ((userB.answers['anger_pause'] ?? 3) +
            (userB.answers['anger_repair'] ?? 3)) /
        2;
    final empathyA = userA.answers['emotion_empathy'] ?? 3;
    final empathyB = userB.answers['emotion_empathy'] ?? 3;
    if (repairA >= 4 && repairB >= 4 && empathyA >= 4 && empathyB >= 4) {
      return 3;
    }
    return 0;
  }

  int _individualReadinessPenalty(ParticipantProfile user) {
    final floors = [
      user.answers['anger_pause'] ?? 3,
      user.answers['anger_repair'] ?? 3,
      user.answers['emotion_self_awareness'] ?? 3,
      user.answers['responsibility_commitment'] ?? 3,
    ];
    var penalty = 0;
    for (final value in floors) {
      if (value <= 2) {
        penalty += 3;
      }
      if (value == 1) {
        penalty += 2;
      }
    }
    return penalty;
  }

  int _sharedStabilityBonus(
    ParticipantProfile userA,
    ParticipantProfile userB,
  ) {
    final aStable = _individualReadinessPenalty(userA) == 0;
    final bStable = _individualReadinessPenalty(userB) == 0;
    return aStable && bStable ? 3 : 0;
  }

  List<String> _partnerProfile(ParticipantProfile user) {
    final energy = user.answers['personality_social_energy'] ?? 3;
    final structure = user.answers['personality_structure'] ?? 3;
    final emotionalAwareness = user.answers['emotion_self_awareness'] ?? 3;
    final angerPause = user.answers['anger_pause'] ?? 3;
    final angerRepair = user.answers['anger_repair'] ?? 3;
    final conflictAverage = ((angerPause + angerRepair) / 2).round();

    return [
      _energyToken(energy),
      _structureToken(structure),
      _emotionToken(emotionalAwareness),
      _conflictToken(conflictAverage),
    ];
  }

  String _partnerArchetype(ParticipantProfile user) {
    final structure = user.answers['personality_structure'] ?? 3;
    final empathy = user.answers['emotion_empathy'] ?? 3;
    final directness = user.answers['communication_direct'] ?? 3;
    final angerPause = user.answers['anger_pause'] ?? 3;

    final primary = switch (structure) {
      >= 4 => 'planner',
      <= 2 => 'flexible',
      _ => 'balanced',
    };

    final secondary = empathy >= 4 && directness >= 4
        ? 'warmCommunicator'
        : empathy >= 4
        ? 'reflectivePartner'
        : angerPause >= 4
        ? 'steadyResponder'
        : 'directProcessor';

    return '$primary+$secondary';
  }

  List<String> _relationshipDynamics(
    ParticipantProfile userA,
    ParticipantProfile userB,
  ) {
    final socialGap =
        ((userA.answers['personality_social_energy'] ?? 3) -
                (userB.answers['personality_social_energy'] ?? 3))
            .abs();
    final structureGap =
        ((userA.answers['personality_structure'] ?? 3) -
                (userB.answers['personality_structure'] ?? 3))
            .abs();
    final repairA =
        ((userA.answers['anger_pause'] ?? 3) +
            (userA.answers['anger_repair'] ?? 3)) /
        2;
    final repairB =
        ((userB.answers['anger_pause'] ?? 3) +
            (userB.answers['anger_repair'] ?? 3)) /
        2;
    final empathyA = userA.answers['emotion_empathy'] ?? 3;
    final empathyB = userB.answers['emotion_empathy'] ?? 3;

    return [
      socialGap <= 1 ? 'dynamic:energy:aligned' : 'dynamic:energy:bridge',
      structureGap <= 1
          ? 'dynamic:planning:aligned'
          : 'dynamic:planning:bridge',
      repairA >= 4 && repairB >= 4 && empathyA >= 4 && empathyB >= 4
          ? 'dynamic:repair:strong'
          : repairA <= 2.5 || repairB <= 2.5
          ? 'dynamic:repair:fragile'
          : 'dynamic:repair:developing',
    ];
  }

  String _energyToken(int value) {
    if (value >= 4) return 'profile:energy:outgoing';
    if (value <= 2) return 'profile:energy:reserved';
    return 'profile:energy:balanced';
  }

  String _structureToken(int value) {
    if (value >= 4) return 'profile:structure:structured';
    if (value <= 2) return 'profile:structure:flexible';
    return 'profile:structure:balanced';
  }

  String _emotionToken(int value) {
    if (value >= 4) return 'profile:emotion:aware';
    if (value <= 2) return 'profile:emotion:guarded';
    return 'profile:emotion:growing';
  }

  String _conflictToken(int value) {
    if (value >= 4) return 'profile:conflict:steady';
    if (value <= 2) return 'profile:conflict:reactive';
    return 'profile:conflict:developing';
  }
}
