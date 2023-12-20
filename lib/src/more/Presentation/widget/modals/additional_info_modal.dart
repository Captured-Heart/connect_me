// EDUCATION MODEL
import 'package:connect_me/app.dart';

SliverWoltModalSheetPage additionalInfoModal(
    BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.additionalDetails, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const AdditionalInfoModalBody().padAll(15),
  );
}

class AdditionalInfoModalBody extends StatelessWidget {
  const AdditionalInfoModalBody({
    super.key,
    this.onCountryChanged,
    this.onCityChanged,
    this.onStateChanged,
  });
  final Function(String)? onCountryChanged;
  final Function(String?)? onStateChanged;
  final Function(String?)? onCityChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextFieldWidget(
          controller: TextEditingController(),
          labelMaterial: 'Date of Birth',
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(),
          labelMaterial: 'Place of Birth',
          hintText: 'Ex: Kanuri General Hospital, Kaduna',
        ),

        CSCPicker(
          onCountryChanged: onCountryChanged,
          onStateChanged: onStateChanged,
          onCityChanged: onCityChanged,
          disabledDropdownDecoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            border: Border.all(
              color: context.colorScheme.onBackground,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          dropdownDecoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            border: Border.all(
              color: context.colorScheme.onBackground,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          selectedItemStyle: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: AppFontWeight.w100),
          dropdownHeadingStyle: context.textTheme.bodyLarge,
          dropdownItemStyle: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: AppFontWeight.w100),
        ),

        AuthTextFieldWidget(
          controller: TextEditingController(),
          labelMaterial: 'Street',
          hintText: 'Ex: No 23b Olusegun Mugabe street',
        ),
        // STATE // POSTAL CODE
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                labelMaterial: 'Driver Licenses no',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                labelMaterial: 'Postal Code',
                hintText: 'Ex: 350003',
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(TextConstant.save),
          ),
        ),
      ].columnInPadding(15),
    );
  }
}
