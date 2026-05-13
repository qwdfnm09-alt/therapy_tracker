import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/expert_support_request.dart';
import '../../domain/models/expert_support_submission_result.dart';
import '../../domain/services/expert_support_request_repository.dart';

class FirebaseExpertSupportRequestRepository
    implements ExpertSupportRequestRepository {
  FirebaseExpertSupportRequestRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<ExpertSupportSubmissionResult> submitRequest(
    ExpertSupportRequest request,
  ) async {
    final doc = await _firestore
        .collection('expert_support_requests')
        .add(request.toJson());

    return ExpertSupportSubmissionResult(
      submitted: true,
      channel: 'remote',
      requestId: doc.id,
      message: 'saved_to_firestore',
    );
  }
}
