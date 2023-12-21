// EDUCATION MODEL
import 'package:connect_me/app.dart';

SliverWoltModalSheetPage educationModal(
    BuildContext modalSheetContext, TextTheme textTheme) {
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

class EducationModalBody extends StatefulWidget {
  const EducationModalBody({
    super.key,
  });

  @override
  State<EducationModalBody> createState() => _EducationModalBodyState();
}

class _EducationModalBodyState extends State<EducationModalBody> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final ValueNotifier<TextEditingController> monthNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> yearNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> endMonthNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());
  final ValueNotifier<TextEditingController> endYearNotifier =
      ValueNotifier<TextEditingController>(TextEditingController());

  @override
  void dispose() {
    monthNotifier.dispose();
    yearNotifier.dispose();
    endMonthNotifier.dispose();
    endYearNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: Listenable.merge([]),
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTextFieldWidget(
                controller: controller.schoolController,
                inputFormatters: const [],
                hintText: 'Ex: Univeristy of Nigeria',
                label: 'School*',
              ),
              AuthTextFieldWidget(
                controller: controller.degreeController,
                inputFormatters: const [],
                hintText: 'Ex: Bachelor\'s, Phil of Doctor',
                label: 'Degree*',
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
                      controller: monthNotifier.value,
                      hintText: TextConstant.month,
                      readOnly: true,
                      onTap: () {
                        showCupertinoDateWidget(
                          context: context,
                          onConfirm: (date) {
                            monthNotifier.value.text =
                                dateFormattedToMonth(date);
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
                      readOnly: true,
                      onTap: () {
                        showCupertinoDateWidget(
                          context: context,
                          onConfirm: (date) {
                            monthNotifier.value.text =
                                dateFormattedToMonth(date);
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
                      controller: endMonthNotifier.value,
                      hintText: TextConstant.month,
                      readOnly: true,
                      onTap: () {
                        showCupertinoDateWidget(
                          context: context,
                          onConfirm: (date) {
                            endMonthNotifier.value.text =
                                dateFormattedToMonth(date);
                            endYearNotifier.value.text =
                                dateFormattedToYear(date);
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
                            endMonthNotifier.value.text =
                                dateFormattedToMonth(date);
                            endYearNotifier.value.text =
                                dateFormattedToYear(date);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

              // ! grade
              AuthTextFieldWidget(
                controller: controller.gradeController,
                inputFormatters: const [],
                label: 'Grade',
                hintText: 'Ex: First Class Honours',
              ),

              //! awards/honour
              AuthTextFieldWidget(
                controller: controller.awardsController,
                label: 'Award/Honours',
                inputFormatters: const [],
                maxLines: 3,
                hintText: 'Ex: Distinction in Anatomy 2nd MBBS',
              ),

              //! activities/organizations
              AuthTextFieldWidget(
                controller: controller.activitiesController,
                label: 'Activities/Organizations',
                inputFormatters: const [],
                maxLines: 3,
                hintText: 'Ex: Football(sports), Religious socieites etc',
              ),

              // ! Save btn
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TextConstant.save),
                ),
              ),
            ].columnInPadding(15),
          );
        });
  }
}
