import 'dart:io';

import '../../../../app.dart';

class SignUpCardWidget extends ConsumerStatefulWidget {
  const SignUpCardWidget({super.key, required this.controller});
  final PageController controller;

  @override
  ConsumerState<SignUpCardWidget> createState() => _SignUpCardWidgetState();
}

class _SignUpCardWidgetState extends ConsumerState<SignUpCardWidget> {
  final GlobalKey<FormState> _signUpformKey = GlobalKey<FormState>();
  final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> userNameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');
  @override
  void dispose() {
    emailNotifier.dispose();
    userNameNotifier.dispose();
    passwordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(textEditingControllerProvider);
    final obscureText = ref.watch(obscureTextProvider);

    ref.listen(signUpNotifierProvider, (previous, next) {
      if (next.user?.uid != null) {
        controller.disposeControllers();
        pushReplacement(
          context,
          const SignUpMainScreen(),
          ref: ref,
          routeName: ScreenName.signUpMainScreen,
        );
      }

      if (next.errorMessage != null) {
        showScaffoldSnackBarMessageNoColor(
          next.errorMessage ?? '',
          context: context,
          isError: true,
        );
      }
    });
    ref.listen(signInGoogleNotifierProvider, (previous, next) {
      if (next.user?.uid != null) {
        pushReplacement(
          context,
          const SignUpMainScreen(),
          ref: ref,
          routeName: ScreenName.signUpMainScreen,
        );
      }
      if (next.errorMessage != null) {
        showScaffoldSnackBarMessageNoColor(
          next.errorMessage ?? '',
          context: context,
          isError: true,
        );
      }
    });

    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            emailNotifier,
            passwordNotifier,
            userNameNotifier,
            controller.emailFocusMode,
            controller.passwordFocusMode,
            controller.userNameFocusMode,
          ],
        ),
        builder: (context, child) {
          return Form(
            key: _signUpformKey,
            child: GestureDetector(
              onTap: () {
                controller.emailFocusMode.unfocus();
                controller.passwordFocusMode.unfocus();
                controller.userNameFocusMode.unfocus();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //logo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Ink(
                            //   decoration: BoxDecoration(
                            //     borderRadius: AppBorderRadius.c12,
                            //     color: context.colorScheme.onSurface,
                            //   ),
                            //   child: Image.asset(
                            //     ImagesConstant.appLogoBrown,
                            //     height: context.sizeWidth(0.13),
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            AutoSizeText(
                              TextConstant.createYourAcct,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: AppFontWeight.w700,
                              ),
                              maxLines: 1,
                              textScaleFactor: 1.3,
                            ),
                          ].columnInPadding(10),
                        ),

                        //sign in text

                        // textfield in a container
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                children: [
                              // username textfield
                              AuthTextFieldWidget(
                                focusNode: controller.userNameFocusMode,
                                hintText: TextConstant.username,
                                fillColor: Colors.transparent,
                                controller: controller.usernameController,
                                noBorders: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TextConstant.required;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  userNameNotifier.value = value;
                                },
                              ).padSymmetric(horizontal: 8, vertical: 2),

                              //email textfields
                              AuthTextFieldWidget(
                                focusNode: controller.emailFocusMode,
                                hintText: TextConstant.emailAddress,
                                fillColor: Colors.transparent,
                                controller: controller.emailController,
                                noBorders: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TextConstant.required;
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  emailNotifier.value = value;
                                },
                              ).padSymmetric(horizontal: 8, vertical: 2),

                              //password textfields
                              AuthTextFieldWidget(
                                hintText: TextConstant.password,
                                focusNode: controller.passwordFocusMode,
                                fillColor: Colors.transparent,
                                obscureText: obscureText,
                                maxLines: 1,
                                controller: controller.passWordController,
                                noBorders: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TextConstant.required;
                                  } else {
                                    return null;
                                  }
                                },
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ref
                                        .read(obscureTextProvider.notifier)
                                        .update((state) => !state);
                                  },
                                  icon: obscureText == true
                                      ? const Icon(showPasswordIcon)
                                      : const Icon(hidePasswordIcon),
                                ),
                                onChanged: (value) {
                                  passwordNotifier.value = value;
                                },
                              ).padSymmetric(horizontal: 8, vertical: 2),
                            ].columnInPadding(15)),
                            //validator text in red
                          ],
                        ),

                        //sign up accts
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_signUpformKey.currentState!.validate()) {
                                  log('is validated');
                                  ref.read(signUpNotifierProvider.notifier).createAccount(
                                        email: controller.emailController.text.trim(),
                                        password: controller.passWordController.text.trim(),
                                        username: controller.usernameController.text.trim(),
                                      );
                                } else {
                                  log('is not validated');

                                  controller.userNameFocusMode.requestFocus();
                                }
                              },
                              child: Text(
                                TextConstant.signUp.toTitleCase(),
                              ),
                            ),
                          ],
                        ),

                        Platform.isIOS
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  Text(TextConstant.or.toTitleCase()).padOnly(bottom: 5),
                                  //sign in with google btn
                                  SocialButtons(
                                    iconData: googleIcon,
                                    text: TextConstant.signUpWithGoogle,
                                    onTap: () {
                                      // if (Platform.isAndroid) {
                                      ref
                                          .read(signInGoogleNotifierProvider.notifier)
                                          .signinWithGoogle(isSignUp: true);
                                      // } else {}
                                    },
                                  ),
                                ],
                              ),
                      ],
                    ).padAll(15),
                  ),
                  AlreadyHaveAnAcctWidget(
                    onTap: () {
                      widget.controller.jumpToPage(0);
                    },
                    isLoginScreen: true,
                  ).padOnly(top: 10),
                ],
              ),
            ),
          );
        });
  }
}
