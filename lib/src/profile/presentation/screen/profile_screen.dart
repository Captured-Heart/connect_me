import 'package:connect_me/app.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({
    super.key,
    this.uuid,
  });

  final String? uuid;
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      offset = _scrollController.offset;
      setState(() {});
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(() {});
  //   super.dispose();
  // }

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
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
            length: 4,
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: context.sizeHeight(0.24),
                      collapsedHeight: kToolbarHeight,
                      automaticallyImplyLeading: offset < 140.0 ? true : false,
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
                      delegate: _SliverAppBarDelegate(
                        const CustomTabBar(
                          tabs: [
                            Tab(
                              icon: Icon(userProfileIcon),
                              iconMargin: EdgeInsets.zero,
                              text: TextConstant.about,
                            ),
                            Tab(
                              icon: Icon(educationCapIcon),
                              text: TextConstant.education,
                              iconMargin: EdgeInsets.zero,
                            ),
                            Tab(
                              icon: Icon(socialMediaIcon),
                              iconMargin: EdgeInsets.zero,
                              text: TextConstant.social,
                            ),
                            Tab(
                              icon: Icon(workExperienceIcon),
                              iconMargin: EdgeInsets.zero,
                              text: TextConstant.work,
                            ),
                          ],
                        ),
                      ),
                      pinned: offset > 238 ? true : false,
                      // pinned: false,
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
                    ).padSymmetric(horizontal: 15),
                    AboutMeWidget(
                      offset: offset,
                    ).padSymmetric(horizontal: 15),
                    AboutMeWidget(
                      offset: offset,
                    ).padSymmetric(horizontal: 15)
                  ],
                ).padOnly(top: 15))),
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
