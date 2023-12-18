import 'package:connect_me/app.dart';

class ShareQrCodeScreen extends ConsumerWidget {
  const ShareQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: context.theme.scaffoldBackgroundColor,
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      // ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/qrcode_BG3.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Center(
                child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfilePicWidget(
                            // authUserModel: data,
                            ),
                        CustomListTileWidget(
                          title: 'CapturedHeart',
                          subtitle: 'aeaefqafqwdwdfdqwfqwffq',
                          subtitleTextAlign: TextAlign.start,
                          showAtsign: true,
                        ),
                        Container(
                          margin: AppEdgeInsets.eA12,
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                          decoration: BoxDecoration(
                            gradient: whiteGradient(context: context),
                          ),
                          child: QrImageView(
                            data: 'data.docId!',
                            // backgroundColor: context.colorScheme.onSurface,
                            backgroundColor: Colors.black,
                            eyeStyle: QrEyeStyle(
                              // color: context.colorScheme.surface,
                              color: Colors.white,
                              eyeShape: QrEyeShape.square,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              // color: context.colorScheme.surface,
                              color: Colors.white,
                              dataModuleShape: QrDataModuleShape.circle,
                            ),
                            embeddedImage: AssetImage('assets/images/aboutMeLogo_brown.png',),
                            embeddedImageStyle: QrEmbeddedImageStyle(size: Size(65, 60)),
                            version: 5,
                            size: context.sizeHeight(0.3),
                            gapless: false,
                            // padding: const EdgeInsets.all(12),
                          ).padSymmetric(horizontal: 5).padOnly(bottom: 0),
                        ),
                      ],
                    ).padAll(15)),
              ),
            ).debugBorder(),
          ),
          Expanded(
            child: Container().debugBorder(color: Colors.green),
          ),
        ],
      ),
    );
  }
}
