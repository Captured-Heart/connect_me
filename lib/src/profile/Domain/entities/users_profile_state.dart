import '../../../../app.dart';

class UsersProfileState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final User? user;
  // final VoidCallback? onNavigate;

  const UsersProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.user,

    // this.onNavigate,
  });

  @override
  List<Object?> get props => [isLoading, errorMessage, user];
}
