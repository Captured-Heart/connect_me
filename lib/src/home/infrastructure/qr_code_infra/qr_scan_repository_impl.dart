import 'package:connect_me/app.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

class QRScanRepositoryImpl implements QRScanRepository {
  @override
  Future<Either<AppException, AuthUserModel?>> scanQrCode({
    required String scannedRawUUID,
    required WidgetRef ref,
  }) async {
    try {
      final uuid = scannedRawUUID.toString().replaceAll(TextConstant.uuidPrefixTag, '').trim();
      log('the uuid passed in scan method: $uuid');
      // var contactProfile = ref.read(fetchOthersProfileProvider(uuid));
      final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
      var contactProfile = await fetchProfileRepoImpl.fetchProfile(uuid: uuid);

      return Right(contactProfile);
    } catch (e) {
      AppException(e.toString()).toString();

      return Left(AppException(e.toString()));
    }
  }
}

class QrCodeRepositoryImpl implements QrCodeRepository {
  final GlobalKey<State<StatefulWidget>> globalKey;

  QrCodeRepositoryImpl({
    required this.globalKey,
  });

  @override
  Future<Either<AppException, ShareResult>> shareQrCodes({
    required String sharedText,
  }) async {
    try {
      RenderRepaintBoundary? boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.5);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List? name = byteData?.buffer.asUint8List();
      // var directory = await getTemporaryDirectory();

      // log(directory.path.toString());
      var finalShareResults = await Share.shareXFiles(
        [
          XFile.fromData(
            name!,
            length: byteData?.lengthInBytes,
            // path: directory.path,
            // lastModified: DateTime.now(),
            name: 'image2.png',
            mimeType: 'image/png',
          ),
        ],
        text: sharedText,
      );
      inspect(finalShareResults);
      return Right(finalShareResults);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}

final qrcodeRepositoryImplProvider =
    Provider.family<QrCodeRepository, GlobalKey<State<StatefulWidget>>>((ref, globalKey) {
  return QrCodeRepositoryImpl(globalKey: globalKey);
});

final qrScanRepositoryImplProvider = Provider<QRScanRepository>((ref) {
  return QRScanRepositoryImpl();
});
