import 'package:connect_me/app.dart';

Card socialButtons({
  required IconData iconData,
  required String text,
}) {
  return Card(
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
  );
}
