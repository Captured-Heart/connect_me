import 'package:connect_me/app.dart';

class EducationInfoSignUpScreen extends ConsumerStatefulWidget {
  const EducationInfoSignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EducationInfoSignUpScreenState();
}

class _EducationInfoSignUpScreenState extends ConsumerState<EducationInfoSignUpScreen> {
  //
  final GlobalKey<FormState> educationFormKey = GlobalKey<FormState>();
//
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
  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addEducationInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstant.education),
      ),
      body: SafeArea(
        child: ListenableBuilder(
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
            return FullScreenLoader(
              isLoading: infoState.isLoading,
              child: Form(
                key: educationFormKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: AppEdgeInsets.eA20,
                  children: [
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
                      '${TextConstant.endDate} (${TextConstant.or} ${TextConstant.expected})',
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

                    // ! Save btn
                    ElevatedButton(
                      onPressed: () {
                        var docId = const Uuid().v4();

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
                            docId,
                            DateTime.now().toIso8601String(),
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
                            FirebaseDocsFieldEnums.docId.name,
                            FirebaseDocsFieldEnums.createdAt.name,
                          ],
                        );

                        inspect(map);

                        log('''map : $map''');
                        if (educationFormKey.currentState!.validate()) {
                          ref
                              .read(addEducationInfoProvider.notifier)
                              .addEducationInfoMethod(map: map, docId: docId)
                              .whenComplete(
                                () => ref.invalidate(fetchEducationListProvider),
                              );
                        }
                      },
                      child: const Text(TextConstant.save),
                    ),
                  ].columnInPadding(15),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}