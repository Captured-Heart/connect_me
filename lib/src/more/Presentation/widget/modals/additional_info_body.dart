import 'package:connect_me/app.dart';

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
  late ValueNotifier<TextEditingController> dobNotifier;
  late ValueNotifier<DateTime> dobDateTimeNotifier;
  late ValueNotifier<String?> countryNotifier;
  late ValueNotifier<String?> stateNotifier;
  late ValueNotifier<String?> cityNotifier;
  late ValueNotifier<String> placeOfBirthNotifier;
  late ValueNotifier<String> driverLicenseNoNotifier;
  late ValueNotifier<String> postalCodeNotifier;
  late ValueNotifier<String> streetNotifier;

  @override
  void initState() {
    dobNotifier = ValueNotifier<TextEditingController>(TextEditingController(
        text: dateFormatted2(widget.authUserModel.date?.toDate() ?? DateTime.now())));

    dobDateTimeNotifier =
        ValueNotifier<DateTime>(widget.authUserModel.date?.toDate() ?? DateTime.now());
    countryNotifier = ValueNotifier<String?>(widget.authUserModel.additionalDetails?.country);
    stateNotifier = ValueNotifier<String?>(widget.authUserModel.additionalDetails?.state);
    cityNotifier = ValueNotifier<String?>(widget.authUserModel.additionalDetails?.city);
    placeOfBirthNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.placeOfBirth ?? '');
    driverLicenseNoNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.driverLicenseNo ?? '');
    postalCodeNotifier =
        ValueNotifier<String>(widget.authUserModel.additionalDetails?.postalCode ?? '');
    streetNotifier = ValueNotifier<String>(widget.authUserModel.additionalDetails?.street ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addAdditionalDetailsProvider);
    ref.listen(addAdditionalDetailsProvider, (previous, next) {
      if (next.value != null && next.error == null) {
        pop(context);
        showScaffoldSnackBarMessage(
          TextConstant.successful,
          duration: 4,
        );
      }
    });
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
                labelMaterial: '${TextConstant.dateOfBirth} (*Visible to only you)',
                labelWidget: Text.rich(
                  TextSpan(
                    text: TextConstant.dateOfBirth,
                    children: [
                      TextSpan(
                        text: ' (Visible to only you)'.hardCodedString,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
                readOnly: true,
                onTap: () {
                  showCupertinoDateWidget(
                    context: context,
                    maxTime: DateTime(2017),
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
                flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
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
                    color: countryNotifier.value?.isEmpty == true || countryNotifier.value == null
                        ? context.colorScheme.error
                        : context.colorScheme.onBackground,
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
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    // var docId = const Uuid().v4();

                    MapDynamicString map = CreateFormMap.createDataMap(
                      controllersText: [
                        dateFormatted2(dobDateTimeNotifier.value),
                        placeOfBirthNotifier.value,
                        countryNotifier.value?.replaceAll(RegExp(r'\s(?=\w)'), '') ?? '',
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

                    ref
                        .read(addAdditionalDetailsProvider.notifier)
                        .addAdditionalDetails(map: map)
                        .whenComplete(
                          () => ref.invalidate(fetchProfileProvider),
                        );
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
