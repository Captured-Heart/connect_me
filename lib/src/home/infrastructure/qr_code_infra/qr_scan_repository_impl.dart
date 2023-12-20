import 'dart:developer';

import 'package:connect_me/app.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

class QrCodeRepositoryImpl implements QrCodeRepository {
  @override
  Future<Either<AppException, ShareResult>> shareQrCodes(
      GlobalKey<State<StatefulWidget>> globalKey) async {
    try {
      RenderRepaintBoundary? boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

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
      );
      inspect(finalShareResults);
      return Right(finalShareResults);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}

final qrcodeRepositoryImplProvider = Provider<QrCodeRepositoryImpl>((ref) {
  return QrCodeRepositoryImpl();
});
