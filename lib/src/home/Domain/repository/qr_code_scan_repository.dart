
import '../../../../app.dart';

abstract class QrCodeRepository {
  Future<Either<AppException, ShareResult>> shareQrCodes({
    required String sharedText,
  });
}

abstract class QRScanRepository {
  Future<Either<AppException, AuthUserModel?>> scanQrCode({
    required String scannedRawUUID,
    required WidgetRef ref,
  });
}
