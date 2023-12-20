import 'package:connect_me/app.dart';

class UsersProfileState {
  final bool isLoading;
  final String? errorMessage;
  final User? user;
  // final VoidCallback? onNavigate;

  UsersProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.user,

    // this.onNavigate,
  });
}
