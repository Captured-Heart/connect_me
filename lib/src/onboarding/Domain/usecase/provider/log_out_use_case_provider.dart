import 'package:connect_me/app.dart';

class LogOutNotifier extends StateNotifier<AuthUseCaseState> {
  LogOutNotifier(this.authUseCase) : super(AuthUseCaseState());
  final AuthUseCase authUseCase; // LOGOUT OF THE APP
  Future signOutUsers() async {
    state = AuthUseCaseState(isLoading: true);

    await authUseCase.logOutOfApp();
    state = AuthUseCaseState(isLoading: false, user: null);
  }
}

final logOutNotifierProvider =
    StateNotifierProvider<LogOutNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return LogOutNotifier(authUseCase);
});
