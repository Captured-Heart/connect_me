import 'dart:async';

import '../../../../../app.dart';

class ResetPasswordNotifier extends StateNotifier<AuthUseCaseState> {
  ResetPasswordNotifier(this.authUseCase) : super(const AuthUseCaseState());
  final AuthUseCase authUseCase;

  Future sendResetPassowrd({required String email}) async {
    state = const AuthUseCaseState(isLoading: true);

    await authUseCase.resetPassWord(email: email);
    state = const AuthUseCaseState(isLoading: false, user: null, errorMessage: 'reset');
  }
}

final resetPasswordNotifierProvider =
    StateNotifierProvider<ResetPasswordNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return ResetPasswordNotifier(authUseCase);
});
