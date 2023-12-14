import 'package:connect_me/app.dart';

final createUserProvider = Provider<AuthUseCaseImpl>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return AuthUseCaseImpl(authRepo);
});

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCaseImpl(this._authRepository);

  @override
  Future<Either<AppException, User?>> createAccount({
    required String email,
    required String password,
    required String username,
  }) async {
    return await _authRepository.signUpWithEmail(
      email: email,
      password: password,
      username: username,
    );
  }

  @override
  Future<void> logOutOfApp() async {
    return await _authRepository.signOut();
  }

  @override
  Future<Either<AppException, User?>> loginWithEmail(
      {required String email, required String password}) async {
    return await _authRepository.signInWithEmail(email: email, password: password);
  }

  @override
  Future resetPassWord({required String email}) async {
    return await _authRepository.resetPassWord(email: email);
  }

  @override
  Future<Either<AppException, User?>> loginWithGoogle() async {
    try {
      return await _authRepository.signInWithGoogle();
    } on AppException catch (e) {
      return Left(AppException(e.message));
      // Error.throwWithStackTrace(e, stackTrace);
    }
  }
}
