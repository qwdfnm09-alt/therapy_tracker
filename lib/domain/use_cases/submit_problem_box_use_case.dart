import '../models/problem_box_submission.dart';
import '../models/problem_box_submission_result.dart';
import '../services/problem_box_submission_repository.dart';

class SubmitProblemBoxUseCase {
  const SubmitProblemBoxUseCase(this.repository);

  final ProblemBoxSubmissionRepository repository;

  Future<ProblemBoxSubmissionResult> execute(ProblemBoxSubmission submission) {
    return repository.submit(submission);
  }
}
