import 'package:connect_me/app.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.users,
  });

  final AuthUserModel? users;
  @override
  Widget build(BuildContext context) {
    var socialIcons = users?.socialMediaHandles?.keys.map((e) {
      if (users?.socialMediaHandles?.values.map((e) => e).toList().isNotEmpty == true) {
        return SocialDropdownEnum.values.firstWhere((element) => element.message == e);
      }
    }).toList();
    var socialIconMap = users?.socialMediaHandles?.entries
        .where((element) => element.key.contains(SocialDropdownEnum.values
            .firstWhere((elemen) => elemen.message == element.key)
            .message))
        .toList();

    return Column(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfilePicWidget(
                authUserModel: users,
              ),
              CustomListTileWidget(
                title: users?.username ?? '',
                // showAtsign: true,
                subtitleMaxLines: 5,
                subtitle: users?.bio,
                isSubtitleUrl: users?.website,
              ).padSymmetric(horizontal: 10),
              socialIcons == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 60,
                      // width: context.sizeWidth(1),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 4),
                        itemCount: socialIcons.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var icons = socialIconsSwitch(socialIcons[index]);
                          var link = socialIconMap?[index].value;

                          return CircleChipButton(
                            iconData: icons,
                            tooltip: socialIcons[index]?.message ?? '',
                            onTap: () {
                              log('the link clicked is $link');
                              UrlOptions.launchWeb(link).onError(
                                (error, stackTrace) {
                                  showScaffoldSnackBarMessage(error.toString(), isError: true);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
            ].columnInPadding(5),
          ),
        ),
      ],
    );
  }
}
