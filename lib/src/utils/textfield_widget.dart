// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/services.dart';

import '../../app.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget({
    super.key,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.autoFocus,
    this.fillColor,
    this.filled,
    this.label,
    this.maxLength,
    this.noBorders = false,
    this.onTap,
    this.prefixIcon,
    this.readOnly,
    this.textInputAction,
    this.validator,
    this.labelMaterial,
    this.contentPadding,
    this.maxLines,
    this.labelWidget,
    this.inputBorder,
    this.focusedInputBorder,
  });
  final TextEditingController? controller;

  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final bool? filled;
  final bool? autoFocus;
  final bool? readOnly;
  final Color? fillColor;
  final int? maxLength;
  final int? maxLines;

  final String? label;
  final Widget? labelWidget;

  final String? labelMaterial;
  final EdgeInsets? contentPadding;

  final bool? noBorders;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final InputBorder? inputBorder, focusedInputBorder;
  // final borderDesign(context) = noBorders == true
  //     ? InputBorder.none
  //     : OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(width: 0.3, color: context.theme.textTheme.bodyMedium!.color!),
  //       );
  InputBorder borderDesign(BuildContext context, {bool isFocused = false, bool isError = false}) {
    if (noBorders == true) {
      return InputBorder.none;
    } else {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: isFocused == true ? 0.7 : 0.1,
          color: isError == true
              ? context.colorScheme.error
              : context.theme.textTheme.bodyMedium!.color!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label == null
              ? const SizedBox.shrink()
              : Text(
                  label ?? '',
                  style: context.textTheme.bodyMedium,
                  textScaleFactor: 0.9,
                ).padOnly(bottom: 7),
          TextFormField(
            onTap: onTap,

            initialValue: initialValue,
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly ?? false,
            autofocus: autoFocus ?? false,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSaved: onSaved,
            maxLength: maxLength,
            maxLines: maxLines,
            textInputAction: textInputAction ?? TextInputAction.next,
            cursorColor: context.theme.primaryColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            validator: validator,
            style: context.textTheme.bodySmall,
            //  AppTextStyle.bodySmall,
            inputFormatters:
                // ignore: prefer_single_quotes
                inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: contentPadding ?? const EdgeInsets.all(12),
              hintStyle: context.textTheme.bodySmall?.copyWith(
                fontWeight: AppFontWeight.w100,
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),

              label: labelWidget,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              labelStyle: context.textTheme.bodyMedium?.copyWith(
                fontWeight: AppFontWeight.w100,
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),

              labelText: labelWidget == null ? labelMaterial : null,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? context.theme.scaffoldBackgroundColor,
              filled: filled,
              errorStyle: AppTextStyle.errorTextstyle,

              // hintStyle: AppTextStyle.bodySmall.copyWith(
              //   color: AppThemeColorLight.textHint,
              // ),

              border: inputBorder ?? borderDesign(context),
              focusedBorder: focusedInputBorder ?? borderDesign(context, isFocused: true),
              enabledBorder: inputBorder ?? borderDesign(context),
              errorBorder: borderDesign(context, isError: true),
              errorMaxLines: 1,
            ),
          ),
        ]);
  }
}
