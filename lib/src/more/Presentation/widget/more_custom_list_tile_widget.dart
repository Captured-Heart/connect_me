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
  });

  final String? subtitle;
  final String title;

  final IconData? icon;
  final VoidCallback? onTap;
  final double? iconSize;
  final Widget? trailingWidget;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      horizontalTitleGap: 10,
      leading: icon == null
          ? null
          : CircleAvatar(
              radius: 18,
              child: Icon(
                icon,
                size: iconSize ?? 20,
              ),
            ),
      title: Text(title),
      subtitle: subtitle != null
          ? AutoSizeText(
              subtitle ?? '',
              maxLines: 1,
              // minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 0.85,
            )
          : null,
      trailing: trailingWidget ??
          const Icon(
            iosArrowForwardIcon,
            size: 17,
          ),
    );
  }
}
