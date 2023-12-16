// ignore_for_file: inference_failure_on_function_return_type

import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.inputFormatters,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.onChanged,
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
    this.maxLines,
  });
  final TextEditingController controller;

  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final Function(String)? onChanged;
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
  final String? labelMaterial;

  final bool? noBorders;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  // final borderDesign(context) = noBorders == true
  //     ? InputBorder.none
  //     : OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(width: 0.3, color: context.theme.textTheme.bodyMedium!.color!),
  //       );
  InputBorder borderDesign(BuildContext context, {bool isFocused = false}) {
    if (noBorders == true) {
      return InputBorder.none;
    } else {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: isFocused == true ? 0.7 : 0.1,
          color: context.theme.textTheme.bodyMedium!.color!,
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
            maxLength: maxLength,
            maxLines: maxLines,
            textInputAction: textInputAction ?? TextInputAction.next,
            cursorColor: context.theme.primaryColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            validator: validator,
            style: AppTextStyle.bodySmall,
            inputFormatters:
                // ignore: prefer_single_quotes
                inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: context.textTheme.bodySmall?.copyWith(
                fontWeight: AppFontWeight.w100,
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),

              // label: labelMaterial != null
              //     ? AutoSizeText(
              //         labelMaterial ?? '',
              //         maxLines: 1,
              //         textAlign: TextAlign.start,
              //       )
              //     : null,
              labelStyle: context.textTheme.bodyMedium?.copyWith(
                fontWeight: AppFontWeight.w100,
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
              labelText: labelMaterial,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? context.theme.scaffoldBackgroundColor,
              filled: filled,
              errorStyle: AppTextStyle.errorTextstyle,

              // hintStyle: AppTextStyle.bodySmall.copyWith(
              //   color: AppThemeColorLight.textHint,
              // ),

              border: borderDesign(context),
              focusedBorder: borderDesign(context, isFocused: true),
              enabledBorder: borderDesign(context),
              errorBorder: borderDesign(context),
              errorMaxLines: 1,
            ),
          ),
        ]);
  }
}

// Widget authTextFieldWidget({
//   required TextEditingController controller,
//   required BuildContext context,
//   FocusNode? focusNode,
//   List<TextInputFormatter>? inputFormatters,
//   String? hintText,
//   String? errorText,
//   String? initialValue,
//   Function(String)? onChanged,
//   Widget? suffixIcon,
//   bool obscureText = false,
//   TextInputType? keyboardType,
//   VoidCallback? onTap,
//   Widget? prefixIcon,
//   bool? filled,
//   bool? autoFocus,
//   bool? readOnly,
//   Color? fillColor,
//   int? maxLength,
//   String? label,
//   bool? noBorders = false,
//   TextInputAction? textInputAction,
//   String? Function(String?)? validator,
// }) {
//   final borderDesign = noBorders == true
//       ? InputBorder.none
//       : OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(width: 0.3, color: context.theme.textTheme.bodyMedium!.color!),
//         );

//   return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         label == null
//             ? const SizedBox.shrink()
//             : Text(
//                 label,
//                 style: context.textTheme.bodyMedium?.copyWith(
//                   fontWeight: AppFontWeight.w600,
//                 ),
//               ).padOnly(bottom: 7),
//         TextFormField(
//           onTap: onTap,
//           initialValue: initialValue,
//           controller: controller,
//           focusNode: focusNode,
//           readOnly: readOnly ?? false,
//           autofocus: autoFocus ?? false,
//           obscureText: obscureText,
//           keyboardType: keyboardType,
//           onChanged: onChanged,
//           maxLength: maxLength,
//           textInputAction: textInputAction ?? TextInputAction.next,
//           cursorColor: context.theme.primaryColor,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           autocorrect: false,
//           validator: validator,
//           // style: AppTextStyle.bodyMedium,
//           inputFormatters:
//               // ignore: prefer_single_quotes
//               inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))],
//           decoration: InputDecoration(
//             hintText: hintText,
//             prefixIcon: prefixIcon,
//             suffixIcon: suffixIcon,
//             fillColor: fillColor ?? context.theme.scaffoldBackgroundColor,
//             filled: filled,
//             // errorStyle: AppTextStyle.errorTextstyle,

//             // hintStyle: AppTextStyle.bodySmall.copyWith(
//             //   color: AppThemeColorLight.textHint,
//             // ),

//             border: borderDesign,
//             focusedBorder: borderDesign,
//             enabledBorder: borderDesign,
//             errorBorder: borderDesign,
//             errorMaxLines: 1,
//           ),
//         ),
//       ]);
// }
