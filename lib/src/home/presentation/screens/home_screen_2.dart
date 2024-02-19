import 'dart:async';
import 'dart:math' hide log;

import 'package:connect_me/app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> with SingleTickerProviderStateMixin {
  late TabController tabController;
  Timer? _timer;

  int _activeTabIndex = 0;
  void _setActiveTabIndex() {
    setState(() {
      _activeTabIndex = tabController.index;
    });
  }

  void _jumpToTab0() {
    setState(() {
      tabController.animateTo(0);
    });
  }

  void _hideNavBar() {
    if (_activeTabIndex == 1) {
      ref.read(hideBottomNavBarProvider.notifier).update((state) => true);
    } else {
      ref.invalidate(hideBottomNavBarProvider);
    }
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
    _timer?.cancel();
    super.dispose();
  }

  ValueNotifier<Color> warningColor = ValueNotifier(AppThemeColorLight.yellow);

  List<Color> warningColorList = [
    AppThemeColorLight.orange,
    AppThemeColorDark.textError,
  ];
  Future<bool> onWillPop() async {
    if (_activeTabIndex == 1) {
      setState(() {});
      _jumpToTab0();

      return false;
    }
    return false;
  }

  int percentageRate({required List<bool> progressBoolList}) {
    int trueCount = progressBoolList.where((element) => element == false).length;
    double progressPercentage = (trueCount / progressBoolList.length) * 100;
    return progressPercentage.round();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AuthUserModel> users = ref.watch(fetchProfileProvider.select((_) => _));
    final educationList = ref.watch(fetchEducationListProvider('')).valueOrNull;
    final workExpList = ref.watch(fetchWorkListProvider('')).valueOrNull;
    var progress = percentageRate(
      progressBoolList: [
        users.valueOrNull?.isAdditionalDetailsEmpty == true,
        users.valueOrNull?.isSocialMediaEmpty == true,
        educationList?.isEmpty == true || educationList == null,
        workExpList?.isEmpty == true || workExpList == null,
      ],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(const Duration(milliseconds: 2000), () {
        if (!mounted) return;

        warningColor.value = warningColorList[Random().nextInt(warningColorList.length)];
      });
    });
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: _activeTabIndex == 1
            ? null
            : FloatingActionButton(
                tooltip: TextConstant.shareQrCode,
                backgroundColor: context.colorScheme.primaryContainer,
                child: const Icon(
                  shareIcon,
                  size: 25,
                ),
                onPressed: () {
                  if (users.valueOrNull != null) {
                    pushAsVoid(
                      context,
                      ShareQrCodeScreen(
                        authUserModel: users.valueOrNull,
                      ),
                    );
                  } else {
                    ref.read(fetchProfileProvider);
                    showScaffoldSnackBarMessageNoColor(
                      AuthErrors.networkFailure.errorMessage,
                      context: context,
                    );
                  }
                },
              ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: kToolbarHeight * 1.5,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          centerTitle: true,
          title: progress > 99 || _activeTabIndex == 1
              ? const SizedBox.shrink()
              : ValueListenableBuilder(
                  valueListenable: warningColor,
                  builder: (context, color, _) {
                    return CustomPaint(
                      painter: DottedBorderPainter(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            warningIcon,
                            color: color,
                            size: 20,
                          ),
                          Flexible(
                            child: AutoSizeText(
                              //todo: do the calculation for percentage
                              '${'Complete your profile'.hardCodedString} ($progress%)',
                              style: context.textTheme.bodySmall,
                              maxLines: 1,
                            ),
                          ),
                        ].rowInPadding(5),
                      ).padAll(7),
                    ).onTapWidget(
                      onTap: () {
                        ref.read(bottomNavBarIndexProvider.notifier).update((state) => 3);
                      },
                    );
                  }),
          actions: [
            Swing(
              infinite: true,
              duration: const Duration(seconds: 5),
              child: CircleChipButton(
                tooltip: 'Share QR code',
                padding: AppEdgeInsets.eA8,
                iconSize: 30,
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
            ),
          ].rowInPadding(10),
        ),
        body: SafeArea(
          child: Column(
            children: [
              CustomTabBar3(
                tabController: tabController,
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
                              ).padSymmetric(horizontal: 5).padOnly(bottom: 0),
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

                      //TODO: REDO THE LOADING SCREEN
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
                          ).padOnly(top: 20),
                        ),
                      ),
                    ),
                    // QrCodeScreen()
                    QrCodeScanScreen(
                      tabController: tabController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
