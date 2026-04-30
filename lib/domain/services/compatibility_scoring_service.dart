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

    for (final category in QuestionCategory.values) {
      final questions = activeQuestions
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
      categoryScores[_categoryKey(category)] = _average(scores);
    }

    final compatibility = _average(categoryScores.values);
    final readiness = _readinessScore(categoryScores);

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
    return (total / weightTotal).round().clamp(0, 100);
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

  List<String> _risks(Map<String, int> scores) {
    final entries = scores.entries.where((entry) => entry.value < 60).toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    if (entries.isEmpty) {
      return const ['risk:none'];
    }
    return entries.map((entry) => 'risk:${entry.key}').toList();
  }

  List<String> _notes(
    Map<String, int> scores,
    int compatibility,
    int readiness,
  ) {
    final notes = <String>[];
    if (compatibility >= 80) {
      notes.add('note:strongAlignment');
    } else if (compatibility >= 65) {
      notes.add('note:workableCompatibility');
    } else {
      notes.add('note:fragileCompatibility');
    }

    if ((scores['angerManagement'] ?? 100) < 60) {
      notes.add('note:angerManagement');
    }
    if ((scores['familyBoundaries'] ?? 100) < 60) {
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
  ) {
    final sessions = <String>[];
    if ((scores['communication'] ?? 100) < 70) {
      sessions.add('session:communication');
    }
    if ((scores['familyBoundaries'] ?? 100) < 70) {
      sessions.add('session:familyBoundaries');
    }
    if ((scores['financialMindset'] ?? 100) < 70 ||
        (scores['futureGoals'] ?? 100) < 70) {
      sessions.add('session:futurePlanning');
    }
    if (compatibility < 65 || readiness < 65) {
      sessions.add('session:individualReadiness');
    }
    return sessions.isEmpty
        ? const ['session:alignment']
        : sessions;
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
        ((userA.answers['anger_pause'] ?? 3) + (userA.answers['anger_repair'] ?? 3)) / 2;
    final repairB =
        ((userB.answers['anger_pause'] ?? 3) + (userB.answers['anger_repair'] ?? 3)) / 2;
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
