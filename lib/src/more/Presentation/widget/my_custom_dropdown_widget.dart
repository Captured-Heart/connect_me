

import '../../../../app.dart';

class MyCustomDropWidget extends StatelessWidget {
  const MyCustomDropWidget({
    super.key,
    required this.items,
    this.hintText,
    this.onChanged,
  });

  final List<Widget> items;
  final String? hintText;
  final dynamic Function(Widget)? onChanged;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      items: items,
      listItemBuilder: (context, item) {
        return item;
      },
      headerBuilder: (context, selectedItem) {
        return selectedItem;
      },
      hintBuilder: (context, hint) {
        return AutoSizeText(
          hintText ?? TextConstant.choose,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onBackground.withOpacity(0.6),
          ),
        );
      },
      closedBorder: Border.all(
        color: context.theme.textTheme.bodyMedium!.color!,
        width: 0.3,
      ),
      expandedBorder: Border.all(
        color: context.theme.textTheme.bodyMedium!.color!,
        width: 0.3,
      ),
      onChanged: onChanged,
      closedFillColor: context.theme.scaffoldBackgroundColor,
      expandedFillColor: context.theme.scaffoldBackgroundColor,
    );
  }
}

class MyCustomDropWidgetWithStrings extends StatelessWidget {
  const MyCustomDropWidgetWithStrings({
    super.key,
    required this.items,
    this.hintText,
    this.onChanged,
    this.validator,
    this.initialItem,
  });

  final List<String> items;
  final String? hintText, initialItem;
  final String? Function(String?)? validator;
  final dynamic Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      items: items,
      validator: validator,
      initialItem: initialItem?.isEmpty == true ? null : initialItem,
      listItemBuilder: (context, item) {
        return AutoSizeText(
          item,
          style: context.textTheme.bodySmall,
        );
      },
      headerBuilder: (context, selectedItem) {
        return AutoSizeText(
          selectedItem,
          style: context.textTheme.bodySmall,
          maxLines: 1,
        );
      },
      hintBuilder: (context, hint) {
        return AutoSizeText(
          hintText ?? TextConstant.choose,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onBackground.withOpacity(0.6),
          ),
          minFontSize: 9,
          maxLines: 1,
        );
      },
      closedBorder: Border.all(
        color: context.theme.textTheme.bodyMedium!.color!,
        width: 0.3,
      ),
      expandedBorder: Border.all(
        color: context.theme.textTheme.bodyMedium!.color!,
        width: 0.3,
      ),
      closedErrorBorder: Border.all(
        color: context.colorScheme.error,
        width: 0.3,
      ),
      closedErrorBorderRadius: AppBorderRadius.c10,
      closedBorderRadius: AppBorderRadius.c12,
      onChanged: onChanged,
      closedFillColor: context.theme.scaffoldBackgroundColor,
      expandedFillColor: context.theme.scaffoldBackgroundColor,
      closedSuffixIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: context.colorScheme.onBackground,
        size: 20,
      ),
      expandedSuffixIcon: Icon(
        Icons.keyboard_arrow_up_rounded,
        color: context.colorScheme.onBackground,
        size: 20,
      ),
      errorStyle: AppTextStyle.errorTextstyle,
    );
  }
}
