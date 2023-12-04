import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connect_me/app.dart';
import 'package:faker/faker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:status_view/status_view.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
              AwesomeDialog(
                context: context,
                btnCancel: null,
                btnOk: null,
                borderSide: BorderSide(color: context.colorScheme.onSurface, width: 0.4),
                customHeader: const ProfilePicWidget(
                  withoutBorder: true,
                ),
                padding: EdgeInsets.only(bottom: 20),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customListTileWidget(
                      context: context,
                      title: faker.person.name(),
                      subtitle: faker.person.name(),
                    ),
                    QrImageView(
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
                  ].columnInPadding(10),
                ),
                width: context.sizeWidth(1),
                animType: AnimType.leftSlide,
              ).show();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        centerTitle: true,

        // leading in appbar
        leading: GestureDetector(
          onTap: () {
            pushAsVoid(
              context,
              const ContactScreen(),
            );
          },
          child: Chip(
            label: Swing(
              infinite: true,
              duration: const Duration(seconds: 7),
              child: Image.asset(
                ImagesConstant.appLogoBrown,
                fit: BoxFit.contain,
                height: 35,
                width: 40,
                scale: 0.8,
                // height: 80,
              ),
            ),
            padding: const EdgeInsets.all(5),
            labelPadding: EdgeInsets.zero,
            shape: const CircleBorder(),
            side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          TextConstant.connect,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: AppFontWeight.w600,
          ),
        ),
        actions: [
          Chip(
            label: const Icon(notificationIcon),
            shape: const CircleBorder(),
            side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
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
