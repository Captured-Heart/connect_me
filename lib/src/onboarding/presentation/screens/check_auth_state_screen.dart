import 'package:connect_me/app.dart';

class CheckAuthStateScreen extends ConsumerWidget {
  const CheckAuthStateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider);

    ref.listen(authStateChangesProvider, (previous, next) {
      if (next.value == null) {
        showScaffoldSnackBarMessage(
          AuthErrors.userIsLoggedOut.errorMessage,
          isError: true,
          duration: 5,
        );
      } else {
        showScaffoldSnackBarMessage(
          'signed in successfully as ${next.value?.email}',
          isError: false,
          duration: 4,
        );
      }
    });

    return user.value == null
        ? const LoginScreen()
        : user.when(
            data: (data) {
              final authUserData = ref.watch(fetchProfileProvider);

              if (data == null) {
                // if user is not logged in, returns to the [LOGIN SCREEN]
                return const LoginScreen();
              } else {
                if (authUserData.valueOrNull != null &&
                    authUserData.valueOrNull?.completedSignUp == false) {
                  // if user signed up and never finished the sign up process
                  return const SignUpMainScreen();
                } else {
                  // if user is logged and sign up is complete
                  return const MainScreen();
                }
              }
            },
            error: (error, _) => const ErrorScreen(),
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('THIS IS THE ERROR SCREEN'.hardCodedString),
      ),
    );
  }
}
