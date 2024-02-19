import 'package:connect_me/app.dart';

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
          height: 120,
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
                              workExperience?.title ?? '',
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
                          ].columnInPadding(5),
                        ).padOnly(top: 1),
                      ],
                    ).padAll(8),
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
          height: 106,
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
                              education?.school ?? '',
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
                            ),
                            // //
                            // AutoSizeText(
                            //   '${education?.startMonthYearToString} - ${workExperience?.endDateMonthYearToString}',
                            //   style: context.textTheme.labelMedium
                            //       ?.copyWith(fontWeight: AppFontWeight.w300),
                            //   textScaleFactor: 0.9,
                            // ),
                            // AdditionalInfoListTileWidget(
                          ].columnInPadding(5),
                        ).padOnly(top: 3),
                      ],
                    ).padAll(10),
                  ).padOnly(right: 5),
                );
              }),
        ),
      ],
    );
  }
}
