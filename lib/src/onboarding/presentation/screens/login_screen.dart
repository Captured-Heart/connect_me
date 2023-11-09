import 'package:connect_me/app.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

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
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(flipCardControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //! change the color of the card to match the scaffold color
            Align(
              child: FlipCard(
                controller: controller,
                flipOnTouch: false,
                onFlipDone: (isFront) {
                  setState(() {
                    isFrontOfCard = isFront;
                  });
                },
                fill: Fill.fillBack,
                back: signUpCardWidget().padAll(15),
                front: signInCardWidget(context).padAll(15),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: alreadyHaveAnAcctWidget(
                controller: controller,
                isFrontOfCard: isFrontOfCard,
              ),
            )
          ],
        ),
      ),
    );
  }

  Card signUpCardWidget() {
    return Card(
        elevation: 0,
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
            Container(
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.c12,
                border: Border.all(width: 0.2, color: context.colorScheme.onBackground),
              ),
              child: Column(
                children: [
                  //
                  //textfields
                  authTextFieldWidget(
                    hintText: TextConstant.emailAddress,
                    fillColor: context.colorScheme.surface,
                    controller: TextEditingController(),
                    context: context,
                    noBorders: true,
                  ).padSymmetric(horizontal: 8, vertical: 2),
                  const Divider(thickness: 1.2),

                  //textfields
                  authTextFieldWidget(
                    hintText: TextConstant.password,
                    fillColor: context.colorScheme.surface,
                    controller: TextEditingController(),
                    context: context,
                    noBorders: true,
                  ).padSymmetric(horizontal: 8, vertical: 2),
                ],
              ),
            ),

//sign up accts
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    TextConstant.signUp.toTitleCase(),
                  ),
                ),
              ],
            )
          ],
        ).padAll(15));
  }

  Card signInCardWidget(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //logo
          Column(
            children: [
              // Image.asset(
              //   ImagesConstant.appLogoBrown,
              //   height: context.sizeWidth(0.18),
              //   fit: BoxFit.cover,
              // ),
              Ink(
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.c12,
                  color: context.colorScheme.onSurface,
                ),
                child: Image.asset(
                  ImagesConstant.appLogoBrown,
                  height: context.sizeWidth(0.18),
                  fit: BoxFit.cover,
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
          Container(
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.c12,
              border: Border.all(width: 0.2, color: context.colorScheme.onBackground),
            ),
            child: Column(
              children: [
                //
                //textfields
                authTextFieldWidget(
                  hintText: TextConstant.emailAddress,
                  fillColor: context.colorScheme.surface,
                  controller: TextEditingController(),
                  context: context,
                  noBorders: true,
                ).padSymmetric(horizontal: 8, vertical: 2),
                const Divider(thickness: 1.2),

                //textfields
                authTextFieldWidget(
                  hintText: TextConstant.password,
                  fillColor: context.colorScheme.surface,
                  controller: TextEditingController(),
                  context: context,
                  noBorders: true,
                ).padSymmetric(horizontal: 8, vertical: 2),
              ],
            ),
          ),

          //text btn[forgotten password] and continue btn
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(onPressed: () {}, child: const Text(TextConstant.forgottenPassword)),
              ElevatedButton(
                onPressed: () {},
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

  Row alreadyHaveAnAcctWidget({
    required FlipCardController controller,
    required bool isFrontOfCard,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: AutoSizeText(
            isFrontOfCard == true ? TextConstant.alreadyHaveAnAcct : TextConstant.dontHaveAnAcct,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              controller.toggleCard();
            },
            child: AutoSizeText(
              isFrontOfCard == true ? TextConstant.login : TextConstant.signUp,
              style: context.textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
              maxLines: 1,
            ),
          ),
        )
      ].rowInPadding(10),
    );
  }

  Card socialButtons({
    required IconData iconData,
    required String text,
  }) {
    return Card(
      elevation: 3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          Flexible(
            child: AutoSizeText(
              text,
              maxLines: 1,
            ),
          ),
        ].rowInPadding(10),
      ).padAll(10),
    );
  }
}
