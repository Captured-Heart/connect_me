import 'package:connect_me/app.dart';

class MoreCustomListTileWidget extends StatelessWidget {
  const MoreCustomListTileWidget({
    super.key,
    this.subtitle,
    this.icon,
    required this.title,
    this.onTap,
    this.iconSize,
    this.trailingWidget,
    this.color,
    this.foregroundColor,
  });

  final String? subtitle;
  final String title;

  final IconData? icon;
  final VoidCallback? onTap;
  final double? iconSize;
  final Widget? trailingWidget;
  final Color? color, foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      // tileColor: color,
      horizontalTitleGap: 10,
      leading: icon == null
          ? null
          : CircleAvatar(
              radius: 18,
              backgroundColor: color,
              foregroundColor: foregroundColor,
              child: Icon(
                icon,
                size: iconSize ?? 20,
              ),
            ),
      title: AutoSizeText(
        title,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: AppFontWeight.w100,
          color: foregroundColor,
        ),
        textScaleFactor: 0.95,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null
          ? AutoSizeText(
              subtitle ?? '',
              maxLines: 1,
              // minFontSize: 10,
              // style: context.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 0.85,
            )
          : null,
      trailing: trailingWidget ??
          Icon(
            iosArrowForwardIcon,
            size: 17,
            color: foregroundColor,
          ),
    );
  }
}
