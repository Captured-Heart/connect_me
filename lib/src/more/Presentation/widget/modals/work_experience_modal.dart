// EDUCATION MODEL
import 'dart:developer';

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

class WorkExperienceBody extends StatefulWidget {
  const WorkExperienceBody({
    super.key,
  });

  @override
  State<WorkExperienceBody> createState() => _WorkExperienceBodyState();
}

class _WorkExperienceBodyState extends State<WorkExperienceBody> {
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
  final ValueNotifier<bool> isCurrentlyWorkingNotifier = ValueNotifier(true);
  final ValueNotifier<String> employmentTypeNotifier = ValueNotifier('');
  final ValueNotifier<String> locationTypeNotifier = ValueNotifier('');

  final ValueNotifier<TextEditingController> monthNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> yearNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> endMonthNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> endYearNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());

  final TextEditingControllerClass controller = TextEditingControllerClass();
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! title
              AuthTextFieldWidget(
                controller: controller.titleController,
                hintText: TextConstant.exSoftwareDeveloper,
                label: '${TextConstant.title}*',
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
                controller: controller.companyNameController,
                hintText: TextConstant.exGoogle,
                label: TextConstant.companyName,
              ),

              //! location
              AuthTextFieldWidget(
                controller: controller.locationController,
                hintText: TextConstant.exKadunaNigeria,
                label: TextConstant.location,
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
                      ].columnInPadding(7)),
// SAVE BUTTON
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    inspect(
                      WorkExperienceModel(
                        title: controller.titleController.text,
                        employmentType: employmentTypeNotifier.value,
                        companyName: controller.companyNameController.text,
                        location: controller.locationController.text,
                        locationType: locationTypeNotifier.value,
                        startDate: StartDateModel(
                            month: monthNotifier.value.text, year: yearNotifier.value.text),
                        endDate: EndDateModel(
                            month: endMonthNotifier.value.text, year: endYearNotifier.value.text),
                        formTitle: TextConstant.workExperience,
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
