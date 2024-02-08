import 'package:connect_me/app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> with SingleTickerProviderStateMixin {
  late TabController tabController;

  int _activeTabIndex = 0;
  void _setActiveTabIndex() {
    setState(() {
      _activeTabIndex = tabController.index;
    });
  }

  void _hideNavBar() {
    if (_activeTabIndex == 1) {
      ref.read(hideBottomNavBarProvider.notifier).update((state) => true);
    } else {
      ref.invalidate(hideBottomNavBarProvider);
    }
    // setState(() {});
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      _setActiveTabIndex();
      _hideNavBar();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_activeTabIndex == 1) {
    //   ref.read(hideBottomNavBarProvider.notifier).update((state) => true);
    // } else {
    //   ref.invalidate(hideBottomNavBarProvider);
    // }
    final AsyncValue<AuthUserModel> users = ref.watch(fetchProfileProvider.select((_) => _));
    // final work = ref.watch(fetchWorkProvider);
    log(_activeTabIndex.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        actions: [
          CircleChipButton(
            tooltip: 'Share QR code',
            onTap: () {
              if (users.valueOrNull != null) {
                pushAsVoid(
                  context,
                  ShareQrCodeScreen(
                    authUserModel: users.valueOrNull,
                  ),
                );
              } else {
                showScaffoldSnackBarMessageNoColor(
                  AuthErrors.networkFailure.errorMessage,
                  context: context,
                );
              }
            },
            iconData: shareIcon,
          ),
        ].rowInPadding(10),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomTabBar3(
              tabController: tabController,
              // onTap: (p0) {
              //   if (p0 == 1) {
              //     ref.read(hideBottomNavBarProvider.notifier).update((state) => true);
              //   } else {
              //     ref.invalidate(hideBottomNavBarProvider);
              //   }
              // },
              tabs: const [
                Text(TextConstant.home),
                Text(TextConstant.scanQr),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  users.when(
                    data: (data) {
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
                                title: '${data.fname} ${data.lname}',
                                // showAtsign: true,
                                subtitleMaxLines: 4,
                                subtitle: data.bio,
                                isSubtitleUrl: data.website,
                              ).padSymmetric(horizontal: 30),
                            ].columnInPadding(10),
                          ).padOnly(top: 10),
                          Flexible(
                            child: CustomQrCodeImageWidget(
                              authUserModel: data,
                              isStaticTheme: false,
                              isDense: false,
                            )

                                // Container(
                                //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                                //   decoration: BoxDecoration(
                                //       border: Border.all(
                                //           color: context.colorScheme.onBackground, width: 5)),
                                //   child: QrImageView(
                                //     data: data.docId ?? 'null',
                                //     backgroundColor: context.colorScheme.onSurface,
                                //     eyeStyle: QrEyeStyle(
                                //         color: context.colorScheme.surface,
                                //         eyeShape: QrEyeShape.square),
                                //     dataModuleStyle: QrDataModuleStyle(
                                //       color: context.colorScheme.surface,
                                //       dataModuleShape: QrDataModuleShape.circle,
                                //     ),
                                //     version: 5,
                                //     size: context.sizeHeight(0.3),
                                //     gapless: false,
                                //     // padding: const EdgeInsets.all(12),
                                .padSymmetric(horizontal: 5)
                                .padOnly(bottom: 0),
                            // ),
                          ),
                        ],
                      ).padOnly(top: 10);
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
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const ProfilePicWidget(),
                            const CustomListTileWidget(
                              title: 'Username',
                              showAtsign: true,
                              subtitle: 'Mobile/Product designer',
                            ),
                            Container(
                              margin: AppEdgeInsets.eA12,
                              height: context.sizeHeight(0.3),
                              width: context.sizeWidth(0.7),

                              // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                            ).padOnly(top: 15)
                          ],
                        ),
                      ),
                    ),
                  ),
                  // QrCodeScreen()
                  QrCodeScanScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
