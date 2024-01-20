import 'package:connect_me/app.dart';

class SignUpCardWidget extends ConsumerStatefulWidget {
  const SignUpCardWidget({super.key});

  @override
  ConsumerState<SignUpCardWidget> createState() => _SignUpCardWidgetState();
}

class _SignUpCardWidgetState extends ConsumerState<SignUpCardWidget> {
  final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
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

    final isLoading = ref.watch(signUpNotifierProvider).isLoading;

    ref.listen(signUpNotifierProvider, (previous, next) {
      if (next.user?.uid != null) {
        controller.disposeControllers();
        pushReplacement(context, MainScreen());
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
        pushReplacement(context, MainScreen());
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
          bool isFormValidated() {
            if (controller.emailController.text.isNotEmpty &&
                controller.usernameController.text.isNotEmpty &&
                controller.passWordController.text.isNotEmpty) {
              return true;
            } else {
              return false;
            }
          }

          bool fieldIsEmpty(TextEditingControllerClass controller) {
            var passwordFocus = controller.passwordFocusMode.hasFocus;
            var emailFocus = controller.emailFocusMode.hasFocus;
            var usernameFocus = controller.userNameFocusMode.hasFocus;
            if (passwordFocus == true || emailFocus == true || usernameFocus == true) {
              if (emailNotifier.value.isNotEmpty &&
                  userNameNotifier.value.isNotEmpty &&
                  passwordNotifier.value.isNotEmpty) {
                return false;
              } else {
                return true;
              }
            } else {
              return false;
            }
          }

          return FullScreenLoader(
            isLoading: isLoading,
            child: Form(
              key: signUpformKey,
              child: GestureDetector(
                onTap: () {
                  controller.emailFocusMode.unfocus();
                  controller.passwordFocusMode.unfocus();
                  controller.userNameFocusMode.unfocus();
                },
                child: Card(
                    elevation: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //logo
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Ink(
                              decoration: BoxDecoration(
                                borderRadius: AppBorderRadius.c12,
                                color: context.colorScheme.onSurface,
                              ),
                              child: Image.asset(
                                ImagesConstant.appLogoBrown,
                                height: context.sizeWidth(0.22),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: AppBorderRadius.c12,
                                border: Border.all(
                                  width: 0.4,
                                  color: fieldIsEmpty(controller)
                                      ? AppThemeColorDark.textError
                                      : context.colorScheme.onBackground,
                                ),
                              ),
                              child: Column(
                                children: [
                                  // username textfield
                                  AuthTextFieldWidget(
                                    focusNode: controller.userNameFocusMode,
                                    hintText: TextConstant.username,
                                    fillColor: Colors.transparent,
                                    controller: controller.usernameController,
                                    noBorders: true,
                                    onChanged: (value) {
                                      userNameNotifier.value = value;
                                    },
                                  ).padSymmetric(horizontal: 8, vertical: 2),
                                  Divider(
                                    thickness: 0.5,
                                    color: fieldIsEmpty(controller)
                                        ? AppThemeColorDark.textError
                                        : context.colorScheme.onBackground,
                                  ),

                                  //email textfields
                                  AuthTextFieldWidget(
                                    focusNode: controller.emailFocusMode,
                                    hintText: TextConstant.emailAddress,
                                    fillColor: Colors.transparent,
                                    controller: controller.emailController,
                                    noBorders: true,
                                    onChanged: (value) {
                                      emailNotifier.value = value;
                                    },
                                  ).padSymmetric(horizontal: 8, vertical: 2),
                                  Divider(
                                    thickness: 0.5,
                                    color: fieldIsEmpty(controller)
                                        ? AppThemeColorDark.textError
                                        : context.colorScheme.onBackground,
                                  ),

                                  //password textfields
                                  AuthTextFieldWidget(
                                    hintText: TextConstant.password,
                                    focusNode: controller.passwordFocusMode,
                                    fillColor: Colors.transparent,
                                    controller: controller.passWordController,
                                    noBorders: true,
                                    onChanged: (value) {
                                      passwordNotifier.value = value;
                                    },
                                  ).padSymmetric(horizontal: 8, vertical: 2),
                                ],
                              ),
                            ),
                            //validator text in red
                            Visibility(
                              visible: fieldIsEmpty(controller),
                              child: Text(
                                AuthErrors.allFieldsAreRequired.errorMessage,
                                textAlign: TextAlign.start,
                                style: AppTextStyle.errorTextstyle
                                    .copyWith(color: AppThemeColorDark.textError),
                              ).padAll(5),
                            ),
                          ],
                        ),

                        //sign up accts
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (isFormValidated() == true) {
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
                        Text(TextConstant.or.toTitleCase()),
                        //sign in with google btn
                        SocialButtons(
                          iconData: googleIcon,
                          text: TextConstant.signUpWithGoogle,
                          onTap: () {
                            // if (Platform.isAndroid) {
                            ref.read(signInGoogleNotifierProvider.notifier).signinWithGoogle();
                            // } else {}
                          },
                        ),
                      ],
                    ).padAll(15)),
              ),
            ),
          );
        });
  }
}
