import 'package:connect_me/app.dart';

class EducationModalBody extends ConsumerStatefulWidget {
  const EducationModalBody({
    super.key,
    this.educationModel,
    required this.pageIndexNotifier,
  });
  final EducationModel? educationModel;
  final ValueNotifier<int> pageIndexNotifier;
  @override
  ConsumerState<EducationModalBody> createState() => _EducationModalBodyState();
}

class _EducationModalBodyState extends ConsumerState<EducationModalBody> {
  final GlobalKey<FormState> educationFormKey = GlobalKey<FormState>();
  // late ValueNotifier<TextEditingController> monthNotifier;
  //  late ValueNotifier<TextEditingController> yearNotifier;
  late ValueNotifier<String> schoolNotifier;
  late ValueNotifier<String> degreeNotifier;
  late ValueNotifier<TextEditingController> monthNotifier;
  late ValueNotifier<TextEditingController> yearNotifier;
  late ValueNotifier<TextEditingController> endMonthNotifier;
  late ValueNotifier<TextEditingController> endYearNotifier;
  late ValueNotifier<String> activitiesNotifier;
  late ValueNotifier<String> gradeNotifier;
  late ValueNotifier<String> awardNotifier;
  @override
  void initState() {
    schoolNotifier = ValueNotifier<String>(widget.educationModel?.school ?? '');
    degreeNotifier = ValueNotifier<String>(widget.educationModel?.degree ?? '');
    monthNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.educationModel?.startDate?.month));
    yearNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.educationModel?.startDate?.year));
    endMonthNotifier = ValueNotifier<TextEditingController>(
        TextEditingController(text: widget.educationModel?.endDate?.endMonth));
    endYearNotifier = ValueNotifier<TextEditingController>(
      TextEditingController(text: widget.educationModel?.endDate?.endYear),
    );

    activitiesNotifier = ValueNotifier<String>('');
    gradeNotifier = ValueNotifier<String>(widget.educationModel?.grade ?? '');
    awardNotifier = ValueNotifier<String>(widget.educationModel?.award ?? '');
    super.initState();
  }

  @override
  void dispose() {
    schoolNotifier.dispose();
    degreeNotifier.dispose();
    monthNotifier.dispose();
    yearNotifier.dispose();
    endMonthNotifier.dispose();
    endYearNotifier.dispose();
    activitiesNotifier.dispose();
    gradeNotifier.dispose();
    awardNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addEducationInfoProvider);
    ref.listen(addEducationInfoProvider, (previous, next) {
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
          schoolNotifier,
          degreeNotifier,
          activitiesNotifier,
          gradeNotifier,
          awardNotifier,
          monthNotifier,
          yearNotifier,
          endMonthNotifier,
          endYearNotifier,
        ],
      ),
      builder: (context, _) {
        return Form(
          key: educationFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //school
              AuthTextFieldWidget(
                initialValue: schoolNotifier.value,
                inputFormatters: const [],
                hintText: TextConstant.schoolHint,
                label: '${TextConstant.school}*',
                onChanged: (value) {
                  schoolNotifier.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return TextConstant.required;
                  } else {
                    return null;
                  }
                },
              ),

              //degree
              AuthTextFieldWidget(
                initialValue: degreeNotifier.value,
                inputFormatters: const [],
                hintText: TextConstant.degreeHint,
                label: '${TextConstant.degree}*',
                onChanged: (value) {
                  degreeNotifier.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return TextConstant.required;
                  } else {
                    return null;
                  }
                },
              ),

              //! start date
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
                      hintText: TextConstant.month,
                      controller: monthNotifier.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TextConstant.required;
                        } else {
                          return null;
                        }
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TextConstant.required;
                        } else {
                          return null;
                        }
                      },
                      controller: yearNotifier.value,
                      hintText: TextConstant.year,
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
                ],
              ),

              //! end date
              const AutoSizeText(
                '${TextConstant.endDate} (${TextConstant.or} ${TextConstant.expected})*',
                maxLines: 1,
                textScaleFactor: 0.9,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AuthTextFieldWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TextConstant.required;
                        } else {
                          return null;
                        }
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return TextConstant.required;
                        } else {
                          return null;
                        }
                      },
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

              // ! grade
              AuthTextFieldWidget(
                onChanged: (value) {
                  gradeNotifier.value = value;
                },
                inputFormatters: const [],
                label: TextConstant.grade,
                hintText: TextConstant.gradeHint,
                initialValue: gradeNotifier.value,
              ),

              //! awards/honour
              AuthTextFieldWidget(
                label: TextConstant.awardAndHonours,
                initialValue: awardNotifier.value,
                inputFormatters: const [],
                maxLines: 3,
                hintText: TextConstant.awardHint,
                onChanged: (value) {
                  awardNotifier.value = value;
                },
              ),

              //! activities/organizations
              AuthTextFieldWidget(
                // controller: controller.activitiesController,
                initialValue: activitiesNotifier.value,
                label: TextConstant.activitiesAndOrg,
                inputFormatters: const [],
                maxLines: 3,
                hintText: TextConstant.activitiesHint,
                onChanged: (value) {
                  activitiesNotifier.value = value;
                },
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
              // ! Save btn
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
                        schoolNotifier.value,
                        degreeNotifier.value,
                        // monthNotifier.value.text,
                        // yearNotifier.value.text,
                        startdate,
                        // endMonthNotifier.value.text,
                        // endYearNotifier.value.text,
                        endDate,
                        gradeNotifier.value,
                        awardNotifier.value,
                        activitiesNotifier.value,
                        widget.educationModel?.docId ?? docId,
                        DateTime.now().toIso8601String(),
                      ],
                      customKeys: // initiate my custom keys
                          [
                        FirebaseDocsFieldEnums.school.name,
                        FirebaseDocsFieldEnums.degree.name,
                        // FirebaseDocsFieldEnums.month.name,
                        // FirebaseDocsFieldEnums.year.name,
                        FirebaseDocsFieldEnums.startDate.name,
                        // FirebaseDocsFieldEnums.endMonth.name,
                        // FirebaseDocsFieldEnums.endYear.name,
                        FirebaseDocsFieldEnums.endDate.name,
                        FirebaseDocsFieldEnums.grade.name,
                        FirebaseDocsFieldEnums.award.name,
                        FirebaseDocsFieldEnums.activities.name,
                        FirebaseDocsFieldEnums.docId.name,
                        FirebaseDocsFieldEnums.createdAt.name,
                      ],
                    );
                    inspect(map);
                    if (educationFormKey.currentState!.validate()) {
                      ref
                          .read(addEducationInfoProvider.notifier)
                          .addEducationInfoMethod(
                              map: map, docId: widget.educationModel?.docId ?? docId)
                          .whenComplete(
                        () {
                          ref.invalidate(fetchEducationListProvider(''));
                        },
                      );
                      if (widget.educationModel == null || widget.educationModel?.school == null) {
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
            ].columnInPadding(15),
          ),
        );
      },
    );
  }
}
