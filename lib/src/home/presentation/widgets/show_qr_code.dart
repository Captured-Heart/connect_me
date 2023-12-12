import 'package:connect_me/app.dart';

Future<void> showAwesomeQrDilaogs(BuildContext context,
    {required VoidCallback onShareQrcode, required GlobalKey globalKey}) async {
  return AwesomeDialog(
    context: context,
    btnCancel: null,
    btnOk: null,
    // borderSide: BorderSide(color: context.colorScheme.onSurface, width: 0.4),
    customHeader: const ProfilePicWidget(
      withoutBorder: true,
    ),
    padding: const EdgeInsets.only(bottom: 20),
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
          eyeStyle: QrEyeStyle(color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
          dataModuleStyle: QrDataModuleStyle(
            color: context.colorScheme.surface,
            dataModuleShape: QrDataModuleShape.circle,
          ),
          version:
              // QrVersions.auto,

              3,
          size: 200,
          gapless: false,
          // embeddedImage: const CachedNetworkImageProvider(
          //   ImagesConstant.imgPlaceholderHttp,
          //   maxHeight: 40,
          //   maxWidth: 40,
          // ),
        ),
        SocialButtons(
          iconData: shareIcon,
          text: 'Share Qr Code',
          onTap: onShareQrcode,
        )
      ].columnInPadding(10),
    ),
    width: context.sizeWidth(1),
    animType: AnimType.leftSlide,
  ).show();
}

class ShareQrCodeTemplate extends StatelessWidget {
  const ShareQrCodeTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return AwesomeDialog(
          context: context,
          btnCancel: null,
          btnOk: null,
          // borderSide: BorderSide(color: context.colorScheme.onSurface, width: 0.4),
          customHeader: const ProfilePicWidget(
            withoutBorder: true,
          ),
          padding: const EdgeInsets.only(bottom: 20),
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
                eyeStyle:
                    QrEyeStyle(color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
                dataModuleStyle: QrDataModuleStyle(
                  color: context.colorScheme.surface,
                  dataModuleShape: QrDataModuleShape.circle,
                ),
                version:
                    // QrVersions.auto,

                    3,
                size: 200,
                gapless: false,
                // embeddedImage: const CachedNetworkImageProvider(
                //   ImagesConstant.imgPlaceholderHttp,
                //   maxHeight: 40,
                //   maxWidth: 40,
                // ),
              ),
            ].columnInPadding(10),
          ),
          width: context.sizeWidth(1),
          animType: AnimType.leftSlide,
        ).body ??
        const SizedBox.shrink();
  }
}

// Widget shareQrCodeTemplate(BuildContext context) {
//   return;
// }
