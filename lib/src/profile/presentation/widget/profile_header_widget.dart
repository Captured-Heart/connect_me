import 'package:connect_me/app.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.users,
  });

  final AuthUserModel? users;
  @override
  Widget build(BuildContext context) {
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
                title: users?.fullname ?? '',
                // showAtsign: true,
                subtitleMaxLines: 3,
                subtitle: users?.bio,
                isSubtitleUrl: users?.website,
              ).padSymmetric(horizontal: 10),
            ].columnInPadding(5),
          ),
        ),
      ],
    );
  }
}

class ProfileScreenHeaderWidget extends ConsumerWidget {
  const ProfileScreenHeaderWidget({
    super.key,
    required this.users,
  });
  final AuthUserModel? users;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var socialCast = users?.socialMediaHandles;
    var socialIcons = socialCast?.keys.map((e) {
      if (socialCast.values.map((e) => e).toList().isNotEmpty == true) {
        return SocialDropdownEnum.values.firstWhere((element) => element.message == e);
      }
    }).toList();

    var socialIconMap = socialCast?.entries
        .where((element) => element.key.contains(SocialDropdownEnum.values
            .firstWhere((elemen) => elemen.message == element.key)
            .message))
        .toList();
    return Center(
      child: Column(
        children: [
          ProfilePicWidget(
            authUserModel: users,
          ),
          CustomListTileWidget(
            title: users?.fullname ?? '',
            showAtsign: false,
            subtitleMaxLines: 3,
            subtitle: users?.bio,
            isSubtitleUrl: users?.website,
          ).padSymmetric(horizontal: 10, vertical: 5),
          socialIcons == null || socialIcons.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 40,
                  // width: context.sizeWidth(1),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 5),
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
                          UrlOptions.launchWeb(link, launchModeEXT: true).onError(
                            (error, stackTrace) {
                              showScaffoldSnackBarMessage(error.toString(), isError: true);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
