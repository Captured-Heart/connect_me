// @visibleForTesting
import '../../../../app.dart';

class AuthUseCaseState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final User? user;

  const AuthUseCaseState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
  });

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        user,
      ];
}
