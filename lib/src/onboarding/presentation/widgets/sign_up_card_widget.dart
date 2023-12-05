import 'package:connect_me/app.dart';

class SignUpCardWidget extends StatelessWidget {
  const SignUpCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
            const EmailAndPasswordWidget(),

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
}
