import 'package:connect_me/app.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
    required this.iconData,
    required this.text,
    this.onTap,
    this.elevation,
    this.isDense = false,
    this.color,
    this.textColor,
  });

  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final double? elevation;
  final bool isDense;
  final Color? color, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.onSurface,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(isDense == true ? 10 : 15),
        ),
        elevation: elevation ?? 3,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: textColor ?? context.theme.iconTheme.color,
            ),
            Flexible(
              child: AutoSizeText(
                text,
                maxLines: 1,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: textColor ?? context.colorScheme.onBackground,
                ),
              ),
            ),
          ].rowInPadding(10),
        ).padAll(isDense == true ? 5 : 10),
      ),
    );
  }
}
