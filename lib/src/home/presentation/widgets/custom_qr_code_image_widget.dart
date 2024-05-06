

import '../../../../app.dart';

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
          ? const EdgeInsets.only(top: 7, right: 7, left: 7, bottom: 3)
          : 
          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.symmetric(
          vertical: isDense == true ? 3 : 5, horizontal: isDense == true ? 3 : 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: isStaticTheme == true ? Colors.black : context.colorScheme.onBackground,
          width: isDense == true ? 3 : 7,
        ),
      ),
      child: QrImageView(
        data: '${TextConstant.uuidPrefixTag}${authUserModel?.docId}',
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
        embeddedImageStyle:
            QrEmbeddedImageStyle(size: isDense == true ? const Size(30, 30) : const Size(40, 40)),
        version: authUserModel?.qrVersion ?? 8,
        size: context.sizeHeight(isDense == true ? 0.2 : 0.3),
        gapless: !isDense,
        // padding: const EdgeInsets.all(12),
      ),
    );
  }
}
