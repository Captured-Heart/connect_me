import '../../../../app.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isFrontOfCard = true;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = _flipController;
    final isLoading = ref.watch(loginWithEmailNotifierProvider).isLoading;
    final isLoadingGoogle = ref.watch(signInGoogleNotifierProvider).isLoading;
    final isSignUpLoading = ref.watch(signUpNotifierProvider).isLoading;

    return FullScreenLoader(
      isLoading: (isLoading || isLoadingGoogle || isSignUpLoading),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.black,
        body: SafeArea(
          child: PageView.custom(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              childrenDelegate: SliverChildListDelegate.fixed(
                [
                  //sign in card
                  Center(
                    child: SingleChildScrollView(
                      child: SignInCardWidget(
                        key: const Key('sign-in-key'),
                        pageController: pageController,
                      ).padAll(15),
                    ),
                  ),

                  //sign up card
                  Center(
                    child: SingleChildScrollView(
                      child: SignUpCardWidget(
                        key: const Key('sign-up-key'),
                        controller: pageController,
                      ).padAll(15),
                    ),
                  ),

                  //forgot password card
                  Column(
                    key: Key('return-login-column'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ForgotPasswordCard(
                        pageController: pageController,
                      ),
                      GestureDetector(
                        key: const Key('return-to-login'),
                        onTap: () {
                          pageController.jumpToPage(0);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Flash(
                                duration: const Duration(seconds: 3),
                                animate: true,
                                infinite: true,
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 23,
                                ),
                              ),
                            ),
                            Flexible(
                              child: AutoSizeText(
                                TextConstant.returnToLogin,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                maxLines: 1,
                              ),
                            )
                          ].rowInPadding(10),
                        ),
                      ),
                    ].columnInPadding(10),
                  ).padSymmetric(horizontal: 10),
                ],
              )),
          //     ),
          //   ),
        ),
      ),
      //   ),
      // ),
    );
  }
}
