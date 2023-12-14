import 'package:connect_me/app.dart';

abstract class AuthUseCase {
  Future<Either<AppException, User?>> loginWithEmail(
      {required String email, required String password});
  Future<Either<AppException, User?>> createAccount({
    required String email,
    required String password,
    required String username,
  });
  Future<void> logOutOfApp();
  Future resetPassWord({required String email});
  Future<Either<AppException, User?>> loginWithGoogle();
}
