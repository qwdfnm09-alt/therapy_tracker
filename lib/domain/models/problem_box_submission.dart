class ProblemBoxSubmission {
  const ProblemBoxSubmission({
    required this.topic,
    required this.details,
    required this.createdAtIso,
  });

  final String topic;
  final String details;
  final String createdAtIso;

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'details': details,
      'createdAt': createdAtIso,
      'status': 'pending_review',
    };
  }
}
