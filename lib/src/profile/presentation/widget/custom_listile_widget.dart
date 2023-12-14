import 'package:connect_me/app.dart';

// Column customListTileWidget({
//   required BuildContext context,
//   required String title,
//   String? subtitle,
// }) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       AutoSizeText(
//         title,
//         maxLines: 1,
//         style: context.textTheme.bodyLarge,
//         textScaleFactor: 0.95,
//       ),
//       subtitle == null
//           ? const SizedBox.shrink()
//           : AutoSizeText(
//               '@$subtitle',
//               maxLines: 1,
//               textScaleFactor: 0.95,
//               style: context.textTheme.bodySmall?.copyWith(
//                 color: context.colorScheme.onSurface.withOpacity(0.85),
//               ),
//             ),
//     ],
//   );
// }

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    this.subtitle,
    required this.title,
    this.showAtsign = false,
  });
  final String title;
  final String? subtitle;
  final bool showAtsign;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(
          showAtsign == true ? '@$title' : title,
          maxLines: 1,
          style: context.textTheme.bodyLarge,
          textScaleFactor: 0.95,
        ),
        subtitle == null
            ? const SizedBox.shrink()
            : AutoSizeText(
                '$subtitle',
                maxLines: 1,
                textScaleFactor: 0.95,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.85),
                ),
              ),
      ],
    );
  }
}
