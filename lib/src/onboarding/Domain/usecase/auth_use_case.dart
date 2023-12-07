import 'package:connect_me/app.dart';

abstract class AuthUseCase {
  Future<Either<AppException, User?>> loginWithEmail({required String email, required String password});
  Future<Either<AppException, User?>> createAccount({required String email, required String password});
  Future<void> logOutOfApp();
  Future resetPassWord({required String email});
}
