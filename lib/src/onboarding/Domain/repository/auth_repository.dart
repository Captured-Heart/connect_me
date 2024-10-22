import '../../../../app.dart';

abstract class AuthRepository {
  Future<Either<AppException, User?>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Either<AppException, User?>> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  });
  Future<void> signOut();
  Future resetPassWord({required String email});
  Future<Either<AppException, User?>> signInWithGoogle({required bool isSignUp});
}

typedef MapDynamicString = Map<String, dynamic>;
