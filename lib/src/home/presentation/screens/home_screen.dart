import 'package:animate_do/animate_do.dart';
import 'package:connect_me/app.dart';
import 'package:faker/faker.dart';
import 'package:status_view/status_view.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogForQrCodes(
            context,
            title: null,
            content: SizedBox(
              width: 500,
              child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const ProfilePicWidget(
                                withoutBorder: true,
                              ),
                              customListTileWidget(
                                context: context,
                                title: faker.person.name(),
                                subtitle: faker.person.name(),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: QrImageView(
                            data: 'data is life forget it',
                            backgroundColor: context.colorScheme.onSurface,
                            eyeStyle: QrEyeStyle(
                                color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
                            dataModuleStyle: QrDataModuleStyle(
                                color: context.colorScheme.surface,
                                dataModuleShape: QrDataModuleShape.circle),
                            version:
                                // QrVersions.auto,

                                3,
                            size: 200,
                            gapless: false,
                          ),
                        )
                      ].columnInPadding(20))
                  .padAll(10),
            ),
          );
        },
        tooltip: TextConstant.addViaQr,
        child: const Icon(
          qrCodeIcon,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        centerTitle: true,
        leading: Chip(
          label: BounceInDown(
            from: 70,
            duration: Duration(seconds: 2),
            child: Image.asset(
              ImagesConstant.appLogoBrown,
              fit: BoxFit.contain,
              scale: 0.8,
              // height: 80,
            ),
          ),
          padding: EdgeInsets.all(2),
          labelPadding: EdgeInsets.zero,
          shape: CircleBorder(),
          side: BorderSide(width: 2),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          TextConstant.connect,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: AppFontWeight.w600,
          ),
        ),
        actions: const [
          Chip(
            label: Icon(notificationIcon),
            shape: CircleBorder(),
            side: BorderSide(width: 2),
          ),
        ],
      ),
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
          Text(faker.lorem.sentence()),
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
                      leading: circleCacheNetworkImage(
                        height: 40,
                        width: 40,
                        imgUrl: ImagesConstant.imgPlaceholderHttp,
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
