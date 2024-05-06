import '../../../../app.dart';

class HomeScreenBodyWithQrCard extends StatelessWidget {
  const HomeScreenBodyWithQrCard({
    super.key,
    required this.users,
  });
  final AsyncValue<AuthUserModel> users;
  @override
  Widget build(BuildContext context) {
    return users.when(
      data: (data) {
        if (data.docId == null) {
          return Center(
              child: const Text(
            'This account records does not exist in our Database. Please sign out and sign in again.',
            textAlign: TextAlign.center,
          ).padSymmetric(horizontal: 20));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: ProfilePicWidget(
                    authUserModel: data,
                    onTap: () {},
                  ),
                ),

                //bio
                CustomListTileWidget(
                  title: data.fullname,
                  // showAtsign: true,
                  subtitleMaxLines: 4,
                  subtitle: data.bio,
                  isSubtitleUrl: data.website,
                ).padSymmetric(horizontal: 30),
              ].columnInPadding(5),
            ).padOnly(top: 10),
            Flexible(
              child: CustomQrCodeImageWidget(
                authUserModel: data,
                isStaticTheme: false,
                isDense: false,
              ).padSymmetric(horizontal: 5),
            ),
          ],
        ).padOnly(top: 10);
      },
      error: (error, _) {
        return Center(
          child: Text('$error \nOoops! \nClose the app and start again'),
        );
      },

      // SHIMMER LOADER

      loading: () => ShimmerWidget(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const ProfilePicWidget(),
              SizedBox(
                width: context.sizeWidth(0.5),
                height: 12,
                child: const LinearProgressIndicator(),
              ).padSymmetric(vertical: 5),
              SizedBox(
                width: context.sizeWidth(0.7),
                height: 15,
                child: const LinearProgressIndicator(),
              ).padSymmetric(vertical: 5),
              ShimmerWidget(
                child: Container(
                  margin: AppEdgeInsets.eA12,
                  height: context.sizeHeight(0.3),
                  width: context.sizeWidth(0.7),
                  color: context.colorScheme.outline,
                  // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                ).padOnly(top: 15),
              )
            ],
          ).padOnly(top: 20),
        ),
      ),
    );
  }
}
