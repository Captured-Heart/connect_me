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
        subtitle == null || subtitle?.isEmpty == true
            ? const SizedBox.shrink()
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
                  subtitle != null
                      ? UrlOptions.launchWeb(isSubtitleUrl!, launchModeEXT: true)
                      : null;
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.c12,
                    border: Border.all(
                      //   bottom: BorderSide(
                      color: AppThemeColorDark.textButton,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
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
                      const Icon(
                        Icons.arrow_outward,
                        color: AppThemeColorDark.textButton,
                        size: 14,
                      ).padOnly(left: 3),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink()
      ].columnInPadding(2),
    );
  }
}
