import 'dart:developer';

import 'package:connect_me/app.dart';

class AuthUseCaseNotifier extends StateNotifier<AuthUseCaseState> {
  AuthUseCaseNotifier(this.authUseCase) : super(AuthUseCaseState());

  final AuthUseCase authUseCase;

// CREATE ACCOUNT
  Future createAccount({required String email, required String password}) async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.createAccount(email: email, password: password);
    state = user.fold((failure) {
      log(''' message:  ${failure.message}
      
      ''');
      return AuthUseCaseState(errorMessage: failure.message, isLoading: false);
    }, (userDetails) => AuthUseCaseState(user: userDetails, isLoading: false));
  }

// LOGGING USER WITH EMAIL
  Future loggingUser({
    required BuildContext context,
    required String email,
    required String password,
    // required VoidCallback onNavigate,
  }) async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.loginWithEmail(email: email, password: password);

    state = user.fold((failure) {
      log(''' message:  ${failure.message}
      
      ''');

      return AuthUseCaseState(errorMessage: failure.message, isLoading: false);
    }, (userDetails) {
      return AuthUseCaseState(user: userDetails, isLoading: false);
    });
  }

// LOGIN IN USER WITH GOOGLE
  Future signinWithGoogle() async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.loginWithGoogle();
    state = AuthUseCaseState(isLoading: false);

    state = user.fold(
      (failure) => AuthUseCaseState(errorMessage: failure.message, isLoading: false),
      (userDetails) => AuthUseCaseState(user: userDetails, isLoading: false),
    );
  }

// LOGOUT OF THE APP
  Future logOutFromApp() async {
    state = AuthUseCaseState(isLoading: true);

    await authUseCase.logOutOfApp();
    state = AuthUseCaseState(isLoading: false, user: null);
  }

  Future sendResetPassowrd({required String email}) async {
    state = AuthUseCaseState(isLoading: true);

    await authUseCase.resetPassWord(email: email);
    state = AuthUseCaseState(isLoading: false, user: null, errorMessage: 'reset');
  }
}

final authNotifierProvider = StateNotifierProvider<AuthUseCaseNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return AuthUseCaseNotifier(authUseCase);
});
