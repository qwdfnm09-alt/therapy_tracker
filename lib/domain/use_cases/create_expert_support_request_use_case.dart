import '../models/expert_support_request.dart';
import '../models/expert_support_submission_result.dart';
import '../services/expert_support_request_repository.dart';

class CreateExpertSupportRequestUseCase {
  const CreateExpertSupportRequestUseCase(this.repository);

  final ExpertSupportRequestRepository repository;

  Future<ExpertSupportSubmissionResult> execute(ExpertSupportRequest request) {
    return repository.submitRequest(request);
  }
}
