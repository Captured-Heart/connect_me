import 'dart:io';

import 'package:connect_me/app.dart';
import 'package:flutter/cupertino.dart';

Future<void> warningDialogs({
  required BuildContext context,
  required DialogModel dialogModel,
  bool isSuccessDialog = false,
  Widget? content,
}) =>
    showDialog(
      context: context,
      builder: (context1) {
        return isSuccessDialog == true
            ? AppCustomSuccessDialog(dialogModel: dialogModel)
            : AppCustomDialogWarning(
                dialogModel: dialogModel,
                // content: content,
              );
      },
    );

// THIS IS THE DIALOG FOR WARNING
class AppCustomDialogWarning extends StatefulWidget {
  const AppCustomDialogWarning({
    super.key,
    required this.dialogModel,
    // this.content,
  });
  final DialogModel dialogModel;
  // final Widget? content;

  @override
  State<AppCustomDialogWarning> createState() => _AppCustomDialogWarningState();
}

class _AppCustomDialogWarningState extends State<AppCustomDialogWarning> {
  // final DialogModel dialogModel = DialogModel();
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: widget.dialogModel.title == null
            ? null
            : Text(
                widget.dialogModel.title!,
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
              ).padOnly(bottom: 10),
        content: widget.dialogModel.content ??
            (widget.dialogModel.contentText != null
                ? Row(
                    children: [
                      widget.dialogModel.hasImage == false
                          ? const SizedBox.shrink()
                          : CachedNetworkImageWidget(
                              imgUrl: widget.dialogModel.imgUrl,
                              height: widget.dialogModel.height ?? 80,
                            ),
                      Expanded(
                        child: Text(
                          widget.dialogModel.contentText ?? '',
                          textScaleFactor: 1.1,
                          textAlign: widget.dialogModel.hasImage == true
                              ? TextAlign.left
                              : TextAlign.center,
                        ),
                      )
                    ].rowInPadding(10),
                  ).padSymmetric(horizontal: 15)
                : const SizedBox.shrink()),
        actions: [
          TextButton(
            onPressed: widget.dialogModel.onNegativeAction ??
                () {
                  pop(context);
                },
            style: TextButton.styleFrom(
                foregroundColor: context.theme.colorScheme.error),
            child: Text(
              widget.dialogModel.negativeActionText ?? TextConstant.cancel,
            ),
          ),
          // SizedBox.shrink(),
          TextButton(
            onPressed: widget.dialogModel.onPostiveAction,
            style: TextButton.styleFrom(
                foregroundColor: context.theme.colorScheme.onBackground),
            child: Text(
                widget.dialogModel.postiveActionText ?? TextConstant.confirm),
          )
        ],
      );
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: AppTextStyle.bodyMedium,
        title: widget.dialogModel.title == null
            ? null
            : Text(
                widget.dialogModel.title!,
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
              ).padOnly(bottom: 10),

        //?.padSymmetric(horizontal: 20, vertical: 10)
        content: widget.dialogModel.content ??
            (widget.dialogModel.contentText != null
                ? Row(
                    children: [
                      widget.dialogModel.hasImage == false
                          ? const SizedBox.shrink()
                          : CachedNetworkImageWidget(
                              imgUrl: widget.dialogModel.imgUrl,
                              height: widget.dialogModel.height ?? 80,
                            ),
                      Expanded(
                        child: Text(
                          widget.dialogModel.contentText ?? '',
                          textScaleFactor: 1.1,
                          textAlign: widget.dialogModel.hasImage == true
                              ? TextAlign.left
                              : TextAlign.center,
                        ),
                      )
                    ].rowInPadding(10),
                  ).padSymmetric(horizontal: 15)
                : const SizedBox.shrink()),
        // contentPadding: const EdgeInsets.only(top: 5),
        actionsAlignment: MainAxisAlignment.spaceAround,
        // contentTextStyle: context.theme.textTheme.bodyMedium,
        actionsPadding: const EdgeInsets.only(bottom: 5),
        actions: [
          TextButton(
              onPressed: widget.dialogModel.onNegativeAction ??
                  () {
                    pop(context);
                  },
              style: TextButton.styleFrom(
                  foregroundColor: context.theme.colorScheme.error),
              child: Text(widget.dialogModel.negativeActionText ??
                  TextConstant.cancel)),
          TextButton(
            onPressed: widget.dialogModel.onPostiveAction,
            style: TextButton.styleFrom(
                foregroundColor: context.theme.colorScheme.onBackground),
            child: Text(
                widget.dialogModel.postiveActionText ?? TextConstant.confirm),
          )
        ],
      );
    }
  }
}

