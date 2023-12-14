import 'package:connect_me/app.dart';

class AuthUseCaseState {
  final bool isLoading;
  final String? errorMessage;
  final User? user;
  // final VoidCallback? onNavigate;

  AuthUseCaseState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
    // this.onNavigate,
  });
}
