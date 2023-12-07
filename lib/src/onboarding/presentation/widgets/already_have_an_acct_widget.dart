import 'package:connect_me/app.dart';

class AlreadyHaveAnAcctWidget extends StatelessWidget {
  const AlreadyHaveAnAcctWidget({
    super.key,
    required this.controller,
    required this.isFrontOfCard,
  });
  final FlipCardController controller;
  final bool isFrontOfCard;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: AutoSizeText(
            isFrontOfCard == true
                ? TextConstant.alreadyHaveAnAcct
                : TextConstant.dontHaveAnAcct,
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
}