// THIS IS THE DIALOG FOR SUCCESS JUST LIKE THE NAME IMPLIES
class AppCustomSuccessDialog extends StatefulWidget {
  const AppCustomSuccessDialog({
    super.key,
    required this.dialogModel,
    // this.content,
  });
  final DialogModel dialogModel;
  // final Widget? content;

  @override
  State<AppCustomSuccessDialog> createState() => _AppCustomSuccessDialogState();
}

class _AppCustomSuccessDialogState extends State<AppCustomSuccessDialog> {
  // final DialogModel dialogModel = DialogModel();
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: widget.dialogModel.title == null
            ? null
            : Text(
                widget.dialogModel.title!,
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
              ).padOnly(bottom: 10),
        content: widget.dialogModel.contentText?.isEmpty == false
            ? Text(widget.dialogModel.contentText ?? '')
            : null,
        actions: [
          TextButton(
            onPressed: widget.dialogModel.onPostiveAction,
            style: TextButton.styleFrom(
                foregroundColor: context.theme.colorScheme.onBackground),
            child: Text(
                widget.dialogModel.postiveActionText ?? TextConstant.confirm),
          )
        ],
      );
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: AppTextStyle.bodyMedium,
        title: widget.dialogModel.title == null
            ? null
            : Text(
                widget.dialogModel.title!,
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
              ).padOnly(bottom: 10),

        //?.padSymmetric(horizontal: 20, vertical: 10)
        content: widget.dialogModel.contentText?.isEmpty == false
            ? Text(widget.dialogModel.contentText ?? '')
            : null,
        // contentPadding: const EdgeInsets.only(top: 5),
        actionsAlignment: MainAxisAlignment.spaceAround,
        // contentTextStyle: context.theme.textTheme.bodyMedium,
        actionsPadding: const EdgeInsets.only(bottom: 5),
        actions: [
          TextButton(
            onPressed: widget.dialogModel.onPostiveAction,
            style: TextButton.styleFrom(
                foregroundColor: context.theme.colorScheme.onBackground),
            child: Text(
                widget.dialogModel.postiveActionText ?? TextConstant.confirm),
          )
        ],
      );
    }
  }
}

class DialogModel {
  String? errorMessage;
  VoidCallback? onNegativeAction;
  VoidCallback? onPostiveAction;
  bool? hasImage;
  String? imgUrl;
  double? height;
  String? title;
  String? contentText;

  Widget? content;
  String? negativeActionText;
  String? postiveActionText;
  DialogModel({
    this.errorMessage,
    this.onNegativeAction,
    this.onPostiveAction,
    this.hasImage = false,
    this.imgUrl,
    this.height,
    this.title,
    this.content,
    this.contentText,
    this.negativeActionText,
    this.postiveActionText,
  });

  DialogModel copyWith({
    String? errorMessage,
    VoidCallback? onNegativeAction,
    VoidCallback? onPostiveAction,
    bool? hasImage,
    String? imgUrl,
    double? height,
    String? title,
    String? contentText,
    Widget? content,
    String? negativeActionText,
    String? postiveActionText,
  }) {
    return DialogModel(
      errorMessage: errorMessage ?? this.errorMessage,
      onNegativeAction: onNegativeAction ?? this.onNegativeAction,
      onPostiveAction: onPostiveAction ?? this.onPostiveAction,
      hasImage: hasImage ?? this.hasImage,
      imgUrl: imgUrl ?? this.imgUrl,
      height: height ?? this.height,
      title: title ?? this.title,
      contentText: contentText ?? this.contentText,
      content: content ?? this.content,
      negativeActionText: negativeActionText ?? this.negativeActionText,
      postiveActionText: postiveActionText ?? this.postiveActionText,
    );
  }
}
