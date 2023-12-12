import 'package:connect_me/app.dart';

abstract class QrCodeRepository {
  Future<Either<AppException, ShareResult>> shareQrCodes(
      GlobalKey<State<StatefulWidget>> globalKey);
}
