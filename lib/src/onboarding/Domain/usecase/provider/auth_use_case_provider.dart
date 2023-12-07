import 'package:connect_me/app.dart';

class AuthUseCaseNotifier extends StateNotifier<AuthUseCaseState> {
  AuthUseCaseNotifier(this.authUseCase) : super(AuthUseCaseState());

  final AuthUseCase authUseCase;

  Future createAccount({required String email, required String password}) async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.createAccount(email: email, password: password);
    state = user.fold(
        (failure) => AuthUseCaseState(errorMessage: failure.message, isLoading: false),
        (userDetails) => AuthUseCaseState(user: userDetails, isLoading: false));
  }
}

final authNotifierProvider = StateNotifierProvider<AuthUseCaseNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return AuthUseCaseNotifier(authUseCase);
});
