import 'package:connect_me/app.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({
    super.key,
    required this.iconData,
    required this.text,
    this.color,
    this.onTap,
  });

  final String text;
  final IconData iconData;
  final Color? color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color ?? context.theme.iconTheme.color,
            size: 12,
          ),
          Flexible(
            child: AutoSizeText(
              text,
              maxLines: 1,
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: color ?? context.colorScheme.onBackground, fontSize: 11),
              minFontSize: 10,
              maxFontSize: 12,
              textScaleFactor: 0.9,
              // textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ].rowInPadding(5),
      ),
    );
  }
}
