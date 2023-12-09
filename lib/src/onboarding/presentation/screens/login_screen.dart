import 'package:connect_me/app.dart';
import 'package:flutter/gestures.dart';

final flipCardControllerProvider = Provider.autoDispose<FlipCardController>((ref) {
  return FlipCardController();
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isFrontOfCard = false;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(flipCardControllerProvider);
    final isLoading = ref.watch(authNotifierProvider).isLoading;
    return FullScreenLoader(
      isLoading: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: PageView.custom(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              childrenDelegate: SliverChildListDelegate.fixed(
                [
                  Center(
                    child: ListView(
                      shrinkWrap: true,
                      dragStartBehavior: DragStartBehavior.start,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlipCard(
                          controller: controller,
                          flipOnTouch: false,
                          direction: FlipDirection.HORIZONTAL,
                          onFlipDone: (isFront) {
                            setState(() {
                              isFrontOfCard = isFront;
                            });
                          },
                          fill: Fill.fillBack,
                          back: SignUpCardWidget(
                            key: const Key('sign-up_key'),
                          ).padAll(15),
                          front: SignInCardWidget(
                            key: const Key('sign-in_key'),
                            pageController: pageController,
                          ).padAll(15),
                        ),
                        AlreadyHaveAnAcctWidget(
                          controller: controller,
                          isFrontOfCard: isFrontOfCard,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    key: UniqueKey(),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ForgotPasswordCard(
                        pageController: pageController,
                      ),
                      Row(
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
                            child: GestureDetector(
                              onTap: () {
                                pageController.jumpToPage(0);
                              },
                              child: AutoSizeText(
                                TextConstant.returnToLogin,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          )
                        ].rowInPadding(10),
                      ),
                    ].columnInPadding(10),
                  ).padSymmetric(horizontal: 10),
                ],
              )),
        ),
      ),
    );
  }
}
