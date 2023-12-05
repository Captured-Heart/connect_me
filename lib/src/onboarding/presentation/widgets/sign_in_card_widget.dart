
import 'package:connect_me/app.dart';

class SignInCardWidget extends StatelessWidget {
  const SignInCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
          socialButtons(
            iconData: googleIcon,
            text: TextConstant.signInWithGoogle,
          ),

          // divider with text
          Row(
            children: [
              const Expanded(child: Divider()),
              const Text(TextConstant.orContinueWith).padSymmetric(horizontal: 20),
              const Expanded(child: Divider()),
            ],
          ),

          // textfield in a container
          EmailAndPasswordWidget(),

          //text btn[forgotten password] and continue btn
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(onPressed: () {}, child: const Text(TextConstant.forgottenPassword)),
              ElevatedButton(
                onPressed: () {
                  push(context, MainScreen());
                },
                child: Text(
                  TextConstant.continuebtn.toTitleCase(),
                ),
              ),
            ],
          )
        ].columnInPadding(20),
      ).padAll(15),
    );
  }
}
