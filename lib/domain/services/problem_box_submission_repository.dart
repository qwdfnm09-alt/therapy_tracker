import '../models/problem_box_submission.dart';
import '../models/problem_box_submission_result.dart';

abstract class ProblemBoxSubmissionRepository {
  Future<ProblemBoxSubmissionResult> submit(ProblemBoxSubmission submission);
}