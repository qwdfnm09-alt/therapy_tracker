class ExpertSupportRequest {
  const ExpertSupportRequest({
    required this.sessionType,
    required this.sessionTypeLabel,
    required this.clientPhone,
    required this.preferredDate,
    required this.message,
    required this.recommendedReason,
    required this.resultVerdict,
    required this.createdAtIso,
  });

  final String sessionType;
  final String sessionTypeLabel;
  final String clientPhone;
  final String preferredDate;
  final String message;
  final String recommendedReason;
  final String resultVerdict;
  final String createdAtIso;

  Map<String, dynamic> toJson() {
    return {
      'sessionType': sessionType,
      'sessionTypeLabel': sessionTypeLabel,
      'clientPhone': clientPhone,
      'preferredDate': preferredDate,
      'message': message,
      'recommendedReason': recommendedReason,
      'resultVerdict': resultVerdict,
      'createdAt': createdAtIso,
    };
  }
}
