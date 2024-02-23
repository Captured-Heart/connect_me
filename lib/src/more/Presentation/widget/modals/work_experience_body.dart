import 'package:connect_me/app.dart';

class WorkExperienceBody extends ConsumerStatefulWidget {
  const WorkExperienceBody({
    super.key,
    required this.pageIndexNotifier,
    this.workExpModel,
  });
  final WorkExperienceModel? workExpModel;
  final ValueNotifier<int> pageIndexNotifier;
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

  late ValueNotifier<String> employmentTypeNotifier;
  late ValueNotifier<String> locationTypeNotifier;
  late ValueNotifier<String> titleNotifier;
  late ValueNotifier<String> companyNameNotifier;
  late ValueNotifier<String> locationNotifier;
  late ValueNotifier<TextEditingController> monthNotifier;
  late ValueNotifier<TextEditingController> yearNotifier;
  late ValueNotifier<TextEditingController> endMonthNotifier;
  late ValueNotifier<TextEditingController> endYearNotifier;
  final ValueNotifier<bool> isCurrentlyWorkingNotifier = ValueNotifier(true);

  @override
  void initState() {
    employmentTypeNotifier = ValueNotifier(widget.workExpModel?.employmentType ?? '');
    locationTypeNotifier = ValueNotifier(widget.workExpModel?.locationType ?? '');
    titleNotifier = ValueNotifier(widget.workExpModel?.title ?? '');
    companyNameNotifier = ValueNotifier(widget.workExpModel?.companyName ?? '');
    locationNotifier = ValueNotifier(widget.workExpModel?.location ?? '');
    monthNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.workExpModel?.startDate?.month));
    yearNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.workExpModel?.startDate?.year));
    endMonthNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.workExpModel?.endDate?.endMonth));
    endYearNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.workExpModel?.endDate?.endYear));
    super.initState();
  }

  @override
  void dispose() {
    employmentTypeNotifier.dispose();
    locationTypeNotifier.dispose();
    titleNotifier.dispose();
    companyNameNotifier.dispose();
    locationNotifier.dispose();
    monthNotifier.dispose();
    yearNotifier.dispose();
    endMonthNotifier.dispose();
    endYearNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addWorkExperienceProvider);
    ref.listen(addWorkExperienceProvider, (previous, next) {
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
                      '${TextConstant.employmentType}*',
                      style: context.textTheme.bodyMedium,
                      textScaleFactor: 0.9,
                    ),
                    MyCustomDropWidgetWithStrings(
                      items: employmentType,
                      initialItem: employmentTypeNotifier.value,
                      onChanged: (p0) {
                        employmentTypeNotifier.value = p0;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TextConstant.required;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ].columnInPadding(8),
                ),

                //! company name
                AuthTextFieldWidget(
                  // controller: controller.companyNameController,
                  initialValue: companyNameNotifier.value,
                  hintText: TextConstant.exGoogle,
                  label: '${TextConstant.companyName}*',
                  inputFormatters: const [],
                  onChanged: (value) {
                    companyNameNotifier.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return TextConstant.required;
                    } else {
                      return null;
                    }
                  },
                ),

                //! location
                AuthTextFieldWidget(
                  // controller: controller.locationController,
                  initialValue: locationNotifier.value,
                  hintText: TextConstant.exKadunaNigeria,
                  label: '${TextConstant.location}*',
                  inputFormatters: const [],
                  onChanged: (value) {
                    locationNotifier.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return TextConstant.required;
                    } else {
                      return null;
                    }
                  },
                ),

// location type
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
                      initialItem: locationTypeNotifier.value,
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
                      '${TextConstant.startDate}*',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return TextConstant.required;
                              } else {
                                return null;
                              }
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return TextConstant.required;
                              } else {
                                return null;
                              }
                            },
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
                                  validator: isCurrentlyWorkingNotifier.value == true
                                      ? null
                                      : (value) {
                                          if (value == null || value.isEmpty) {
                                            return TextConstant.required;
                                          } else {
                                            return null;
                                          }
                                        },
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
                                  validator: isCurrentlyWorkingNotifier.value == true
                                      ? null
                                      : (value) {
                                          if (value == null || value.isEmpty) {
                                            return TextConstant.required;
                                          } else {
                                            return null;
                                          }
                                        },
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
                              widget.workExpModel?.docId ?? docId,
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
                                .addWorkExperienceMethod(
                                    map: map, docId: widget.workExpModel?.docId ?? docId)
                                .whenComplete(
                              () {
                                ref.invalidate(fetchWorkListProvider(''));
                              },
                            );
                            if (widget.workExpModel == null || widget.workExpModel?.title == null) {
                              widget.pageIndexNotifier.value = widget.pageIndexNotifier.value - 2;
                            } else {
                              widget.pageIndexNotifier.value = widget.pageIndexNotifier.value - 1;
                            }
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
