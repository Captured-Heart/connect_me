import 'package:connect_me/app.dart';

class PortraitQrCodeWidget extends StatelessWidget {
  const PortraitQrCodeWidget({
    super.key,
    required this.authUserModel,
    this.isStaticTheme = true,
    this.isAfterScanDialog = false,
    this.viewFullProfileBTN,
  });
  final AuthUserModel? authUserModel;
  final bool isStaticTheme;
  final bool isAfterScanDialog;
  final VoidCallback? viewFullProfileBTN;
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
            title: authUserModel?.fullname ?? '',
            subtitle: authUserModel?.bio,
            subtitleTextAlign: TextAlign.center,
            showAtsign: false,
            isStaticTheme: isStaticTheme,
          ),
        ),
        isAfterScanDialog == true
            ? ElevatedButton(
                onPressed: viewFullProfileBTN,
                child: Text(
                  'View full profile'.hardCodedString,
                ),
              )
            : Column(
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
