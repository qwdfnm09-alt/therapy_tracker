import '../models/auth_action_result.dart';
import '../models/auth_user.dart';
import '../services/auth_repository.dart';

class GetCurrentAuthUserUseCase {
  const GetCurrentAuthUserUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthUser?> execute() => repository.getCurrentUser();
}

class CreateAccountWithEmailUseCase {
  const CreateAccountWithEmailUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthActionResult> execute({
    required String email,
    required String password,
  }) {
    return repository.createAccountWithEmail(email: email, password: password);
  }
}

class SignInWithEmailUseCase {
  const SignInWithEmailUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthActionResult> execute({
    required String email,
    required String password,
  }) {
    return repository.signInWithEmail(email: email, password: password);
  }
}

class SignOutUseCase {
  const SignOutUseCase(this.repository);

  final AuthRepository repository;

  Future<void> execute() => repository.signOut();
}
