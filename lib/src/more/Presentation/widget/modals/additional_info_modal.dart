// ignore_for_file: public_member_api_docs, sort_constructors_first
// EDUCATION MODEL
import 'dart:developer';

import 'package:connect_me/app.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

SliverWoltModalSheetPage additionalInfoModal(BuildContext modalSheetContext, TextTheme textTheme) {
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

class AdditionalInfoModalBody extends StatefulWidget {
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
  State<AdditionalInfoModalBody> createState() => _AdditionalInfoModalBodyState();
}

class _AdditionalInfoModalBodyState extends State<AdditionalInfoModalBody> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final ValueNotifier<TextEditingController> dobNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<DateTime> dobDateTimeNotifier = ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<String> countryNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> stateNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> cityNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            dobNotifier,
            dobDateTimeNotifier,
            countryNotifier,
            stateNotifier,
            cityNotifier,
          ],
        ),
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! DATE OF BIRTH
              AuthTextFieldWidget(
                controller: dobNotifier.value,
                labelMaterial: TextConstant.dateOfBirth,
                readOnly: true,
                onTap: () {
                  showCupertinoDateWidget(
                    context: context,
                    onConfirm: (date) {
                      dobNotifier.value.text = dateFormatted2(date);
                      dobDateTimeNotifier.value = date;
                    },
                  );
                },
              ),

              //! PLACE OF BIRTH
              AuthTextFieldWidget(
                controller: controller.placeOfBirthController,
                inputFormatters: const [],
                labelMaterial: TextConstant.placeOfBirth,
                hintText: 'Ex: Kanuri General Hospital, Kaduna',
              ),

//! COUNTRY, STATE, CITY TEXTFIELD
              CSCPicker(
                onCountryChanged: (country) {
                  countryNotifier.value = country;
                },
                onStateChanged: (state) {
                  stateNotifier.value = state ?? '';
                },
                onCityChanged: (city) {
                  cityNotifier.value = city ?? '';
                },
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
                selectedItemStyle:
                    context.textTheme.bodyMedium?.copyWith(fontWeight: AppFontWeight.w100),
                dropdownHeadingStyle: context.textTheme.bodyLarge,
                dropdownItemStyle:
                    context.textTheme.bodyMedium?.copyWith(fontWeight: AppFontWeight.w100),
              ),

// ! STREET
              AuthTextFieldWidget(
                controller: controller.streetController,
                inputFormatters: const [],
                labelMaterial: TextConstant.street,
                hintText: 'Ex: No 23b Olusegun Mugabe street',
              ),

              // ! driver licenses
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AuthTextFieldWidget(
                      controller: controller.driverLicencesController,
                      inputFormatters: const [],
                      labelMaterial: TextConstant.driverLicenseNo,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: AuthTextFieldWidget(
                      controller: controller.postalCodeController,
                      inputFormatters: const [],
                      labelMaterial: TextConstant.postalCode,
                      hintText: 'Ex: 350003',
                    ),
                  ),
                ],
              ),

//! save button
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    var docId = const Uuid().v4();

                    inspect(
                      AdditionalDetailsModel(
                        dateOfBirth: dobDateTimeNotifier.value,
                        placeOfBirth: controller.placeOfBirthController.text,
                        country: countryNotifier.value,
                        state: stateNotifier.value,
                        city: cityNotifier.value,
                        street: controller.streetController.text,
                        driverLicenseNo: controller.driverLicencesController.text,
                        postalCode: controller.postalCodeController.text,
                        docId: docId,
                      ).toJson(),
                    );
                  },
                  child: const Text(TextConstant.save),
                ),
              ),
            ].columnInPadding(15),
          );
        });
  }
}
