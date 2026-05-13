import '../models/auth_action_result.dart';
import '../models/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getCurrentUser();

  Future<AuthActionResult> createAccountWithEmail({
    required String email,
    required String password,
  });

  Future<AuthActionResult> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
