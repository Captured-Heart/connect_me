import 'dart:developer';

import 'package:connect_me/app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(qrcodeShareNotifierProvider);
    final users = ref.watch(fetchProfileProvider(''));

    return FullScreenLoader(
      isLoading: isLoading.isLoading ?? false,
      child: Scaffold(
          appBar: const HomeScreenAppBar(
            hideTitle: true,
            // onTap: () {
            //   ref.read(qrcodeShareNotifierProvider.notifier).shareQrToOtherApps(_globalKey);
            // },
          ),
          body: users.when(
            data: (data) {
              return RepaintBoundary(
                key: _globalKey,
                child: Column(
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
                                const ProfileScreen(
                                  implyLeading: true,
                                ));
                          },
                        ),
                        CustomListTileWidget(
                          title: data.username ?? '',
                          showAtsign: true,
                        ),
                        data.bio?.isNotEmpty == true
                            ? Visibility(
                                visible: isLoading.isLoading == true ? false : true,
                                child: ListTile(
                                  title: const Text('Bio').padOnly(left: 20),
                                  contentPadding: AppEdgeInsets.eH20,
                                  subtitle: AutoSizeText(
                                    faker.lorem.sentences(15).toString(),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
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
                ),
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
          )),
    );
  }
}
