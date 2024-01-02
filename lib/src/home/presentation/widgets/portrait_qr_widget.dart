import 'package:connect_me/app.dart';

class PortraitQrCodeWidget extends StatelessWidget {
  const PortraitQrCodeWidget({
    super.key,
    required this.authUserModel,
  });
  final AuthUserModel authUserModel;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      padding: EdgeInsets.zero,
      // mainAxisSize: MainAxisSize.min,
      children: [
         Center(
          child: ProfilePicWidget(
            authUserModel: authUserModel,
            isStaticTheme: true,
            height: 60,
            width: 60,
          ),
        ),
        Center(
          child: CustomListTileWidget(
            title: authUserModel.username ?? '',
            subtitle: authUserModel.bio,
            subtitleTextAlign: TextAlign.center,
            showAtsign: true,
            isStaticTheme: true,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 15, right: 10, left: 10, bottom: 3),
              child: QrImageView(
                data: authUserModel.docId ?? '',

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
                embeddedImageStyle:
                    const QrEmbeddedImageStyle(size: Size(40, 40)),
                version: 5,
                size: context.sizeHeight(0.23),
                gapless: false,
                // padding: const EdgeInsets.all(12),
              ),
            ),
            AutoSizeText(
              TextConstant.scanQrCodeToConnect,
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
