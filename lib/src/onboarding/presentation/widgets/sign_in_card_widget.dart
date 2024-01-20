import 'package:connect_me/app.dart';

final obscureTextProvider = StateProvider<bool>((ref) {
  return true;
});

class SignInCardWidget extends ConsumerWidget {
  SignInCardWidget({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  bool fieldIsEmpty(TextEditingControllerClass controller) {
    var passwordFocus = controller.passwordFocusMode.hasFocus;
    var emailFocus = controller.emailFocusMode.hasFocus;
    if (passwordFocus == true || emailFocus == true) {
      return true;
    } else {
      return false;
    }
  }

  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(textEditingControllerProvider);
    final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');
    final obscureText = ref.watch(obscureTextProvider);
    ref.listen(loginWithEmailNotifierProvider, (previous, next) {
      if (next.user?.uid != null) {
        controller.disposeControllers();
        pushReplacement(context,  MainScreen());
      }
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
      if (next.user?.uid != null) {
        pushReplacement(context,  MainScreen());
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
        listenable: Listenable.merge([
          emailNotifier,
          passwordNotifier,
          controller.emailFocusMode,
          controller.passwordFocusMode,
        ]),
        builder: (context, child) {
          bool isFormValidated() {
            if (controller.emailController.text.isNotEmpty &&
                controller.passWordController.text.isNotEmpty) {
              return true;
            } else {
              return false;
            }
          }

          return GestureDetector(
            onTap: () {
              controller.passwordFocusMode.unfocus();
              controller.emailFocusMode.unfocus();
            },
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //logo
                  Column(
                    children: [
                      Ink(
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.c12,
                          color: context.colorScheme.onSurface,
                        ),
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(
                            ImagesConstant.appLogoBrown,
                            height: context.sizeWidth(0.18),
                            fit: BoxFit.cover,
                          ),
                        ),
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
                  SocialButtons(
                    iconData: googleIcon,
                    text: TextConstant.signInWithGoogle,
                    onTap: () {
                      // if (Platform.isAndroid) {
                      ref
                          .read(signInGoogleNotifierProvider.notifier)
                          .signinWithGoogle();
                      // } else {}
                    },
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

                  // textfield in a container
                  // EmailAndPasswordWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: signInformKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppBorderRadius.c12,
                            border: Border.all(
                                width: 0.4,
                                color: fieldIsEmpty(controller)
                                    ? AppThemeColorDark.textError
                                    : context.colorScheme.onBackground),
                          ),
                          child: Column(
                            children: [
                              //
                              //  EMAIL textfields
                              AuthTextFieldWidget(
                                hintText: TextConstant.emailAddress,
                                fillColor: Colors.transparent,
                                controller: controller.emailController,
                                focusNode: controller.emailFocusMode,
                                // validator: RequiredValidator(errorText: AuthErrors.requiredValue.errorMessage),
                                onChanged: (value) {
                                  emailNotifier.value = value;
                                },
                                noBorders: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ).padSymmetric(horizontal: 8, vertical: 2),
                              Divider(
                                thickness: 0.5,
                                color: fieldIsEmpty(controller)
                                    ? AppThemeColorDark.textError
                                    : context.colorScheme.onBackground,
                              ),

                              //PASSWORD textfields
                              AuthTextFieldWidget(
                                hintText: TextConstant.password,
                                fillColor: Colors.transparent,
                                focusNode: controller.passwordFocusMode,
                                controller: controller.passWordController,
                                obscureText: obscureText,
                                maxLines: 1,
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
                                noBorders: true,
                              ).padSymmetric(horizontal: 8, vertical: 2),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: fieldIsEmpty(controller),
                        child: Text(
                          AuthErrors.allFieldsAreRequired.errorMessage,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.errorTextstyle
                              .copyWith(color: AppThemeColorDark.textError),
                        ).padAll(5),
                      )
                    ],
                  ),

                  //text btn[forgotten password] and continue btn
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          pageController.jumpToPage(1);
                        },
                        child: const Text(TextConstant.forgottenPassword),
                      ),
                      SizedBox(
                        width: context.sizeWidth(1),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isFormValidated() == true) {
                              ref
                                  .read(loginWithEmailNotifierProvider.notifier)
                                  .loggingUser(
                                    email:
                                        controller.emailController.text.trim(),
                                    password: controller.passWordController.text
                                        .trim(),
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
                  )
                ].columnInPadding(20),
              ).padAll(15),
            ),
          );
        });
  }
}
