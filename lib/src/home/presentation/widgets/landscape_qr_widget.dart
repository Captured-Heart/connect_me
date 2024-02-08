import 'package:connect_me/app.dart';

class LandscapeQrCodeWIdget extends StatelessWidget {
  const LandscapeQrCodeWIdget({super.key, required this.authUserModel, s});
  final AuthUserModel? authUserModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfilePicWidget(
                isStaticTheme: true,
                height: 60,
                width: 60,
                authUserModel: authUserModel,
              ),
              CustomListTileWidget(
                title: authUserModel?.username ?? '',
                subtitle: authUserModel?.bio,
                subtitleTextAlign: TextAlign.start,
                showAtsign: true,
                isStaticTheme: true,
                subtitleMaxLines: 3,
              ),
            ].columnInPadding(10),
          ).padOnly(left: 10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomQrCodeImageWidget(
              authUserModel: authUserModel,
              isStaticTheme: true,
              isDense: true,
            ),
            AutoSizeText(
              TextConstant.scanQrCodeToConnect,
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.black,
              ),
              textScaleFactor: 0.8,
            ),
          ],
        ).padOnly(bottom: 7)
      ],
    );
  }
}
