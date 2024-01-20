import 'package:connect_me/app.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    this.subtitle,
    required this.title,
    this.showAtsign = false,
    this.subtitleMaxLines,
    this.subtitleTextAlign,
    this.isStaticTheme = false,
    this.isSubtitleUrl,
  });
  final String title;
  final String? subtitle;
  final bool showAtsign;
  final int? subtitleMaxLines;
  final TextAlign? subtitleTextAlign;
  final bool isStaticTheme;
  final String? isSubtitleUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: subtitleTextAlign == TextAlign.start
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          title,
          maxLines: 1,
          textAlign: subtitleTextAlign ?? TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            color: isStaticTheme == true ? Colors.black : null,
          ),
          textScaleFactor: 0.95,
        ).padOnly(bottom: 2),
        subtitle == null
            ? const SizedBox.shrink()

            // TextButton(onPressed: () {}, child: Text(subtitle ?? ''))
            : AutoSizeText(
                showAtsign == true ? '@$subtitle' : '$subtitle',
                maxLines: subtitleMaxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: subtitleTextAlign ?? TextAlign.center,
                textScaleFactor: 0.95,
                style: context.textTheme.bodySmall?.copyWith(
                  color: isStaticTheme == true
                      ? Colors.black
                      : context.colorScheme.onSurface.withOpacity(0.85),
                ),
              ),
        isSubtitleUrl != null || isSubtitleUrl?.isNotEmpty == true
            ? GestureDetector(
                onTap: () {
                  subtitle != null ? UrlOptions.launchWeb(isSubtitleUrl!) : null;
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 2, top: 4),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: AppThemeColorDark.textButton,
                    )),
                  ),
                  child: AutoSizeText(
                    '$isSubtitleUrl',
                    maxLines: subtitleMaxLines ?? 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: subtitleTextAlign ?? TextAlign.center,
                    textScaleFactor: 0.95,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppThemeColorDark.textButton,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
