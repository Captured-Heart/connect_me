import 'dart:developer';

import 'package:connect_me/app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(qrcodeShareNotifierProvider);
    log(isLoading.errorMessage ?? '');
    // shareQrCodeTemplate(context, globalKey: _globalKey);

    return FullScreenLoader(
      isLoading: isLoading.isLoading ?? false,
      child: Scaffold(
        appBar: const HomeScreenAppBar(
          hideTitle: true,
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: SpeedDial(
          icon: qrCodeIcon,
          overlayOpacity: 0.6,
          direction: SpeedDialDirection.up,
          children: [
            SpeedDialChild(
              child: const Icon(
                Bootstrap.camera,
                color: Colors.white,
              ),
              onTap: () {
                // scan qr scan
              },
              label: TextConstant.scanQr,
              backgroundColor: Colors.red,
            ),
            SpeedDialChild(
              child: const Icon(
                shareIcon,
                color: Colors.white,
              ),
              label: TextConstant.shareProfile,
              backgroundColor: Colors.blue,
              onTap: () {
                //share QR
                // showAwesomeQrDilaogs(
                //   context,
                //   globalKey: _globalKey,
                //   onShareQrcode: () {
                //     ref.read(qrcodeShareNotifierProvider.notifier).shareQrToOtherApps(_globalKey);
                //   },
                // );

                ref.read(qrcodeShareNotifierProvider.notifier).shareQrToOtherApps(_globalKey);
              },
            ),
          ],
          spacing: 10,
          mini: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: RepaintBoundary(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ProfilePicWidget(),
                  customListTileWidget(
                    context: context,
                    title: faker.person.name(),
                    subtitle: faker.person.name(),
                  ),
                  Visibility(
                    visible: isLoading.isLoading == true ? false : true,
                    child: ListTile(
                      title: const Text('Bio').padOnly(left: 20),
                      contentPadding: AppEdgeInsets.eH20,
                      subtitle: AutoSizeText(
                        faker.lorem.sentences(15).toString(),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ].columnInPadding(10),
              ),

              //
              Flexible(
                child: QrImageView(
                  data: '8y4328208928823894',
                  backgroundColor: context.colorScheme.onSurface,
                  eyeStyle:
                      QrEyeStyle(color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
                  dataModuleStyle: QrDataModuleStyle(
                    color: context.colorScheme.surface,
                    dataModuleShape: QrDataModuleShape.circle,
                  ),
                  version: 5,
                  size: context.sizeHeight(0.4),
                  gapless: false,
                  padding: const EdgeInsets.all(12),
                ).padSymmetric(horizontal: 5).padOnly(bottom: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
