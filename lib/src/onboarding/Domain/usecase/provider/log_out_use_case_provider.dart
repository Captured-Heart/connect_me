import '../../../../../app.dart';

class LogOutNotifier extends StateNotifier<AuthUseCaseState> {
  LogOutNotifier(this.authUseCase) : super(const AuthUseCaseState());
  final AuthUseCase authUseCase; // LOGOUT OF THE APP
  Future signOutUsers() async {
    state = const AuthUseCaseState(isLoading: true);

    await authUseCase.logOutOfApp();
    state = const AuthUseCaseState(isLoading: false, user: null);
  }
}

final logOutNotifierProvider = StateNotifierProvider<LogOutNotifier, AuthUseCaseState>((ref) {
  final authUseCase = ref.read(createUserProvider);
  return LogOutNotifier(authUseCase);
});
