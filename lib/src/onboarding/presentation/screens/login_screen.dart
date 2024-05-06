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
                  Center(
                    child: SingleChildScrollView(
                      child: SignInCardWidget(
                        key: const Key('sign-in_key'),
                        pageController: pageController,
                      ).padAll(15),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: SignUpCardWidget(
                        key: const Key('sign-up_key'),
                        controller: pageController,
                      ).padAll(15),
                    ),
                  ),
                  Column(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ForgotPasswordCard(
                        pageController: pageController,
                      ),
                      GestureDetector(
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
