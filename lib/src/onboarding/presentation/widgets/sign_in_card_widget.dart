import 'dart:io';

import '../../../../app.dart';

final obscureTextProvider = StateProvider<bool>((ref) {
  return true;
});

class SignInCardWidget extends ConsumerWidget {
  SignInCardWidget({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');

  final GlobalKey<FormState> _signInformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(textEditingControllerProvider);

    final obscureText = ref.watch(obscureTextProvider);
    ref.listen(loginWithEmailNotifierProvider, (previous, next) {
      log('${next.user}');
      if (next.errorMessage != null) {
        showScaffoldSnackBarMessageNoColor(
          next.errorMessage ?? '',
          context: context,
          isError: true,
        );
      }
    });
// SIGN IN GOOGLE
    ref.listen(signInGoogleNotifierProvider, (previous, next) {
      if (next.errorMessage != null) {
        showScaffoldSnackBarMessageNoColor(
          next.errorMessage ?? '',
          context: context,
          isError: true,
        );
      }
    });
    ref.listen(authStateChangesProvider, (previous, next) {
      if (next.valueOrNull != null) {
        // controller.disposeControllers();
        pushReplacement(
          context,
          const CheckAuthStateScreen(),
          ref: ref,
          routeName: ScreenName.checkAuthStateScreen,
        );
      }
    });
    // bool fieldIsEmpty(TextEditingControllerClass controller) {
    //   var passwordFocus = controller.passwordFocusMode.hasFocus;
    //   var emailFocus = controller.emailFocusMode.hasFocus;
    //   if (passwordFocus == true || emailFocus == true) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }

    return ListenableBuilder(
        listenable: Listenable.merge([
          emailNotifier,
          passwordNotifier,
          controller.emailFocusMode,
          controller.passwordFocusMode,
        ]),
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              controller.passwordFocusMode.unfocus();
              controller.emailFocusMode.unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //logo
                      Column(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.c12,
                              color: context.colorScheme.onSurface,
                            ),
                            child: Image(
                              height: context.sizeWidth(0.13),
                              image: const ResizeImage(
                                AssetImage(
                                  ImagesConstant.appLogoBrown,
                                ),
                                height: 150,
                                width: 150,
                              ),
                            ),

                            //  Image.asset(
                            //   ImagesConstant.appLogoBrown,
                            //   height: context.sizeWidth(0.13),
                            //   fit: BoxFit.cover,
                            // ),
                          ),

                          //
                          //sign in text
                          AutoSizeText(
                            TextConstant.signintoYourAcct,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: AppFontWeight.w700,
                            ),
                            maxLines: 1,
                            textScaleFactor: 1.3,
                          ),
                        ].columnInPadding(5),
                      ),

                      //sign in with google btn
                      Platform.isIOS
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                SocialButtons(
                                  iconData: googleIcon,
                                  text: TextConstant.signInWithGoogle,
                                  onTap: () {
                                    // if (Platform.isAndroid) {

                                    ref
                                        .read(signInGoogleNotifierProvider.notifier)
                                        .signinWithGoogle(isSignUp: false);
                                    // } else {}
                                  },
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                // divider with text
                                Row(
                                  children: [
                                    const Expanded(child: Divider()),
                                    const Text(TextConstant.orContinueWith)
                                        .padSymmetric(horizontal: 20),
                                    const Expanded(child: Divider()),
                                  ],
                                ),
                              ],
                            ),

                      // textfield in a container
                      // EmailAndPasswordWidget(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _signInformKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              children: [
                                //
                                //  EMAIL textfields
                                AuthTextFieldWidget(
                                  key: const Key('sign-in-email-field'),
                                  hintText: TextConstant.emailAddress,
                                  fillColor: Colors.transparent,
                                  controller: controller.emailController,
                                  focusNode: controller.emailFocusMode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return TextConstant.required;
                                    } else {
                                      return null;
                                    }
                                  },
                                  // validator: RequiredValidator(errorText: AuthErrors.requiredValue.errorMessage),
                                  onChanged: (value) {
                                    emailNotifier.value = value;
                                  },
                                  noBorders: false,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                ).padSymmetric(horizontal: 8, vertical: 2),
                                const SizedBox(
                                  height: 10,
                                ),
                                //PASSWORD textfields
                                AuthTextFieldWidget(
                                  key: const Key('sign-in-password-field'),
                                  hintText: TextConstant.password,
                                  fillColor: Colors.transparent,
                                  focusNode: controller.passwordFocusMode,
                                  controller: controller.passWordController,
                                  obscureText: obscureText,
                                  maxLines: 1,
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
                                  noBorders: false,
                                ).padSymmetric(horizontal: 8, vertical: 2),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //text btn[forgotten password] and continue btn
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              pageController.jumpToPage(2);
                            },
                            child: const Text(TextConstant.forgottenPassword),
                          ),
                          SizedBox(
                            width: context.sizeWidth(1),
                            child: ElevatedButton(
                              key: const Key('login-btn'),
                              onPressed: () {
                                if (_signInformKey.currentState!.validate()) {
                                  ref.read(loginWithEmailNotifierProvider.notifier).loggingUser(
                                        email: controller.emailController.text.trim(),
                                        password: controller.passWordController.text.trim(),
                                      );
                                } else {
                                  controller.passwordFocusMode.requestFocus();
                                }
                              },
                              child: Text(
                                TextConstant.continuebtn.toTitleCase(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ].columnInPadding(20),
                  ).padAll(15),
                ),
                AlreadyHaveAnAcctWidget(
                  onTap: () {
                    pageController.jumpToPage(1);
                  },
                  isLoginScreen: false,
                ).padOnly(top: 10)
              ],
            ),
          );
        });
  }
}
