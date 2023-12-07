import 'package:connect_me/app.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
    required this.iconData,
    required this.text,
    this.onTap,
  });

  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: context.colorScheme.onSurface,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(15)),
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
      ),
    );
  }
}
