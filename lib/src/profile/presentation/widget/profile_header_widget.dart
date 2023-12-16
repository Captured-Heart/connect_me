import 'package:connect_me/app.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.users,
    this.isMyProfile = false,
  });

  final AsyncValue<AuthUserModel> users;
  final bool isMyProfile;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Consumer(builder: (context, ref, _) {
            return GradientShortBTN(
              iconData: logOutIcon,
              tooltip: TextConstant.logOut,
              iconSize: 18,
              width: 35,
              height: 35,
              onTap: () {
                warningDialogs(
                  context: context,
                  dialogModel: DialogModel(
                    title: 'Are you sure you want to log out?',
                    content: null,
                    onPostiveAction: () {
                      ref.read(logOutNotifierProvider.notifier).signOutUsers();
                    },
                  ),
                );
              },
            );
          }),
        ),

        // USERS DATA
        users.when(
          data: (data) {
            return Column(
              children: [
                //profile picture
                Column(
                    children: [
                  Center(
                    child: ProfilePicWidget(
                      authUserModel: data,
                    ),
                  ),
                  CustomListTileWidget(
                    title: data.username ?? '',
                    showAtsign: true,
                    // subtitle: faker.person.name(),
                  ),
                ].columnInPadding(5)),

                // stats for /// [following] [posts]
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomListTileWidget(
                      title: data.posts?.length.toString() ?? '0',
                      subtitle: TextConstant.posts,
                    ),
                    // CustomListTileWidget(
                    //   title: '15',
                    //   subtitle: TextConstant.followers,
                    // ),
                    CustomListTileWidget(
                      title: data.connects?.length.toString() ?? '0',
                      subtitle: TextConstant.connects,
                    ),
                  ],
                ),

                isMyProfile == true
                    ? const SizedBox.shrink()
                    : Row(
                        children: const [
                          Expanded(
                            child: GradientLongBTN(),
                          ),
                          GradientShortBTN(
                            isWhiteGradient: true,
                            isThinBorder: true,
                            height: 45,
                            iconData: chatIcon,
                            iconSize: 23,
                            tooltip: TextConstant.message,
                          ),
                        ].rowInPadding(20),
                      ),
              ].columnInPadding(16),
            );
          },
          error: (error, _) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ],
    ).padOnly(top: 20);
  }
}
