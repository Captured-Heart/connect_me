import 'package:connect_me/app.dart';

class AlreadyHaveAnAcctWidget extends StatelessWidget {
  const AlreadyHaveAnAcctWidget({
    super.key,
    required this.isLoginScreen,
    required this.onTap,
  });
  final bool isLoginScreen;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: AutoSizeText(
            isLoginScreen == true ? TextConstant.alreadyHaveAnAcct : TextConstant.dontHaveAnAcct,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: onTap,
            child: AutoSizeText(
              isLoginScreen == true ? TextConstant.login : TextConstant.signUp,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: AppFontWeight.w600,
                decoration: TextDecoration.underline,
              ),
              textScaleFactor: 0.8,
              maxLines: 1,
            ),
          ),
        )
      ].rowInPadding(5),
    );
  }
}
