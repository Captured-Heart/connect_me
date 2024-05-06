import '../../app.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showScaffoldSnackBar(SnackBar snackBar) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);

void showScaffoldSnackBarMessage(
  String message, {
  bool isError = false,
  int? duration,
}) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor:
            isError ? AppThemeColorDark.textError.withOpacity(0.6) : AppThemeColorDark.successColor,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.cancel_outlined : Icons.check_circle,
              color: AppThemeColorDark.textDark,
              size: 23,
            ).padSymmetric(horizontal: 5),
            Expanded(
              child: Text(
                message.toTitleCase(),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.bodyLarge.copyWith(
                  color: AppThemeColorDark.textDark,
                ),
                textScaleFactor: 0.85,
              ),
            ),
          ].rowInPadding(5),
        ),
        duration: Duration(seconds: duration ?? 1),
      ),
    );

void showScaffoldSnackBarMessageNoColor(
  String message, {
  bool isError = false,
  int? duration,
  double? width,
  bool? appearsBottom = false,
  required BuildContext context,
}) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        // width: width ?? context.sizeWidth(0.7),
        // showCloseIcon: true,
        margin: EdgeInsets.only(
          bottom: appearsBottom == true ? 0.0 : context.sizeHeight(0.8),
          top: appearsBottom == true ? context.sizeHeight(0.8) : 0.0,
          left: context.sizeWidth(0.15),
          right: context.sizeWidth(0.15),
        ),
        // closeIconColor: context.colorScheme.onSurface,
        backgroundColor: !isError
            ? AppThemeColorDark.successColor.withOpacity(0.8)
            : AppThemeColorDark.textError.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.c48,
          side: BorderSide(
            color: context.colorScheme.primary,
            width: 0.3,
          ),
        ),
        content: AutoSizeText(
          message.toTitleCase(),
          textAlign: TextAlign.center,
          maxLines: 2,
          minFontSize: 8,
          maxFontSize: 12,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyLarge?.copyWith(color: AppThemeColorDark.textDark),
        ),
        duration: Duration(seconds: duration ?? 2),
      ),
    );

Future<void> showDialogForQrCodes(
  BuildContext context, {
  String? title,
  Widget? content,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: context.textTheme.bodyLarge,
        title: title != null
            ? Text(
                title,
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
              ).padOnly(bottom: 10)
            : null,
        content: content,
        contentPadding: const EdgeInsets.only(top: 5),
        actionsAlignment: MainAxisAlignment.spaceAround,
        contentTextStyle: context.theme.textTheme.bodyMedium,
      );
    },
  );
}
