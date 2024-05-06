
import '../../../../app.dart';

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
        TextButtonWithBorderAndArrowIcon(
          title: isSubtitleUrl ?? '',
          onTap: () {
            subtitle != null ? UrlOptions.launchWeb(isSubtitleUrl!, launchModeEXT: true) : null;
          },
        ),
      ].columnInPadding(2),
    );
  }
}

class TextButtonWithBorderAndArrowIcon extends StatelessWidget {
  const TextButtonWithBorderAndArrowIcon({
    super.key,
    required this.title,
    required this.onTap,
    this.padding,
    this.isDense = false,
    this.isArrowForward = false,
  });

  final String title;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final bool isDense, isArrowForward;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return title.isEmpty || title == null
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textScaleFactor: isDense == true ? 0.7 : 0.95,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppThemeColorDark.textButton,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  Icon(
                    isArrowForward == true ? Icons.arrow_forward_outlined : Icons.arrow_outward,
                    color: AppThemeColorDark.textButton,
                    size: isDense == true ? 10 : 14,
                  ).padOnly(left: 3),
                ],
              ),
            ),
          );
  }
}
