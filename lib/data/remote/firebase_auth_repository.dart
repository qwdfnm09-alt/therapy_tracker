import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/auth_action_result.dart';
import '../../domain/models/auth_user.dart';
import '../../domain/services/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<AuthUser?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null || user.email == null) return null;
    return AuthUser(id: user.uid, email: user.email!);
  }

  @override
  Future<AuthActionResult> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthActionResult(
        success: credential.user != null,
        providerKey: 'firebase_auth',
        message: credential.user != null
            ? 'accountCreated'
            : 'accountCreateFailed',
      );
    } on FirebaseAuthException catch (error) {
      return AuthActionResult(
        success: false,
        providerKey: 'firebase_auth',
        message: _mapErrorCode(error.code),
      );
    } catch (_) {
      return const AuthActionResult(
        success: false,
        providerKey: 'firebase_auth',
        message: 'accountCreateFailed',
      );
    }
  }

  @override
  Future<AuthActionResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthActionResult(
        success: credential.user != null,
        providerKey: 'firebase_auth',
        message: credential.user != null ? 'signedIn' : 'signInFailed',
      );
    } on FirebaseAuthException catch (error) {
      return AuthActionResult(
        success: false,
        providerKey: 'firebase_auth',
        message: _mapErrorCode(error.code),
      );
    } catch (_) {
      return const AuthActionResult(
        success: false,
        providerKey: 'firebase_auth',
        message: 'signInFailed',
      );
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  String _mapErrorCode(String code) {
    return switch (code) {
      'email-already-in-use' => 'accountEmailInUse',
      'invalid-email' => 'invalidEmail',
      'weak-password' => 'accountPasswordTooShort',
      'user-not-found' => 'accountUserNotFound',
      'wrong-password' => 'accountWrongPassword',
      'invalid-credential' => 'accountInvalidCredential',
      'too-many-requests' => 'accountTooManyRequests',
      _ => 'signInFailed',
    };
  }
}
