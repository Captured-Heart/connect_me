import 'dart:developer';

import 'package:connect_me/app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<AuthUserModel> users = ref.watch(fetchProfileProvider(''));

    return Scaffold(
        appBar: HomeScreenAppBar(
          hideTitle: true,
          authUserModel: users.valueOrNull,
        ),
        body: users.when(
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ProfilePicWidget(
                      authUserModel: data,
                      onTap: () {
                        pushAsVoid(
                          context,
                          const ProfileScreen(),
                        );
                      },
                    ),
                    CustomListTileWidget(
                      title: data.username ?? '',
                      showAtsign: true,
                      subtitle: data.bio,
                    ),
                    // data.bio?.isNotEmpty == true
                    //     ? ListTile(
                    //         title: const Text('Bio'),
                    //         contentPadding: AppEdgeInsets.eH20,
                    //         subtitle: AutoSizeText(
                    //           data.bio ?? '',
                    //           maxLines: 3,
                    //           textAlign: TextAlign.start,
                    //         ),
                    //       )
                    //     : const SizedBox.shrink()
                  ].columnInPadding(10),
                ),
                Flexible(
                  child: Container(
                    margin: AppEdgeInsets.eA12,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    decoration: BoxDecoration(
                      gradient: whiteGradient(context: context),
                    ),
                    child: QrImageView(
                      data: data.docId!,
                      backgroundColor: context.colorScheme.onSurface,
                      eyeStyle: QrEyeStyle(
                          color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
                      dataModuleStyle: QrDataModuleStyle(
                        color: context.colorScheme.surface,
                        dataModuleShape: QrDataModuleShape.circle,
                      ),
                      version: 5,
                      // size: context.sizeHeight(0.4),
                      gapless: false,
                      // padding: const EdgeInsets.all(12),
                    ).padSymmetric(horizontal: 5).padOnly(bottom: 0),
                  ),
                ),
              ],
            );
          },
          error: (error, _) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },

          // SHIMMER LOADER
          loading: () => ShimmerWidget(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const ProfilePicWidget(),
                const CustomListTileWidget(
                  title: 'Username',
                  showAtsign: true,
                ),
                Container(
                  margin: AppEdgeInsets.eA12,
                  height: context.sizeHeight(0.45),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white),
                    gradient: whiteGradient(context: context),
                  ),
                ).padOnly(top: 15)
              ],
            ),
          ),
        ));
  }
}
