import '../models/expert_support_request.dart';
import '../models/expert_support_submission_result.dart';

abstract class ExpertSupportRequestRepository {
  Future<ExpertSupportSubmissionResult> submitRequest(
    ExpertSupportRequest request,
  );
}
