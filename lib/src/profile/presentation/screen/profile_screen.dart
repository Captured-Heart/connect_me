import 'package:connect_me/app.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.implyLeading,
  });
  final bool? implyLeading;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    _scrollController.removeListener(() {});
    super.dispose();
  }

  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: context.sizeHeight(0.33),
                    collapsedHeight: kToolbarHeight,
                    automaticallyImplyLeading: offset < 238 ? widget.implyLeading ?? false : false,
                    forceMaterialTransparency: true,
                    floating: true,
                    pinned: true,
                    // snap: true,
                    // stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: const ProfileHeaderWidget().padSymmetric(horizontal: 20),
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
                  ),
                  AboutMeWidget(
                    offset: offset,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    super.key,
    this.offset = 0.0,
  });
  final double? offset;
  @override
  Widget build(BuildContext context) {
    return ListView(
        // controller: controller,
        padding: offset! > 230 ? const EdgeInsets.only(top: 70) : EdgeInsets.zero,
        children: [
          Card(
            elevation: 5,
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pushAsVoid(context, QrCodeScreen());
                        },
                        child: GradientShortBTN(
                          iconData: mailIcon,
                          iconSize: 21,
                        ),
                      ),
                      GradientShortBTN(
                        iconData: twitterIcon,
                        iconSize: 28,
                      ),
                      GradientShortBTN(
                        iconData: whatsappIcon,
                      ),
                      GradientShortBTN(
                        iconData: telegramIcon,
                      ),
                    ].rowInPadding(15),
                  ),
                ).padAll(10),
                Text(
                  faker.lorem.sentences(10).toString(),
                  textAlign: TextAlign.justify,
                  softWrap: true,
                )
              ],
            ).padOnly(
              left: 12,
              right: 12,
              bottom: 15,
            ),
          ),
          Card(
            elevation: 5,
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      GradientShortBTN(
                        iconData: mailIcon,
                        iconSize: 21,
                      ),
                      GradientShortBTN(
                        iconData: twitterIcon,
                        iconSize: 28,
                      ),
                      GradientShortBTN(
                        iconData: whatsappIcon,
                      ),
                      GradientShortBTN(
                        iconData: telegramIcon,
                      ),
                    ].rowInPadding(15),
                  ),
                ).padAll(10),
                Text(
                  faker.lorem.sentences(10).toString(),
                  textAlign: TextAlign.justify,
                  softWrap: true,
                )
              ],
            ).padOnly(
              left: 12,
              right: 12,
              bottom: 15,
            ),
          ),
        ].columnInPadding(7));
  }
}

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
        // const CustomTabBar(
        //   tabs: [
        //     Tab(
        //       text: TextConstant.posts,
        //     ),
        //     Tab(
        //       text: TextConstant.about,
        //     ),
        //   ],
        // ),
      ].columnInPadding(15),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
