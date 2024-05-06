import '../../../../app.dart';

class WorkDetailsCardWidget extends StatelessWidget {
  const WorkDetailsCardWidget({
    super.key,
    required this.workExperienceModel,
  });

  final List<WorkExperienceModel>? workExperienceModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        const Center(
          child: AutoSizeText(
            TextConstant.workExperience,
            maxLines: 1,
          ),
        ),
        const Divider(),
        SizedBox(
          height: 100,
          // width: 5,
          child: ListView.builder(
              itemCount: workExperienceModel?.length,
              shrinkWrap: true,
              physics:
                  workExperienceModel!.length < 2 ? const NeverScrollableScrollPhysics() : null,
              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var workExperience = workExperienceModel?[index];
                return SizedBox(
                  width: context.sizeWidth(workExperienceModel!.length < 2 ? 0.9 : 0.75),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AutoSizeText(
                              workExperience?.title?.toTitleCase() ?? '',
                              style: context.textTheme.bodyLarge,
                              textScaleFactor: 0.9,
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              '${workExperience?.companyName} ${TextConstant.bulletList} ${workExperience?.employmentType}',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(fontWeight: AppFontWeight.w600),
                              maxLines: 1,
                              textScaleFactor: 0.95,
                            ),

                            AutoSizeText(
                              '${workExperience?.location} - ${workExperience?.locationType}',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(fontWeight: AppFontWeight.w300),
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              '${workExperience?.startDate?.startMonthYearToString} - ${workExperience?.endDate?.endDateMonthYearToString}',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(fontWeight: AppFontWeight.w300),
                              textScaleFactor: 0.9,
                            ),

                            // AdditionalInfoListTileWidget(
                          ].columnInPadding(3),
                        ).padOnly(top: 4),
                      ],
                    ).padSymmetric(horizontal: 12),
                  ).padOnly(right: 5),
                );
              }),
        ),
      ],
    );
  }
}

class EdiucationDetailsCardWidget extends StatelessWidget {
  const EdiucationDetailsCardWidget({
    super.key,
    required this.educationModel,
  });

  final List<EducationModel>? educationModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        const Center(
          child: AutoSizeText(
            TextConstant.education,
            maxLines: 1,
          ),
        ),
        const Divider(),
        SizedBox(
          height: 115,
          // width: 5,
          child: ListView.builder(
              itemCount: educationModel?.length,
              shrinkWrap: true,
              physics: educationModel!.length < 2 ? const NeverScrollableScrollPhysics() : null,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var education = educationModel?[index];
                return SizedBox(
                  width: context.sizeWidth(educationModel!.length < 2 ? 0.9 : 0.75),
                  child: Card(
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //school
                                  AutoSizeText(
                                    education?.school?.toTitleCase() ?? '',
                                    style: context.textTheme.bodyLarge,
                                    textScaleFactor: 0.9,
                                    maxLines: 1,
                                  ),
                                  //degree
                                  AutoSizeText(
                                    ' ${TextConstant.bulletList} ${education?.degree}',
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(fontWeight: AppFontWeight.w600),
                                    maxLines: 1,
                                    textScaleFactor: 0.95,
                                  ),

                                  AutoSizeText(
                                    '${education?.startDate?.startMonthYearToString} - ${education?.endDate?.endDateMonthYearToString ?? ''}',
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(fontWeight: AppFontWeight.w300),
                                    textScaleFactor: 0.9,
                                  ),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButtonWithBorderAndArrowIcon(
                                      title: 'See more'.hardCodedString,
                                      padding: AppEdgeInsets.eA4,
                                      isDense: true,
                                      isArrowForward: true,
                                      onTap: () {
                                        WoltModalSheet.show(
                                          context: context,
                                          useSafeArea: false,
                                          pageListBuilder: (context) {
                                            return [
                                              WoltModalSheetPage(
                                                  isTopBarLayerAlwaysVisible: false,
                                                  navBarHeight: 10,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          //school
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.stretch,
                                                            children: [
                                                              AutoSizeText(
                                                                education?.school ?? '',
                                                                style: context.textTheme.bodyLarge,
                                                                textScaleFactor: 0.9,
                                                                maxLines: 1,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              //degree
                                                              AutoSizeText(
                                                                ' ${TextConstant.bulletList} ${education?.degree}',
                                                                style: context.textTheme.labelMedium
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            AppFontWeight.w600),
                                                                maxLines: 1,
                                                                textScaleFactor: 0.95,
                                                                textAlign: TextAlign.center,
                                                              ),

                                                              AutoSizeText(
                                                                '(${education?.startDate?.startMonthYearToString} - ${education?.endDate?.endDateMonthYearToString ?? ''})',
                                                                style: context.textTheme.labelMedium
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            AppFontWeight.w300),
                                                                textScaleFactor: 0.8,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ].columnInPadding(7),
                                                          ),

                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.stretch,
                                                            children: [
                                                              AdditionalInfoListTileWidget(
                                                                keys: TextConstant.grade,
                                                                values: education?.grade ?? '',
                                                              ),
                                                              AdditionalInfoListTileWidget(
                                                                keys: TextConstant.awardAndHonours,
                                                                values: education?.award ?? '',
                                                              ),
                                                              AdditionalInfoListTileWidget(
                                                                keys: TextConstant.activitiesAndOrg,
                                                                values: education?.activities ?? '',
                                                              ),
                                                            ].columnInPadding(4),
                                                          ).padOnly(left: 20),
                                                        ].columnInPadding(5),
                                                      ).padOnly(top: 3),
                                                    ],
                                                  ).padOnly(bottom: 10)),
                                            ];
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ].columnInPadding(5),
                              ).padOnly(top: 3),
                            ],
                          ).padSymmetric(horizontal: 10))
                      .padOnly(right: 5),
                );
              }),
        ),
      ],
    );
  }
}
