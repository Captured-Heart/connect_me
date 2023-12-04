// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:connect_me/app.dart';

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
              color: isError ? AppThemeColorDark.textError : AppThemeColorDark.textDark,
              size: 35,
            ),
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.left,
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
  required BuildContext context,
}) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        width: width ?? 200,
        backgroundColor: context.theme.snackBarTheme.backgroundColor?.withOpacity(0.3),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.c48),
        content: AutoSizeText(
          message,
          textAlign: TextAlign.center,
          maxLines: 1,
          minFontSize: 9,
        ),
        duration: Duration(seconds: duration ?? 1),
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
        // actionsPadding: EdgeInsets.zero,
        // actions: [
        // TextButton(
        //     onPressed: onNegativeAction ??
        //         () {
        //           pop(context);
        //         },
        //     style: TextButton.styleFrom(foregroundColor: TagoLight.textError),
        //     child: const Text(TextConstant.cancel)),
        // TextButton(onPressed: onPostiveAction, child: const Text(TextConstant.confirm))
        // ],
      );
    },
  );
}
