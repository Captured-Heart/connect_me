import 'package:connect_me/app.dart';

class ProfileScreen1 extends ConsumerWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(ImagesConstant.qrCodeBG2), fit: BoxFit.cover),
            ),
          ),
          //
          Positioned(
            top: 50,
            width: context.sizeWidth(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const BackButton(
                  color: Colors.white,
                ),
                Text(
                  'Profile',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    backgroundColor: context.colorScheme.inversePrimary.withOpacity(0.4),
                    label: const Icon(shareIcon),
                    shape: const CircleBorder(),
                    side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.none,
                height: context.sizeHeight(0.67),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                    children: [
                       CustomListTileWidget(
                          title: 'Christabel Johnson',
                          subtitle: 'christabelmadu@gmail.com',
                        ).padSymmetric(vertical: 3),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(HeroIcons.pencil_square),
                          label: Text('Edit profile'),
                        ),
                      Card(
                          elevation: 3,
                          child: Text(
                            faker.lorem.sentences(10).toString(),
                          ).padAll(20)),
                      Card(
                        elevation: 3,
                        child: Text(
                          faker.lorem.sentences(10).toString(),
                        ).padAll(20),
                      ),
                      Card(
                        elevation: 3,
                        child: Text(
                          faker.lorem.sentences(10).toString(),
                        ).padAll(20),
                      ),
                    ].columnInPadding(8)),
              ),
              // Positioned(
              //     top: 100,
              //     width: context.sizeWidth(1),
              //     child: SingleChildScrollView(
              //       child: Column(
              //         // shrinkWrap: true,
              //         children: [
              //           Container(
              //             color: Colors.amber,
              //             width: context.sizeWidth(0.9),
              //             height: 400,
              //           ),
              //           Container(
              //             color: Colors.green,
              //             width: context.sizeWidth(0.9),
              //             height: 400,
              //           ),
              //           Container(
              //             color: Colors.pink,
              //             width: context.sizeWidth(0.9),
              //             height: 400,
              //           ),
              //         ],
              //       ).debugBorder(),
              //     )),
              Positioned(
                top: -70,
                left: context.sizeWidth(0.15),
                right: context.sizeWidth(0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.red,
                            image: const DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(ImagesConstant.darkBG),
                            ),
                            border:
                                Border.all(color: context.theme.scaffoldBackgroundColor, width: 2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
