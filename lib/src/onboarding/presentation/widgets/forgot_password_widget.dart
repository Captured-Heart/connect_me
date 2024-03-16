import 'package:connect_me/app.dart';

class ForgotPasswordCard extends ConsumerWidget {
  ForgotPasswordCard({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  final GlobalKey<FormState> _forgotPassformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(textEditingControllerProvider);
    ref.listen(resetPasswordNotifierProvider, (previous, next) {
      if (next.errorMessage == 'reset') {
        warningDialogs(
          context: context,
          dialogModel: DialogModel(
            title: 'Reset Password Succesful!',
            contentText:
                'An email have been sent to "${controller.emailController.text}", kindly check your spam, if not seen',
            postiveActionText: TextConstant.ok,
            onPostiveAction: () {
              pop(context);
              pageController.jumpToPage(0);
            },
          ),
          isSuccessDialog: true,
        );
      }
    });
    return Form(
      key: _forgotPassformKey,
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: context.colorScheme.primaryContainer.withOpacity(0.7),
                  child: Lottie.asset(
                    ImagesConstant.lottieForgotPasswordImg,
                    height: context.sizeHeight(0.08),
                    width: 120,
                    fit: BoxFit.fill,
                    reverse: false,
                  ).padAll(10),
                ).padOnly(top: 10),
                Text(
                  'Forgot Password?',
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ].columnInPadding(5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(TextConstant.enterRegisteredEmail),
                AuthTextFieldWidget(
                  onTap: () {},
                  hintText: TextConstant.emailAddress,
                  fillColor: Colors.transparent,
                  controller: controller.emailController,
                  // validator: RequiredValidator(errorText: AuthErrors.requiredValue.errorMessage),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return TextConstant.required;
                    } else {
                      return null;
                    }
                  },
                  noBorders: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
              ].columnInPadding(8),
            ).padOnly(top: 15),
            ElevatedButton(
              onPressed: () {
                // warningDialogs(
                //   context: context,
                //   dialogModel: DialogModel(
                //     title: 'Reset Password Succesful!',
                //     contentText:
                //         'An email have been sent to "${controller.emailController.text}", kindly check your spam, if not seen',
                //     postiveActionText: TextConstant.ok,
                //   ),
                //   isSuccessDialog: true,
                // );
                if (_forgotPassformKey.currentState!.validate()) {
                  ref
                      .read(resetPasswordNotifierProvider.notifier)
                      .sendResetPassowrd(email: controller.emailController.text.trim());
                }
              },
              child: Text(
                TextConstant.continuebtn.toTitleCase(),
              ),
            ),
          ].columnInPadding(20),
        ).padSymmetric(horizontal: 15),
      ),
    );
  }
}
