import 'package:connect_me/app.dart';

class NewProfileScreen extends ConsumerWidget {
  const NewProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(fetchProfileProvider('')).valueOrNull;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.colorScheme.primaryContainer,
          title: const Text(TextConstant.profile),
          centerTitle: true,
          // bottom: const CustomTabBar2(
          //   tabs: [
          //     Text(TextConstant.about),
          //     Text(TextConstant.social),
          //     Text(TextConstant.work),
          //   ],
          // ),
        ),
        body: Column(
          children: [
            const CustomTabBar2(
              tabs: [
                Text(TextConstant.about),
                Text(TextConstant.education),
                Text(TextConstant.work),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // ! about
                  ListView(
                    children: [
                      CachedNetworkImageWidget(
                        imgUrl: users?.imgUrl,
                        height: context.sizeHeight(0.25),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...List.generate(
                            5,
                            (index) => ListTile(
                              dense: true,
                              title: Text('Name'),
                              subtitle: Text('${users?.fname} ${users?.lname}'),
                              shape: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.1),
                              ),
                            ),
                          ),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 20,
                              spacing: 10,
                              children: [
                                ...List.generate(
                                  8,
                                  (index) => GradientShortBTN(
                                    tooltip: 'tooltip',
                                    width: context.sizeWidth(0.17),
                                    height: context.sizeHeight(0.06),
                                    iconSize: 33,
                                    isWhiteGradient: context.isDarkMode,
                                    iconData: SocialDropdownEnum.facebook.icon,
                                    isThinBorder: true,
                                  ),
                                ),
                              ],
                            ).padSymmetric(horizontal: 10, vertical: 20),
                          ),
                        ],
                      )
                    ],
                  ),

                  //! EDUCATION
                  ListView(
                    padding: AppEdgeInsets.eA8,
                    children: [
                      ...List.generate(
                        3,
                        (index) {
                          String exam =
                              'okafor chiozoba, Magneus Okafor, Odogwu Malachi, Jabez Joseph';

                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      child: Text('${index + 1}'),
                                      radius: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              AutoSizeText(
                                                'Univeristy of Nigeria, Nsukka',
                                                style: context.textTheme.titleSmall,
                                              ),
                                              AutoSizeText(
                                                  'Bachelor\'s Degree . Electrical Engineering'),
                                              AutoSizeText('Apr 2017 - July 2022'),
                                              AutoSizeText('First Class Honours'),
                                            ].columnInPadding(3),
                                          ),

                                          // grades
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                title: Text(
                                                  TextConstant.awardAndHonours,
                                                  style: context.textTheme.titleSmall,
                                                ).padOnly(bottom: 3),
                                                subtitle: Text('okafor chiozoba'),
                                              ),
                                              ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                title: Text(
                                                  TextConstant.activitiesAndOrg,
                                                  style: context.textTheme.titleSmall,
                                                ).padOnly(bottom: 3),
                                                subtitle: Text(exam
                                                    .replaceAll(RegExp(r','), '\n')
                                                    .toTitleCase()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].rowInPadding(5),
                                ).padAll(10)
                              ],
                            ),
                          ).padSymmetric(vertical: 3);
                        },
                      )
                    ],
                  ),

                  //! WORK EXPERIENCE

                  ListView(
                    padding: AppEdgeInsets.eA8,
                    children: [
                      ...List.generate(
                        3,
                        (index) {
                          // String exam =
                          //     'okafor chiozoba, Magneus Okafor, Odogwu Malachi, Jabez Joseph';

                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      child: Text('${index + 1}'),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          'Software Developer',
                                          style: context.textTheme.titleSmall,
                                        ),
                                        AutoSizeText('Microsoft & sons Limited'),
                                        AutoSizeText('Full-time - Hybrid'),
                                        AutoSizeText('Apr 2017 - July 2022'),
                                      ],
                                    ).padSymmetric(horizontal: 5, vertical: 2)),
                                  ].rowInPadding(5),
                                ).padAll(10)
                              ],
                            ),
                          ).padSymmetric(vertical: 3);
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
