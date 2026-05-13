import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/problem_box_submission.dart';
import '../../domain/models/problem_box_submission_result.dart';
import '../../domain/services/problem_box_submission_repository.dart';

class FirebaseProblemBoxSubmissionRepository
    implements ProblemBoxSubmissionRepository {
  FirebaseProblemBoxSubmissionRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<ProblemBoxSubmissionResult> submit(
    ProblemBoxSubmission submission,
  ) async {
    try {
      final doc = await _firestore
          .collection('anonymous_problem_box_submissions')
          .add(submission.toJson());

      return ProblemBoxSubmissionResult(
        submitted: true,
        providerKey: 'firebase_firestore',
        requestId: doc.id,
        message: 'problemBoxSubmitted',
      );
    } on FirebaseException catch (error) {
      return ProblemBoxSubmissionResult(
        submitted: false,
        providerKey: 'firebase_firestore',
        message: switch (error.code) {
          'permission-denied' => 'problemBoxPermissionDenied',
          'unavailable' => 'problemBoxUnavailable',
          _ => 'problemBoxSubmitFailed',
        },
      );
    } catch (_) {
      return const ProblemBoxSubmissionResult(
        submitted: false,
        providerKey: 'firebase_firestore',
        message: 'problemBoxSubmitFailed',
      );
    }
  }
}
