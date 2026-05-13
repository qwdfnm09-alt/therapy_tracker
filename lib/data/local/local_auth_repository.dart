import '../../domain/models/auth_action_result.dart';
import '../../domain/models/auth_user.dart';
import '../../domain/services/auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository();

  @override
  Future<AuthUser?> getCurrentUser() async => null;

  @override
  Future<AuthActionResult> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    return const AuthActionResult(
      success: false,
      providerKey: 'local_stub',
      message: 'connectedAuthDisabled',
    );
  }

  @override
  Future<AuthActionResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return const AuthActionResult(
      success: false,
      providerKey: 'local_stub',
      message: 'connectedAuthDisabled',
    );
  }

  @override
  Future<void> signOut() async {}
}
