import 'package:connect_me/app.dart';
import 'package:faker/faker.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   bottom: PreferredSize(
        //     child: ProfileHeaderWidget().padSymmetric(horizontal: 20),
        //     preferredSize: Size.fromHeight(
        //       context.sizeHeight(0.4),
        //     ),
        //   ),
        // ),
        body: SafeArea(
            child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
                expandedHeight: context.sizeHeight(0.4),
                collapsedHeight: kToolbarHeight,
                automaticallyImplyLeading: false,
                forceMaterialTransparency: true,
                floating: false,
                pinned: true,
                // snap: true,
                // stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileHeaderWidget(
                    // controller: _scrollController,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                // ProfileHeaderWidget(controller: _scrollController,),
                bottom: CustomTabBar(
                  tabs: [
                    Tab(
                      text: TextConstant.posts,
                    ),
                    Tab(
                      text: TextConstant.about,
                    ),
                  ],
                ),
                ),
            SliverFillRemaining(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AboutMeWidget(
                    controller: _scrollController,
                  ),
                  AboutMeWidget(
                    controller: _scrollController,
                  ),
                ],
              ),
            )
          ],
        )

            //     Column(
            //   // shrinkWrap: true,
            //   children: [
            //     ProfileHeaderWidget(),
            //     SizedBox(
            //       height: context.sizeHeight(0.5),
            //       width: double.infinity,
            //       child: TabBarView(
            //         children: [
            //           AboutMeWidget(),
            //           AboutMeWidget(),
            //         ],
            //       ),
            //     ),
            //   ],
            // )

            //  TabBarView(
            //   children: [
            //     AboutMeWidget(),
            //     AboutMeWidget(),
            //   ],
            // ),
            ),
      ),
    );
  }
}

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    super.key,
    required this.controller,
  });
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListView(
        controller: controller,
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
            faker.lorem.sentences(100).toString(),
            textAlign: TextAlign.justify,
            softWrap: true,
          )
        ],
      ).padOnly(
        left: 12,
        right: 12,
        bottom: 15,
      ),
    );
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
      // controller: controller,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //profile picture
        Center(child: const ProfilePicWidget()),
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
