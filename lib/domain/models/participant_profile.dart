import 'question.dart';

class ParticipantProfile {
  const ParticipantProfile({
    required this.name,
    required this.age,
    required this.job,
    required this.education,
    required this.answers,
  });

  final String name;
  final int age;
  final String job;
  final String education;
  final Map<String, int> answers;

  bool get hasRequiredInfo =>
      name.trim().isNotEmpty &&
      age >= 18 &&
      job.trim().isNotEmpty &&
      education.trim().isNotEmpty;

  bool get hasCompleteAssessment =>
      compatibilityQuestions.every((q) => answers.containsKey(q.id));

  ParticipantProfile copyWith({
    String? name,
    int? age,
    String? job,
    String? education,
    Map<String, int>? answers,
  }) {
    return ParticipantProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      job: job ?? this.job,
      education: education ?? this.education,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'job': job,
      'education': education,
      'answers': answers,
    };
  }

  factory ParticipantProfile.fromJson(Map<String, dynamic> json) {
    final rawAnswers = json['answers'] as Map<String, dynamic>? ?? {};
    return ParticipantProfile(
      name: json['name'] as String? ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
      job: json['job'] as String? ?? '',
      education: json['education'] as String? ?? '',
      answers: rawAnswers.map(
        (key, value) => MapEntry(key, (value as num).toInt()),
      ),
    );
  }

  factory ParticipantProfile.empty() {
    return const ParticipantProfile(
      name: '',
      age: 0,
      job: '',
      education: '',
      answers: {},
    );
  }
}
