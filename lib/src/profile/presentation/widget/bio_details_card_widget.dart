import 'package:connect_me/app.dart';

class BioDetailsWidget extends StatelessWidget {
  const BioDetailsWidget({
    super.key,
    required this.users,
  });

  final AuthUserModel? users;

  @override
  Widget build(BuildContext context) {
    var addInfo = users?.additionalDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(),
        AutoSizeText(
          TextConstant.bio,
          style: context.textTheme.bodyMedium,
          maxLines: 1,
        ),
        const Divider(),
        Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AdditionalInfoListTileWidget(
                    keys: TextConstant.country,
                    values: addInfo?.country ?? '',
                  ),
                  AdditionalInfoListTileWidget(
                    keys: TextConstant.state,
                    values: addInfo?.state ?? '',
                  ),
                  AdditionalInfoListTileWidget(
                    keys: TextConstant.city,
                    values: addInfo?.city ?? '',
                  ),
                  AdditionalInfoListTileWidget(
                    keys: TextConstant.street,
                    values: addInfo?.street ?? '',
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
                ],
              ),

              //! phone and email row
              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // mainAxisSize: MainAxisSize.min,

                children: [
                  users?.phone?.isEmpty == true || users?.phone == null
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: IconAndTextWidget(
                            text: '${users?.phonePrefix}-${users?.phone}',
                            iconData: Icons.call_outlined,
                            color: AppThemeColorDark.textButton,
                            onTap: () {
                              UrlOptions.makePhoneCall('${users?.phonePrefix}${users?.phone}');
                            },
                          ).padOnly(bottom: 10),
                        ),
                  users?.email?.isEmpty == true || users?.email == null
                      ? const SizedBox.shrink()
                      : Expanded(
                          child: IconAndTextWidget(
                            iconData: mailIcon,
                            text: '${users?.email}',
                            color: AppThemeColorDark.textButton,
                            onTap: () {
                              UrlOptions.sendEmail(users?.email ?? '');
                            },
                          ).padOnly(bottom: 10),
                        ),
                ],
              )
            ],
          ).padOnly(left: 12, right: 10, top: 10),
        ),
      ],
    );
  }
}
