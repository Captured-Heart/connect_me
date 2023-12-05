import 'package:connect_me/app.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // FLOATING ACTION BUTTON
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: SpeedDial(
        icon: qrCodeIcon,
        overlayOpacity: 0.6,
        children: [
          SpeedDialChild(
            child: const Icon(
              qrCodeIcon,
              color: Colors.white,
            ),
            label: TextConstant.displayMyQrCode,
            backgroundColor: Colors.blue,
            onTap: () {
              showAwesomeQrDilaogs(context);
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Bootstrap.camera,
              color: Colors.white,
            ),
            label: TextConstant.scanQr,
            backgroundColor: Colors.red,
          )
        ],
        spacing: 10,
        mini: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // APPBAR
      appBar: const HomeScreenAppBar(),
      body: ListView(
        padding: AppEdgeInsets.eH12,
        controller: scrollController,
        // shrinkWrap: true,
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: 10,
              padding: AppEdgeInsets.eA12,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return StatusView(
                  centerImageUrl: ImagesConstant.imgPlaceholderHttp,
                  radius: 35,
                  spacing: 15,
                  numberOfStatus: 3,
                  unSeenColor: context.theme.primaryColor,
                  seenColor: context.theme.highlightColor,
                ).padOnly(right: 20);
              },
            ),
          ),
          // Text(faker.lorem.sentence()),
          Column(
            children: List.generate(
              10,
              (index) => Card(
                elevation: 5,
                // color: context.theme.primaryColor.withOpacity(0.3),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: circleCacheNetworkImage(
                          height: 40,
                          width: 40,
                          imgUrl: ImagesConstant.imgPlaceholderHttp,
                        ),
                      ),
                      title: Text(
                        faker.person.firstName(),
                      ),
                      subtitle: Text(
                        faker.address.person.name(),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: cachedNetworkImageWidget(
                        imgUrl: ImagesConstant.imgPlaceholderHttp,
                        height: context.sizeHeight(0.25),
                      ),
                    ).padOnly(
                      left: 4,
                      right: 4,
                      bottom: 14,
                    ),
                  ],
                ),
              ).padOnly(bottom: 8),
            ),
          )
        ],
      ),
    );
  }
}
