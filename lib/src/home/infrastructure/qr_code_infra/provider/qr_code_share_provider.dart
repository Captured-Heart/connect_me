import 'dart:async';

import 'package:connect_me/app.dart';

class QrCodeShareNotifier extends StateNotifier<QrCodeShareState> {
  QrCodeShareNotifier(this.qrCodeRepositoryImpl, this._analytics)
      : super(QrCodeShareState(isLoading: false));

  final QrCodeRepositoryImpl qrCodeRepositoryImpl;
  final AnalyticsRepositoryImpl _analytics;

  Future shareQrToOtherApps(GlobalKey<State<StatefulWidget>> globalKey,
      {required AuthUserModel authUserModel}) async {
    state = QrCodeShareState(isLoading: true, isCompleted: false);
    await Future.delayed(const Duration(milliseconds: 700));
    var result = await qrCodeRepositoryImpl.shareQrCodes(globalKey);
    state = result.fold(
      (error) => QrCodeShareState(
        errorMessage: error.message,
        isLoading: false,
        isCompleted: false,
      ),
      (successShare) {
        inspect(successShare);
        log('this is the share result: ${successShare.status}, share sucess index: ${successShare.raw}');
        unawaited(_analytics.shareQrCode(
          authUserModel: authUserModel,
          sharedDestination: successShare.raw,
        ));
        return QrCodeShareState(
          isCompleted: true,
          isLoading: false,
          // successMessage: successShare.status.name,
        );
      },
    );
  }
}

final qrcodeShareNotifierProvider =
    StateNotifierProvider<QrCodeShareNotifier, QrCodeShareState>((ref) {
  final qrCodeRepositoryImpl = ref.read(qrcodeRepositoryImplProvider);
  final analyticsImpl = ref.read(analyticsImplProvider);
  return QrCodeShareNotifier(qrCodeRepositoryImpl, analyticsImpl);
});
