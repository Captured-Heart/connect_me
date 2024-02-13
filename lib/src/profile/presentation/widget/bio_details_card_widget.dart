import 'package:connect_me/app.dart';

class BioDetailsWidget extends StatelessWidget {
  const BioDetailsWidget({
    super.key,
    required this.users,
  });

  final AuthUserModel? users;

  @override
  Widget build(BuildContext context) {
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
            children: [
              Text(
                users?.bio ?? '',
                textScaleFactor: 0.9,
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  users?.phone?.isEmpty == true || users?.phone == null
                      ? const SizedBox.shrink()
                      : IconAndTextWidget(
                          text: '${users?.phonePrefix}-${users?.phone}',
                          iconData: Icons.call_outlined,
                          color: AppThemeColorDark.textButton,
                          onTap: () {
                            UrlOptions.makePhoneCall(
                                '${users?.phonePrefix}${users?.phone}');
                          },
                        ).padAll(10),
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
                          ).padAll(10),
                        ),
                ],
              )
            ],
          ).padOnly(left: 10, right: 10, top: 10),
        ),
      ],
    );
  }
}
