class ExpertSupportSubmissionResult {
  const ExpertSupportSubmissionResult({
    required this.submitted,
    required this.channel,
    this.requestId,
    this.message,
  });

  final bool submitted;
  final String channel;
  final String? requestId;
  final String? message;
}
