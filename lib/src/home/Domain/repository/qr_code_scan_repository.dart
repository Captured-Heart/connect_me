import 'package:connect_me/app.dart';

abstract class QrCodeRepository {
  Future<Either<AppException, ShareResult>> shareQrCodes(
      GlobalKey<State<StatefulWidget>> globalKey);

  Future<Either<AppException, AuthUserModel?>> scanQrCode({
    required String scannedRawUUID,
    required WidgetRef ref,
  });
}
