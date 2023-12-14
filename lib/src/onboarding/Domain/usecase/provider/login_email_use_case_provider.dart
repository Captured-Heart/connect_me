import 'package:connect_me/app.dart';

class LoginWithEmailNotifier extends StateNotifier<AuthUseCaseState> {
  LoginWithEmailNotifier(this.authUseCase) : super(AuthUseCaseState());

  final AuthUseCase authUseCase;

// LOGGING USER WITH EMAIL
  Future loggingUser({
    required String email,
    required String password,
  }) async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.loginWithEmail(email: email, password: password);

    state = user.fold((failure) {
      return AuthUseCaseState(errorMessage: failure.message, isLoading: false);
    }, (userDetails) {
      return AuthUseCaseState(user: userDetails, isLoading: false);
    });
  }
}

final loginWithEmailNotifierProvider =
    StateNotifierProvider<LoginWithEmailNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return LoginWithEmailNotifier(authUseCase);
});
