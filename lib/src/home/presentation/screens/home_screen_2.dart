import 'dart:async';
import 'dart:math' hide log;

import '../../../../app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({
    super.key,
    this.initialIndex,
  });
  final int? initialIndex;

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
    if (_activeTabIndex > 0) {
      ref.read(hideBottomNavBarProvider.notifier).update((state) => true);
    } else {
      ref.invalidate(hideBottomNavBarProvider);
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialIndex ?? 0);
    tabController.addListener(() {
      _setActiveTabIndex();
      _hideNavBar();
    });

    ref.read(fcmRepositoryImplProvider).getTokenAndSaveToken(
          uuid: SharedPreferencesHelper.getStringPref(SharedKeys.userUID.name) ?? '',
        );
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
    if (_activeTabIndex > 0) {
      setState(() {});
      _jumpToTab0();

      return false;
    }
    return false;
  }

  int percentageRate({required List<bool> progressBoolList}) {
    if (progressBoolList.contains(null) == true) {
      log('yes it contains null');
      return 400;
    } else {
      int trueCount = progressBoolList.where((element) => element == false).length;
      double progressPercentage = (trueCount / progressBoolList.length) * 100;
      return progressPercentage.round();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AuthUserModel> users = ref.watch(fetchProfileProvider.select((_) => _));
    final educationList = ref.watch(fetchEducationListProvider('')).valueOrNull;
    final workExpList = ref.watch(fetchWorkListProvider('')).valueOrNull;

    var progress = percentageRate(
      progressBoolList: [
        users.valueOrNull?.isAdditionalDetailsEmpty == null
            ? false
            : users.valueOrNull?.isAdditionalDetailsEmpty == true,
        users.valueOrNull?.isSocialMediaEmpty == null
            ? false
            : users.valueOrNull?.isSocialMediaEmpty == true,
        educationList?.isEmpty == null
            ? false
            : educationList?.isEmpty == true || educationList == null,
        workExpList?.isEmpty == null ? false : workExpList?.isEmpty == true || workExpList == null,
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          // toolbarHeight: kToolbarHeight * 1.5,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          centerTitle: true,
          title: progress > 99 || _activeTabIndex > 0
              ? const SizedBox.shrink()
              : completeYourProfileWidget(progress),
        ),
        body: SafeArea(
          child: Column(
            children: [
              //! custom tab bar
              CustomTabBar3(
                tabController: tabController,
                tabs: const [
                  AutoSizeText(
                    TextConstant.home,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    TextConstant.scanQr,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    TextConstant.shareQrCode,
                    maxLines: 1,
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    HomeScreenBodyWithQrCard(users: users),
                    QrCodeScanScreen(
                      tabController: tabController,
                    ),
                    ShareQrCodeScreen(
                      authUserModel: users.valueOrNull,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// complete your profile widget
  ValueListenableBuilder<Color> completeYourProfileWidget(int progress) {
    return ValueListenableBuilder(
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
            tooltip: 'complete your profile'.hardCodedString,
          );
        });
  }
}
