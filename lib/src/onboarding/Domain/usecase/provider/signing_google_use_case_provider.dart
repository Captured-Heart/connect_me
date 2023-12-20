import 'package:connect_me/app.dart';

class SignInGoogleNotifier extends StateNotifier<AuthUseCaseState> {
  SignInGoogleNotifier(this.authUseCase) : super(AuthUseCaseState());
  final AuthUseCase authUseCase;
  // LOGIN IN USER WITH GOOGLE
  Future signinWithGoogle() async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.loginWithGoogle();
    state = AuthUseCaseState(isLoading: false);

    state = user.fold(
      (failure) =>
          AuthUseCaseState(errorMessage: failure.message, isLoading: false),
      (userDetails) => AuthUseCaseState(user: userDetails, isLoading: false),
    );
  }
}

final signInGoogleNotifierProvider =
    StateNotifierProvider<SignInGoogleNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return SignInGoogleNotifier(authUseCase);
});
