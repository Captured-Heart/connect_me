import 'dart:async';

import '../../../../../app.dart';

class SignUpNotifier extends StateNotifier<AuthUseCaseState> {
  SignUpNotifier(this.authUseCase, this.analyticsRepositoryImpl) : super(const AuthUseCaseState());
  final AuthUseCase authUseCase;
  final AnalyticsRepository analyticsRepositoryImpl;
// CREATE ACCOUNT
  Future createAccount(
      {required String email, required String password, required String username}) async {
    state = const AuthUseCaseState(isLoading: true);

    var user = await authUseCase.createAccount(
      email: email,
      password: password,
      username: username,
    );

    state = user.fold((failure) {
      return AuthUseCaseState(errorMessage: failure.message, isLoading: false);
    }, (userDetails) {
      // sign up in analytics
      unawaited(
        analyticsRepositoryImpl.signUp(
            email: email, uid: userDetails?.uid ?? 'uid', signUpMethod: 'sign_up_email'),
      );
      return AuthUseCaseState(user: userDetails, isLoading: false);
    });
  }
}

final signUpNotifierProvider = StateNotifierProvider<SignUpNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  final analytics = ref.read(analyticsImplProvider);

  return SignUpNotifier(authUseCase, analytics);
});
