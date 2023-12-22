import 'package:connect_me/app.dart';

class SignUpNotifier extends StateNotifier<AuthUseCaseState> {
  SignUpNotifier(this.authUseCase) : super(AuthUseCaseState());
  final AuthUseCase authUseCase;
// CREATE ACCOUNT
  Future createAccount(
      {required String email,
      required String password,
      required String username}) async {
    state = AuthUseCaseState(isLoading: true);

    var user = await authUseCase.createAccount(
      email: email,
      password: password,
      username: username,
    );
   
    state = user.fold((failure) {
      return AuthUseCaseState(errorMessage: failure.message, isLoading: false);
    }, (userDetails) => AuthUseCaseState(user: userDetails, isLoading: false));
  }
}

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return SignUpNotifier(authUseCase);
});
