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
    this.subtitleMaxLines,
    this.subtitleTextAlign,
  });
  final String title;
  final String? subtitle;
  final bool showAtsign;
  final int? subtitleMaxLines;
  final TextAlign? subtitleTextAlign;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: subtitleTextAlign == TextAlign.start
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          showAtsign == true ? '@$title' : title,
          maxLines: 1,
          textAlign: subtitleTextAlign ?? TextAlign.center,
          style: context.textTheme.bodyLarge,
          textScaleFactor: 0.95,
        ),
        subtitle == null
            ? const SizedBox.shrink()
            : AutoSizeText(
                '$subtitle',
                maxLines: subtitleMaxLines ?? 1,
                overflow: TextOverflow.ellipsis,
                textAlign: subtitleTextAlign ?? TextAlign.center,
                textScaleFactor: 0.95,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.85),
                ),
              ),
      ],
    );
  }
}
