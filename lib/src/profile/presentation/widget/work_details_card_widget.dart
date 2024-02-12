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
        // ...List.generate(
        //   workExperienceModel!.length,
        //   (index) {
        //     var workExperience = workExperienceModel?[index];

        //     return Card(
        //       elevation: 3,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               AdditionalInfoListTileWidget(
        //                 keys: TextConstant.companyName.toTitleCase(),
        //                 values: workExperience?.companyName ?? '',
        //               ),
        //               AdditionalInfoListTileWidget(
        //                 keys: TextConstant.employmentType.toTitleCase(),
        //                 values: workExperience?.employmentType ?? '',
        //               ),
        //               AdditionalInfoListTileWidget(
        //                 keys: TextConstant.location.toTitleCase(),
        //                 values: workExperience?.location ?? '',
        //               ),
        //             ].columnInPadding(3),
        //           ).padOnly(top: 1),

        //           //! additional details  [DOB, PLACE, POSTAL CODE]
        //           Column(
        //               children: [
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.dateOfBirth,
        //               values: workExperience?.formTitle ?? '',
        //             ),
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.placeOfBirth,
        //               values: workExperience?.location ?? '',
        //             ),
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.postalCode,
        //               values: workExperience?.locationType ?? '',
        //             ),
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.driverLicenseNo,
        //               values: workExperience?.location ?? '',
        //             ),
        //           ].columnInPadding(3)),
        //         ],
        //       ).padAll(12),
        //     ).padOnly(bottom: 5);
        //   },
        // ),
        SizedBox(
          height: 180,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.companyName.toTitleCase(),
                              values: workExperience?.companyName ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.employmentType.toTitleCase(),
                              values: workExperience?.employmentType ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.location.toTitleCase(),
                              values: workExperience?.location ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.dateOfBirth,
                              values: workExperience?.formTitle ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.placeOfBirth,
                              values: workExperience?.location ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.postalCode,
                              values: workExperience?.locationType ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.driverLicenseNo,
                              values: workExperience?.location ?? '',
                            ),
                          ].columnInPadding(5),
                        ).padOnly(top: 1),

                        //! additional details  [DOB, PLACE, POSTAL CODE]
                        // Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.dateOfBirth,
                        //         values: workExperience?.formTitle ?? '',
                        //       ),
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.placeOfBirth,
                        //         values: workExperience?.location ?? '',
                        //       ),
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.postalCode,
                        //         values: workExperience?.locationType ?? '',
                        //       ),
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.driverLicenseNo,
                        //         values: workExperience?.location ?? '',
                        //       ),
                        //     ].columnInPadding(5)),
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
        // ...List.generate(
        //   workExperienceModel!.length,
        //   (index) {
        //     var workExperience = workExperienceModel?[index];

        //     return Card(
        //       elevation: 3,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               AdditionalInfoListTileWidget(
        //                 keys: TextConstant.companyName.toTitleCase(),
        //                 values: workExperience?.companyName ?? '',
        //               ),
        //               AdditionalInfoListTileWidget(
        //                 keys: TextConstant.employmentType.toTitleCase(),
        //                 values: workExperience?.employmentType ?? '',
        //               ),
        //               AdditionalInfoListTileWidget(
        //                 keys: TextConstant.location.toTitleCase(),
        //                 values: workExperience?.location ?? '',
        //               ),
        //             ].columnInPadding(3),
        //           ).padOnly(top: 1),

        //           //! additional details  [DOB, PLACE, POSTAL CODE]
        //           Column(
        //               children: [
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.dateOfBirth,
        //               values: workExperience?.formTitle ?? '',
        //             ),
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.placeOfBirth,
        //               values: workExperience?.location ?? '',
        //             ),
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.postalCode,
        //               values: workExperience?.locationType ?? '',
        //             ),
        //             AdditionalInfoListTileWidget(
        //               keys: TextConstant.driverLicenseNo,
        //               values: workExperience?.location ?? '',
        //             ),
        //           ].columnInPadding(3)),
        //         ],
        //       ).padAll(12),
        //     ).padOnly(bottom: 5);
        //   },
        // ),
        SizedBox(
          height: 180,
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
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.school.toTitleCase(),
                              values: education?.school?.toTitleCase() ?? '',
                            ),
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.grade.toTitleCase(),
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
                            AdditionalInfoListTileWidget(
                              keys: TextConstant.degree,
                              values: education?.degree ?? '',
                            ),
                          ].columnInPadding(3),
                        ).padOnly(top: 1),

                        //! additional details  [DOB, PLACE, POSTAL CODE].
                        // Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.awardAndHonours,
                        //         values: education?.award ?? '',
                        //       ),
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.activitiesAndOrg,
                        //         values: education?.activities ?? '',
                        //       ),
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.degree,
                        //         values: education?.degree ?? '',
                        //       ),
                        //       AdditionalInfoListTileWidget(
                        //         keys: TextConstant.awardAndHonours,
                        //         values: education?.award ?? '',
                        //       ),
                        //     ].columnInPadding(3)),
                      ],
                    ).padAll(12),
                  ).padOnly(right: 5),
                );
              }),
        ),
      ],
    );
  }
}
