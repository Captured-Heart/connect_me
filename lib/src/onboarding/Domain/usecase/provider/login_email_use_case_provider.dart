import 'package:connect_me/app.dart';

// ignore: invalid_use_of_visible_for_testing_member
class LoginWithEmailNotifier extends StateNotifier<AuthUseCaseState> {
  LoginWithEmailNotifier(this.authUseCase, this.analyticsRepositoryImpl)
      : super(AuthUseCaseState());

  final AuthUseCase authUseCase;
  final AnalyticsRepositoryImpl analyticsRepositoryImpl;
// LOGGING USER WITH EMAIL
  Future loggingUser({
    required String email,
    required String password,
  }) async {
    state = AuthUseCaseState(isLoading: true);

    var user =
        await authUseCase.loginWithEmail(email: email, password: password);

    state = user.fold((failure) {
      return AuthUseCaseState(errorMessage: failure.message, isLoading: false);
    }, (userDetails) {
      analyticsRepositoryImpl.login(
          email: email,
          uid: userDetails?.uid ?? 'uid',
          loginMethod: 'login_with_email');
      return AuthUseCaseState(user: userDetails, isLoading: false);
    });
  }
}

final loginWithEmailNotifierProvider =
    StateNotifierProvider<LoginWithEmailNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  final analytics = ref.read(analyticsImplProvider);

  return LoginWithEmailNotifier(authUseCase, analytics);
});
