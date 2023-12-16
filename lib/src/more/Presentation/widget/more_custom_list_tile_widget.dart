
import 'package:connect_me/app.dart';

class MoreCustomListTileWidget extends StatelessWidget {
  const MoreCustomListTileWidget({
    super.key,
    this.subtitle,
    this.icon,
    required this.title,
    this.onTap,
  });

  final String? subtitle;
  final String title;

  final IconData? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: icon == null
          ? null
          : Icon(
              icon,
              size: 24,
            ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle ?? '',
              textScaleFactor: 0.85,
            )
          : null,
      trailing: const Icon(
        iosArrowForwardIcon,
        size: 17,
      ),
    ).padOnly();
  }
}
