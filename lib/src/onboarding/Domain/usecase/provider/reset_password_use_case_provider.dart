import 'dart:async';

import 'package:connect_me/app.dart';

class ResetPasswordNotifier extends StateNotifier<AuthUseCaseState> {
  ResetPasswordNotifier(this.authUseCase) : super(AuthUseCaseState());
  final AuthUseCase authUseCase;
  // final AnalyticsRepositoryImpl _analyticsImpl;

  Future sendResetPassowrd({required String email}) async {
    state = AuthUseCaseState(isLoading: true);

    await authUseCase.resetPassWord(email: email);
    state =
        AuthUseCaseState(isLoading: false, user: null, errorMessage: 'reset');
  }
}

final resetPasswordNotifierProvider =
    StateNotifierProvider<ResetPasswordNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return ResetPasswordNotifier(authUseCase);
});
