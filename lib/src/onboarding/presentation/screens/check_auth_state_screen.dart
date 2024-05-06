import '../../../../app.dart';

class CheckAuthStateScreen extends ConsumerWidget {
  const CheckAuthStateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider);

    return user.value == null
        ? const LoginScreen()
        : user.when(
            data: (data) {
              // ref.invalidate(fetchProfileProvider);
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
        child: Text('Error'.hardCodedString),
      ),
    );
  }
}
