import 'package:connect_me/app.dart';

class AuthUseCaseState {
  final bool? isLoading;
  final String? errorMessage;
  final User? user;

  AuthUseCaseState({
    this.isLoading,
    this.errorMessage,
    this.user,
  });
}
