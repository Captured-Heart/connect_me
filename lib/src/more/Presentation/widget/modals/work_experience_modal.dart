// EDUCATION MODEL

import 'package:connect_me/app.dart';

//0113343316
SliverWoltModalSheetPage workExperienceModal(BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.workExperience, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const WorkExperienceBody().padAll(15),
  );
}

class WorkExperienceBody extends ConsumerStatefulWidget {
  const WorkExperienceBody({
    super.key,
  });

  @override
  ConsumerState<WorkExperienceBody> createState() => _WorkExperienceBodyState();
}

class _WorkExperienceBodyState extends ConsumerState<WorkExperienceBody> {
  final GlobalKey<FormState> workExperienceFormKey = GlobalKey<FormState>();

  final List<String> employmentType = [
    'Full-time',
    'Part-time',
    'Self-employed',
    'Freelance',
    'Contract',
    'Internship',
    'Apprenticeship',
    'Seasonal',
  ];

  final List<String> locationType = [
    'On-site',
    'Hybrid',
    'Remote',
  ];

  // final TextEditingControllerClass controller = TextEditingControllerClass();
  final ValueNotifier<bool> isCurrentlyWorkingNotifier = ValueNotifier(true);
  final ValueNotifier<String> employmentTypeNotifier = ValueNotifier('');
  final ValueNotifier<String> locationTypeNotifier = ValueNotifier('');
  final ValueNotifier<String> titleNotifier = ValueNotifier('');
  final ValueNotifier<String> companyNameNotifier = ValueNotifier('');
  final ValueNotifier<String> locationNotifier = ValueNotifier('');
  final ValueNotifier<TextEditingController> monthNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> yearNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> endMonthNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> endYearNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addWorkExperienceProvider);
    ref.listen(addWorkExperienceProvider, (previous, next) {
      if (next.asData?.hasValue == true && !next.hasError) {
        showScaffoldSnackBarMessage(
          'Successful'.hardCodedString,
          duration: 5,
        );
      }
    });
    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            isCurrentlyWorkingNotifier,
            monthNotifier,
            yearNotifier,
            endMonthNotifier,
            endYearNotifier,
            employmentTypeNotifier,
            locationTypeNotifier,
            titleNotifier,
            companyNameNotifier,
            locationNotifier,
          ],
        ),
        builder: (context, _) {
          return Form(
            key: workExperienceFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! title
                AuthTextFieldWidget(
                  // controller: controller.titleController,
                  initialValue: titleNotifier.value,
                  hintText: TextConstant.exSoftwareDeveloper,
                  label: '${TextConstant.title}*',
                  inputFormatters: const [],
                  onChanged: (value) {
                    titleNotifier.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return TextConstant.required;
                    } else {
                      return null;
                    }
                  },
                ),

                //! employment name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      TextConstant.employmentType,
                      style: context.textTheme.bodyMedium,
                      textScaleFactor: 0.9,
                    ),
                    MyCustomDropWidgetWithStrings(
                      items: employmentType,
                      onChanged: (p0) {
                        employmentTypeNotifier.value = p0;
                      },
                    ),
                  ].columnInPadding(8),
                ),

                //! company name
                AuthTextFieldWidget(
                  // controller: controller.companyNameController,
                  initialValue: companyNameNotifier.value,
                  hintText: TextConstant.exGoogle,
                  label: TextConstant.companyName,
                  inputFormatters: const [],
                  onChanged: (value) {
                    companyNameNotifier.value = value;
                  },
                ),

                //! location
                AuthTextFieldWidget(
                  // controller: controller.locationController,
                  initialValue: locationNotifier.value,
                  hintText: TextConstant.exKadunaNigeria,
                  label: TextConstant.location,
                  inputFormatters: const [],
                  onChanged: (value) {
                    locationNotifier.value = value;
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      TextConstant.locationType,
                      style: context.textTheme.bodyMedium,
                      textScaleFactor: 0.9,
                    ),
                    MyCustomDropWidgetWithStrings(
                      items: locationType,
                      onChanged: (p0) {
                        locationTypeNotifier.value = p0;
                      },
                    ),
                  ].columnInPadding(8),
                ),
                // check box of you currently working here
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox.adaptive(
                      value: isCurrentlyWorkingNotifier.value,
                      onChanged: (value) {
                        isCurrentlyWorkingNotifier.value = value!;
                      },
                    ),
                    const Expanded(
                        child: AutoSizeText(
                      TextConstant.iamCurrentlyInThisRole,
                      maxLines: 1,
                      minFontSize: 9,
                    ))
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //start date
                    const AutoSizeText(
                      TextConstant.startDate,
                      maxLines: 1,
                      textScaleFactor: 0.9,
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AuthTextFieldWidget(
                            controller: monthNotifier.value,
                            hintText: TextConstant.month,
                            readOnly: true,
                            onTap: () {
                              showCupertinoDateWidget(
                                context: context,
                                onConfirm: (date) {
                                  monthNotifier.value.text = dateFormattedToMonth(date);
                                  yearNotifier.value.text = dateFormattedToYear(date);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: AuthTextFieldWidget(
                            controller: yearNotifier.value,
                            hintText: TextConstant.year,
                            onTap: () {
                              showCupertinoDateWidget(
                                context: context,
                                onConfirm: (date) {
                                  monthNotifier.value.text = dateFormattedToMonth(date);
                                  yearNotifier.value.text = dateFormattedToYear(date);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ].columnInPadding(7),
                ),

                // END YEAR
                isCurrentlyWorkingNotifier.value == true
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            TextConstant.endDate,
                            maxLines: 1,
                            textScaleFactor: 0.9,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: AuthTextFieldWidget(
                                  controller: endMonthNotifier.value,
                                  hintText: TextConstant.month,
                                  readOnly: true,
                                  onTap: () {
                                    showCupertinoDateWidget(
                                      context: context,
                                      onConfirm: (date) {
                                        endMonthNotifier.value.text = dateFormattedToMonth(date);
                                        endYearNotifier.value.text = dateFormattedToYear(date);
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: AuthTextFieldWidget(
                                  controller: endYearNotifier.value,
                                  hintText: TextConstant.year,
                                  readOnly: true,
                                  onTap: () {
                                    showCupertinoDateWidget(
                                      context: context,
                                      onConfirm: (date) {
                                        endMonthNotifier.value.text = dateFormattedToMonth(date);
                                        endYearNotifier.value.text = dateFormattedToYear(date);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ].columnInPadding(7),
                      ),

                // SAVE BUTTON
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // to check the progress
                    infoState.value == null || infoState.hasError
                        ? const SizedBox.shrink()
                        : Text(
                            infoState.hasError
                                ? infoState.error.toString()
                                : infoState.valueOrNull.toString(),
                            style: AppTextStyle.bodyMedium.copyWith(
                                color: infoState.hasError
                                    ? Colors.red
                                    : AppThemeColorDark.successColor),
                          ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          var docId = const Uuid().v4();
                          Map<String, dynamic> startdate = {
                            FirebaseDocsFieldEnums.month.name: monthNotifier.value.text,
                            FirebaseDocsFieldEnums.year.name: yearNotifier.value.text,
                          };
                          Map<String, dynamic> endDate = {
                            FirebaseDocsFieldEnums.endMonth.name: endMonthNotifier.value.text,
                            FirebaseDocsFieldEnums.endYear.name: endYearNotifier.value.text,
                          };

                          MapDynamicString map = CreateFormMap.createDataMap(
                            controllersText: [
                              titleNotifier.value,
                              employmentTypeNotifier.value,
                              companyNameNotifier.value,
                              locationNotifier.value,
                              locationTypeNotifier.value,
                              // monthNotifier.value.text,
                              // yearNotifier.value.text,
                              startdate,
                              endDate,
                              // endMonthNotifier.value.text,
                              // endYearNotifier.value.text,
                              docId,
                              DateTime.now().toIso8601String(),
                            ],
                            customKeys: // initiate my custom keys
                                [
                              FirebaseDocsFieldEnums.title.name,
                              FirebaseDocsFieldEnums.employmentType.name,
                              FirebaseDocsFieldEnums.companyName.name,
                              FirebaseDocsFieldEnums.location.name,
                              FirebaseDocsFieldEnums.locationType.name,
                              FirebaseDocsFieldEnums.startDate.name,
                              // FirebaseDocsFieldEnums.year.name,
                              FirebaseDocsFieldEnums.endDate.name,
                              // FirebaseDocsFieldEnums.endYear.name,
                              FirebaseDocsFieldEnums.docId.name,
                              FirebaseDocsFieldEnums.createdAt.name,
                            ],
                          );
                          if (workExperienceFormKey.currentState!.validate()) {
                            ref
                                .read(addWorkExperienceProvider.notifier)
                                .addWorkExperienceMethod(map: map, docId: docId)
                                .whenComplete(() {
                              ref.invalidate(fetchProfileProvider);
                              pop(context);
                            });
                          }
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
                  ],
                ),
              ].columnInPadding(15),
            ),
          );
        });
  }
}
