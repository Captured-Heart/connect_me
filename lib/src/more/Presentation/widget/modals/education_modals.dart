// EDUCATION MODEL
import 'package:connect_me/app.dart';

SliverWoltModalSheetPage educationModal(BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.education, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const EducationModalBody().padAll(15),
  );
}

class EducationModalBody extends ConsumerStatefulWidget {
  const EducationModalBody({
    super.key,
    this.educationModel,
  });
  final EducationModel? educationModel;
  @override
  ConsumerState<EducationModalBody> createState() => _EducationModalBodyState();
}

class _EducationModalBodyState extends ConsumerState<EducationModalBody> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  // final ValueNotifier<TextEditingController> monthNotifier =
  //     ValueNotifier<TextEditingController>(TextEditingController());
  // final ValueNotifier<TextEditingController> yearNotifier =
  //     ValueNotifier<TextEditingController>(TextEditingController());
  // final ValueNotifier<TextEditingController> endMonthNotifier =
  //     ValueNotifier<TextEditingController>(TextEditingController());
  // final ValueNotifier<TextEditingController> endYearNotifier =
  //     ValueNotifier<TextEditingController>(TextEditingController());

  // @override
  // void dispose() {
  //   monthNotifier.dispose();
  //   yearNotifier.dispose();
  //   endMonthNotifier.dispose();
  //   endYearNotifier.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<TextEditingController> monthNotifier =
        ValueNotifier<TextEditingController>(TextEditingController());
    final ValueNotifier<TextEditingController> yearNotifier =
        ValueNotifier<TextEditingController>(TextEditingController());
    final ValueNotifier<TextEditingController> endMonthNotifier =
        ValueNotifier<TextEditingController>(TextEditingController());
    final ValueNotifier<TextEditingController> endYearNotifier =
        ValueNotifier<TextEditingController>(TextEditingController());
    final ValueNotifier<String> schoolNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> degreeNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> activitiesNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> gradeNotifier = ValueNotifier<String>('');
    final ValueNotifier<String> awardNotifier = ValueNotifier<String>('');
    // final ValueNotifier<String> monthNotifier = ValueNotifier<String>('');
    // final ValueNotifier<String> yearNotifier = ValueNotifier<String>('');
    // final ValueNotifier<String> endMonthNotifier = ValueNotifier<String>('');
    // final ValueNotifier<String> endYearNotifier = ValueNotifier<String>('');

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTextFieldWidget(
                  initialValue: schoolNotifier.value,
                  inputFormatters: const [],
                  hintText: 'Ex: Univeristy of Nigeria',
                  label: 'School*',
                  onChanged: (value) {
                    schoolNotifier.value = value;
                  },
                ),
                AuthTextFieldWidget(
                  initialValue: degreeNotifier.value,
                  inputFormatters: const [],
                  hintText: 'Ex: Bachelor\'s, Phil of Doctor',
                  label: 'Degree*',
                  onChanged: (value) {
                    degreeNotifier.value = value;
                  },
                ),

                //! start date
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
                        hintText: TextConstant.month,
                        controller: monthNotifier.value,
                        // onChanged: (value) {
                        //   monthNotifier.value = value;
                        // },
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
                        // onChanged: (value) {
                        //   yearNotifier.value = value;
                        // },
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
                  '${TextConstant.endDate} (or Expected)',
                  maxLines: 1,
                  textScaleFactor: 0.9,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AuthTextFieldWidget(
                        // onChanged: (value) {
                        //   endMonthNotifier.value = value;
                        // },
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
                        // onChanged: (value) {
                        //   endMonthNotifier.value = value;
                        // },
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
                  label: 'Grade',
                  hintText: 'Ex: First Class Honours',
                  initialValue: gradeNotifier.value,
                ),

                //! awards/honour
                AuthTextFieldWidget(
                  label: 'Award/Honours',
                  initialValue: awardNotifier.value,
                  inputFormatters: const [],
                  maxLines: 3,
                  hintText: 'Ex: Distinction in Anatomy 2nd MBBS',
                  onChanged: (value) {
                    awardNotifier.value = value;
                  },
                ),

                //! activities/organizations
                AuthTextFieldWidget(
                  // controller: controller.activitiesController,
                  initialValue: activitiesNotifier.value,
                  label: 'Activities/Organizations',
                  inputFormatters: const [],
                  maxLines: 3,
                  hintText: 'Ex: Football(sports), Religious socieites etc',
                  onChanged: (value) {
                    activitiesNotifier.value = value;
                  },
                ),

                // ! Save btn
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      MapDynamicString map = CreateFormMap.createDataMap(
                        controllersText: [
                          schoolNotifier.value,
                          degreeNotifier.value,
                          monthNotifier.value.text,
                          yearNotifier.value.text,
                          endMonthNotifier.value.text,
                          endYearNotifier.value.text,
                          gradeNotifier.value,
                          awardNotifier.value,
                          activitiesNotifier.value,
                        ],
                        customKeys: // initiate my custom keys
                            [
                          FirebaseDocsFieldEnums.school.name,
                          FirebaseDocsFieldEnums.degree.name,
                          FirebaseDocsFieldEnums.month.name,
                          FirebaseDocsFieldEnums.year.name,
                          FirebaseDocsFieldEnums.endMonth.name,
                          FirebaseDocsFieldEnums.endYear.name,
                          FirebaseDocsFieldEnums.grade.name,
                          FirebaseDocsFieldEnums.award.name,
                          FirebaseDocsFieldEnums.activities.name,
                        ],
                      );

                      inspect(map);
                    },
                    child: const Text(TextConstant.save),
                  ),
                ),
              ].columnInPadding(15),
            ),
          );
        });
  }
}
