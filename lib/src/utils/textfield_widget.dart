// ignore_for_file: inference_failure_on_function_return_type

import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';

Widget authTextFieldWidget({
  required TextEditingController controller,
  required BuildContext context,
  FocusNode? focusNode,
  List<TextInputFormatter>? inputFormatters,
  String? hintText,
  String? errorText,
  String? initialValue,
  Function(String)? onChanged,
  Widget? suffixIcon,
  bool obscureText = false,
  TextInputType? keyboardType,
  VoidCallback? onTap,
  Widget? prefixIcon,
  bool? filled,
  bool? autoFocus,
  bool? readOnly,
  Color? fillColor,
  int? maxLength,
  String? label,
  bool? noBorders = false,
  TextInputAction? textInputAction,
  String? Function(String?)? validator,
}) {
  final borderDesign = noBorders == true
      ? InputBorder.none
      : OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 0.3, color: context.theme.textTheme.bodyMedium!.color!),
        );

  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? const SizedBox.shrink()
            : Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: AppFontWeight.w600,
                ),
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
          maxLength: maxLength,
          textInputAction: textInputAction ?? TextInputAction.next,
          cursorColor: context.theme.primaryColor,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          validator: validator,
          // style: AppTextStyle.bodyMedium,
          inputFormatters:
              // ignore: prefer_single_quotes
              inputFormatters ??
                  [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor ?? context.theme.scaffoldBackgroundColor,
            filled: filled,
            // errorStyle: AppTextStyle.errorTextstyle,

            // hintStyle: AppTextStyle.bodySmall.copyWith(
            //   color: AppThemeColorLight.textHint,
            // ),

            border: borderDesign,
            focusedBorder: borderDesign,
            enabledBorder: borderDesign,
            errorBorder: borderDesign,
            errorMaxLines: 1,
          ),
        ),
      ]);
}
