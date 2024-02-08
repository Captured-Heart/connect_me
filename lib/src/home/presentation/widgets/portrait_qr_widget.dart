import 'package:connect_me/app.dart';

class PortraitQrCodeWidget extends StatelessWidget {
  const PortraitQrCodeWidget({
    super.key,
    required this.authUserModel,
    this.isStaticTheme = true,
  });
  final AuthUserModel? authUserModel;
  final bool isStaticTheme;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
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
            title: authUserModel?.username ?? '',
            subtitle: authUserModel?.bio,
            subtitleTextAlign: TextAlign.center,
            showAtsign: true,
            isStaticTheme: isStaticTheme,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomQrCodeImageWidget(
              authUserModel: authUserModel,
              isStaticTheme: isStaticTheme,
              isDense: true,
            ),
            AutoSizeText(
              TextConstant.scanQrCodeToConnect,
              style: context.textTheme.bodySmall?.copyWith(
                color: isStaticTheme == true ? Colors.black : context.colorScheme.onSurface,
              ),
              textScaleFactor: 0.8,
            )
          ],
        ),
      ],
    ).padAll(20);
  }
}

class CustomQrCodeImageWidget extends StatelessWidget {
  const CustomQrCodeImageWidget({
    super.key,
    required this.authUserModel,
    required this.isStaticTheme,
    this.isDense = false,
  });

  final AuthUserModel? authUserModel;
  final bool isStaticTheme;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isDense == true
          ? const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 3)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(
          vertical: isDense == true ? 3 : 5, horizontal: isDense == true ? 3 : 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: isStaticTheme == true ? Colors.black : context.colorScheme.onBackground,
          width: isDense == true ? 3 : 7,
        ),
      ),
      child: QrImageView(
        data: authUserModel?.docId ?? '',

        backgroundColor: isStaticTheme == true ? Colors.black : context.colorScheme.onSurface,
        eyeStyle: QrEyeStyle(
          color: isStaticTheme == true ? Colors.white : context.colorScheme.surface,
          eyeShape: QrEyeShape.square,
        ),
        dataModuleStyle: QrDataModuleStyle(
          color: isStaticTheme == true ? Colors.white : context.colorScheme.surface,
          dataModuleShape: QrDataModuleShape.circle,
        ),
        embeddedImage: const AssetImage(
          'assets/images/aboutMeLogo_brown.png',
        ),
        embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(40, 40)),
        version: 5,
        size: context.sizeHeight(isDense == true ? 0.2 : 0.3),
        gapless: false,
        // padding: const EdgeInsets.all(12),
      ),
    );
  }
}
