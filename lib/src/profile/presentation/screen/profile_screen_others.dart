import 'package:connect_me/app.dart';

class ProfileScreenOthers extends ConsumerStatefulWidget {
  const ProfileScreenOthers({super.key, this.uuid, this.scanController});
  final String? uuid;
  final QRViewController? scanController;
  @override
  ConsumerState<ProfileScreenOthers> createState() =>
      _ProfileScreenOthersState();
}

class _ProfileScreenOthersState extends ConsumerState<ProfileScreenOthers> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      offset = _scrollController.offset;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    if (widget.scanController != null) {
      widget.scanController!.resumeCamera();
    }
    _scrollController.removeListener(() {});
    super.dispose();
  }

  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    ref.listen(authStateChangesProvider, (previous, next) {
      if (next.value?.uid == null) {
        // log('i popped off screen');
        pushReplacement(context, const LoginScreen());
      }
    });
    final users = ref.watch(fetchProfileProvider(widget.uuid ?? ''));
    // inspect(users);

    // inspect(users);
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: context.sizeHeight(0.31),
                    collapsedHeight: kToolbarHeight,
                    automaticallyImplyLeading: true,
                    forceMaterialTransparency: true,
                    floating: true,
                    pinned: true,
                    // snap: true,
                    // stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ProfileHeaderWidget(
                        users: users,
                      ).padSymmetric(horizontal: 20),
                      collapseMode: CollapseMode.parallax,
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(const CustomTabBar(
                      tabs: [
                        Tab(
                          text: TextConstant.posts,
                        ),
                        Tab(
                          text: TextConstant.about,
                        ),
                      ],
                    )),
                    pinned: offset > 238 ? true : false,
                    floating: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  AboutMeWidget(
                    offset: offset,
                  ).padSymmetric(horizontal: 15),
                  AboutMeWidget(
                    offset: offset,
                  ).padSymmetric(horizontal: 15)
                ],
              ),
            )),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height * 1.5;

  @override
  double get maxExtent => _tabBar.preferredSize.height * 1.5;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
