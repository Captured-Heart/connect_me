import 'package:connect_me/app.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    // required this.controller,
  });

  // final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Consumer(builder: (context, ref, _) {
            return GradientShortBTN(
              iconData: logOutIcon,
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
                      ref.read(authNotifierProvider.notifier).logOutFromApp();
                    },
                  ),
                );
              },
            );
          }),
        ),
        //profile picture
        const Center(
          child: ProfilePicWidget(),
        ),
        customListTileWidget(
          context: context,
          title: faker.person.name(),
          subtitle: faker.person.name(),
        ),

        // stats for /// [following] [posts]
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            customListTileWidget(
              context: context,
              title: '15',
              subtitle: TextConstant.posts,
            ),
            customListTileWidget(
              context: context,
              title: '15',
              subtitle: TextConstant.followers,
            ),
            customListTileWidget(
              context: context,
              title: '15',
              subtitle: TextConstant.following,
            ),
          ],
        ),

        Row(
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
            ),
          ].rowInPadding(20),
        ),
      ].columnInPadding(13),
    ).padOnly(top: 20);
  }
}
