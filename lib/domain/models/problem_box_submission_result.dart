class ProblemBoxSubmissionResult {
  const ProblemBoxSubmissionResult({
    required this.submitted,
    required this.providerKey,
    this.requestId,
    this.message,
  });

  final bool submitted;
  final String providerKey;
  final String? requestId;
  final String? message;
}
