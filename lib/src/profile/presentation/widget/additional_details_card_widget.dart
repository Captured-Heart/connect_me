import 'package:connect_me/app.dart';

class AdditionalDetailsCardWidget extends StatelessWidget {
  const AdditionalDetailsCardWidget({
    super.key,
    required this.addInfo,
  });

  final AdditionalDetailsModel? addInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(),
        const AutoSizeText(
          TextConstant.additionalDetails,
          maxLines: 1,
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addInfo?.country?.isEmpty == true
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdditionalInfoListTileWidget(
                          keys:
                              FirebaseDocsFieldEnums.country.name.toTitleCase(),
                          values: addInfo?.country ?? '',
                        ),
                        AdditionalInfoListTileWidget(
                          keys: FirebaseDocsFieldEnums.state.name.toTitleCase(),
                          values: addInfo?.state ?? '',
                        ),
                        AdditionalInfoListTileWidget(
                          keys: FirebaseDocsFieldEnums.city.name.toTitleCase(),
                          values: addInfo?.city ?? '',
                        ),
                      ].columnInPadding(3),
                    ).padOnly(top: 1),

              //! additional details  [DOB, PLACE, POSTAL CODE]
              Column(
                  children: [
                AdditionalInfoListTileWidget(
                  keys: TextConstant.dateOfBirth,
                  values: addInfo?.dateOfBirth ?? '',
                ),
                AdditionalInfoListTileWidget(
                  keys: TextConstant.placeOfBirth,
                  values: addInfo?.placeOfBirth ?? '',
                ),
                AdditionalInfoListTileWidget(
                  keys: TextConstant.postalCode,
                  values: addInfo?.postalCode ?? '',
                ),
                AdditionalInfoListTileWidget(
                  keys: TextConstant.driverLicenseNo,
                  values: addInfo?.driverLicenseNo ?? '',
                ),
              ].columnInPadding(3)),
            ],
          ).padAll(12),
        ),
      ],
    );
  }
}
