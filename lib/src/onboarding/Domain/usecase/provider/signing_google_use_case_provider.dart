import 'dart:async';

import 'package:connect_me/app.dart';

class SignInGoogleNotifier extends StateNotifier<AuthUseCaseState> {
  SignInGoogleNotifier(this.authUseCase, this._analyticsImpl) : super(AuthUseCaseState());
  final AuthUseCase authUseCase;
  final AnalyticsRepositoryImpl _analyticsImpl;
  // LOGIN IN USER WITH GOOGLE
  Future signinWithGoogle() async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.loginWithGoogle();
    state = AuthUseCaseState(isLoading: false);

    state = user.fold(
      (failure) => AuthUseCaseState(errorMessage: failure.message, isLoading: false),
      (userDetails) {
        unawaited(
          _analyticsImpl.signUp(
              email: userDetails?.email ?? 'users_email_undefined',
              uid: userDetails?.uid ?? 'uid',
              signUpMethod: 'sign_up_email'),
        );
        return AuthUseCaseState(user: userDetails, isLoading: false);
      },
    );
  }
}

final signInGoogleNotifierProvider =
    StateNotifierProvider<SignInGoogleNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  final analytics = ref.read(analyticsImplProvider);

  return SignInGoogleNotifier(authUseCase, analytics);
});
