import 'package:connect_me/app.dart';

class SignUpCardWidget extends ConsumerWidget {
   SignUpCardWidget({super.key});
  bool fieldIsEmpty(TextEditingControllerClass controller) {
    var passwordFocus = controller.passwordFocusMode.hasFocus;
    var emailFocus = controller.emailFocusMode.hasFocus;
    if (passwordFocus == true || emailFocus == true) {
      return true;
    } else {
      return false;
    }
  }
 final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(textEditingControllerProvider);
    final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');

    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            emailNotifier,
            passwordNotifier,
            controller.emailFocusMode,
            controller.passwordFocusMode
          ],
        ),
        builder: (context, child) {
          return Form(
            key: signUpformKey,
            child: GestureDetector(
              onTap: () {
                controller.emailFocusMode.unfocus();
                controller.passwordFocusMode.unfocus();
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
                                //
                                //textfields
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
                              if (fieldIsEmpty(controller)) {
                                ref.read(authNotifierProvider.notifier).createAccount(
                                      email: controller.emailController.text.trim(),
                                      password: controller.passWordController.text.trim(),
                                      // map: AuthUserModel(email: controller.emailController)
                                    );
                              } else {
                                controller.passwordFocusMode.requestFocus();
                              }
                            },
                            child: Text(
                              TextConstant.signUp.toTitleCase(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ).padAll(15)),
            ),
          );
        });
  }
}
