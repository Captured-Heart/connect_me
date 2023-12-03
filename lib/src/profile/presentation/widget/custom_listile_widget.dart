import 'package:connect_me/app.dart';

Column customListTileWidget({
  required BuildContext context,
  required String title,
  required String subtitle,
}) {
  return Column(
    children: [
      AutoSizeText(
        title,
        maxLines: 1,
        style: context.textTheme.bodyLarge,
        textScaleFactor: 0.95,
      ),
      AutoSizeText(
        subtitle,
        maxLines: 1,
        textScaleFactor: 0.95,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurface.withOpacity(0.85),
        ),
      ),
    ],
  );
}
