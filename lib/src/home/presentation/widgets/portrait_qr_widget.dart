import 'package:connect_me/app.dart';

class PortraitQrCodeWidget extends StatelessWidget {
  const PortraitQrCodeWidget({
    super.key,
    this.authUserModel,
  });
  final AuthUserModel? authUserModel;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      padding: EdgeInsets.zero,
      // mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: ProfilePicWidget(
            // authUserModel: data,
            isStaticTheme: true,
            height: 60,
            width: 60,
          ),
        ),
        const Center(
          child: CustomListTileWidget(
            title: 'CapturedHeart',
            subtitle: 'aeaefqafqwdwdfdqwfqwffq',
            subtitleTextAlign: TextAlign.start,
            showAtsign: true,
            isStaticTheme: true,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 3),
              child: QrImageView(
                data: 'data.docId!',

                backgroundColor: Colors.black,
                eyeStyle: const QrEyeStyle(
                  color: Colors.white,
                  eyeShape: QrEyeShape.square,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  // color: context.colorScheme.surface,
                  color: Colors.white,
                  dataModuleShape: QrDataModuleShape.circle,
                ),
                embeddedImage: const AssetImage(
                  'assets/images/aboutMeLogo_brown.png',
                ),
                embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(40, 40)),
                version: 5,
                size: context.sizeHeight(0.23),
                gapless: false,
                // padding: const EdgeInsets.all(12),
              ),
            ),
            AutoSizeText(
              'Scan QR code to connect',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.black,
              ),
              textScaleFactor: 0.8,
            )
          ],
        ),
      ],
    ).padAll(20);
  }
}
