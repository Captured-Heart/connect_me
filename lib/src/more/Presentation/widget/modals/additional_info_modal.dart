// ignore_for_file: public_member_api_docs, sort_constructors_first
// EDUCATION MODEL

import 'package:connect_me/app.dart';
import 'package:uuid/uuid.dart';

SliverWoltModalSheetPage additionalInfoModal(
  BuildContext modalSheetContext,
  AuthUserModel? authUserModel,
) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.additionalDetails, style: modalSheetContext.textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: AdditionalInfoModalBody(
      authUserModel: authUserModel!,
    ).padAll(15),
  );
}

class AdditionalInfoModalBody extends ConsumerStatefulWidget {
  const AdditionalInfoModalBody({
    super.key,
    this.onCountryChanged,
    this.onCityChanged,
    this.onStateChanged,
    required this.authUserModel,
  });
  final Function(String)? onCountryChanged;
  final Function(String?)? onStateChanged;
  final Function(String?)? onCityChanged;
  final AuthUserModel authUserModel;

  @override
  ConsumerState<AdditionalInfoModalBody> createState() => _AdditionalInfoModalBodyState();
}

class _AdditionalInfoModalBodyState extends ConsumerState<AdditionalInfoModalBody> {
  // final TextEditingControllerClass controller = TextEditingControllerClass();

  @override
  Widget build(BuildContext context) {
    inspect(widget.authUserModel);
    final ValueNotifier<TextEditingController> dobNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(
            text: dateFormatted2(widget.authUserModel.date?.toDate() ?? DateTime.now())));
    final ValueNotifier<DateTime> dobDateTimeNotifier =
        ValueNotifier<DateTime>(widget.authUserModel.date?.toDate() ?? DateTime.now());
    final ValueNotifier<String?> countryNotifier =
        ValueNotifier<String?>(widget.authUserModel.additionalDetails?.country);
    final ValueNotifier<String?> stateNotifier =
        ValueNotifier<String?>(widget.authUserModel.additionalDetails?.state);
    final ValueNotifier<String?> cityNotifier =
        ValueNotifier<String?>(widget.authUserModel.additionalDetails?.city);
    final ValueNotifier<String> placeOfBirthNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.placeOfBirth ?? '');
    final ValueNotifier<String> driverLicenseNoNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.driverLicenseNo ?? '');
    final ValueNotifier<String> postalCodeNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.postalCode ?? '');
    final ValueNotifier<String> streetNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.street ?? '');

    final infoState = ref.watch(addAdditionalDetailsProvider);

    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            dobNotifier,
            dobDateTimeNotifier,
            countryNotifier,
            stateNotifier,
            cityNotifier,
            placeOfBirthNotifier,
            driverLicenseNoNotifier,
            postalCodeNotifier,
            streetNotifier,
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
                    currentTime: widget.authUserModel.date?.toDate(),
                    onConfirm: (date) {
                      dobNotifier.value.text = dateFormatted2(date);
                      dobDateTimeNotifier.value = date;
                    },
                  );
                },
              ),

              //! PLACE OF BIRTH
              AuthTextFieldWidget(
                inputFormatters: const [],
                labelMaterial: TextConstant.placeOfBirth,
                initialValue: placeOfBirthNotifier.value,
                hintText: 'Ex: Kanuri General Hospital, Kaduna',
                onChanged: (value) {
                  placeOfBirthNotifier.value = value;
                },
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
                currentCountry: countryNotifier.value,
                currentState: stateNotifier.value,
                currentCity: cityNotifier.value,
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
                inputFormatters: const [],
                initialValue: streetNotifier.value,
                labelMaterial: TextConstant.street,
                hintText: 'Ex: No 23b Olusegun Mugabe street',
                onChanged: (value) {
                  streetNotifier.value = value;
                },
              ),

              // ! driver licenses
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AuthTextFieldWidget(
                      initialValue: driverLicenseNoNotifier.value,
                      inputFormatters: const [],
                      labelMaterial: TextConstant.driverLicenseNo,
                      onChanged: (value) {
                        driverLicenseNoNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: AuthTextFieldWidget(
                      initialValue: postalCodeNotifier.value,
                      inputFormatters: const [],
                      labelMaterial: TextConstant.postalCode,
                      hintText: 'Ex: 350003',
                      onChanged: (value) {
                        postalCodeNotifier.value = value;
                      },
                    ),
                  ),
                ],
              ),
              infoState.value == null || infoState.hasError
                  ? const SizedBox.shrink()
                  : Text(
                      infoState.hasError
                          ? infoState.error.toString()
                          : infoState.valueOrNull.toString(),
                      style: AppTextStyle.bodyMedium.copyWith(
                          color: infoState.hasError ? Colors.red : AppThemeColorDark.successColor),
                    ),

//! save button
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    // var docId = const Uuid().v4();

                    MapDynamicString map = CreateFormMap.createDataMap(
                      controllersText: [
                        dateFormatted2(dobDateTimeNotifier.value),
                        placeOfBirthNotifier.value,
                        countryNotifier.value ?? '',
                        stateNotifier.value ?? '',
                        cityNotifier.value ?? '',
                        streetNotifier.value,
                        driverLicenseNoNotifier.value,
                        postalCodeNotifier.value,
                      ],
                      customKeys: [
                        FirebaseDocsFieldEnums.dateOfBirth.name,
                        FirebaseDocsFieldEnums.placeOfBirth.name,
                        FirebaseDocsFieldEnums.country.name,
                        FirebaseDocsFieldEnums.state.name,
                        FirebaseDocsFieldEnums.city.name,
                        FirebaseDocsFieldEnums.street.name,
                        FirebaseDocsFieldEnums.driverLicenseNo.name,
                        FirebaseDocsFieldEnums.postalCode.name,
                      ],
                    );

                    inspect(map);

                    ref.read(addAdditionalDetailsProvider.notifier).addAdditionalDetails(map: map);
                  },
                  child: infoState.isLoading == true
                      ? SizedBox(
                          height: 20,
                          width: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: context.colorScheme.surface,
                          ),
                        )
                      : const Text(TextConstant.save),
                ),
              ),
            ].columnInPadding(15),
          );
        });
  }
}
