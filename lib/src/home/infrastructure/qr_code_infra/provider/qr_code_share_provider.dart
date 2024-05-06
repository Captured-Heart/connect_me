import 'dart:async';

import 'package:connect_me/app.dart';

class QrCodeShareNotifier extends StateNotifier<QrCodeShareState> {
  QrCodeShareNotifier(this.qrCodeRepositoryImpl, this._analytics, this.fetchAppDataImpl)
      : super(QrCodeShareState(isLoading: false));

  final QrCodeRepository qrCodeRepositoryImpl;
  final AnalyticsRepositoryImpl _analytics;
  final FetchAppDataImpl fetchAppDataImpl;

  Future shareQrToOtherApps(
      // GlobalKey<State<StatefulWidget>> globalKey,
      {
    required AuthUserModel authUserModel,
  }) async {
    state = QrCodeShareState(isLoading: true, isCompleted: false);
    var fetchedData = await fetchAppDataImpl.fetchAppData();
    // await Future.delayed(const Duration(milliseconds: 700));
    var result = await qrCodeRepositoryImpl.shareQrCodes(
      // globalKey,
      sharedText:
          'To scan this Qr-Code, download the app on appstore: ${fetchedData.iosAppLink}, or on google playstore: ${fetchedData.androidAppLink} ',
    );
    state = result.fold(
      (error) => QrCodeShareState(
        errorMessage: error.message,
        isLoading: false,
        isCompleted: false,
      ),
      (successShare) {
        if (successShare.status == ShareResultStatus.success) {
          unawaited(
            _analytics.shareQrCode(
              authUserModel: authUserModel,
              sharedDestination: successShare.raw,
            ),
          );
        }
        return QrCodeShareState(
          isCompleted: true,
          isLoading: false,
          // successMessage: successShare.status.name,
        );
      },
    );
  }
}

final qrcodeShareNotifierProvider = StateNotifierProvider.family<QrCodeShareNotifier,
    QrCodeShareState, GlobalKey<State<StatefulWidget>>>((ref, globalKey) {
  final qrCodeRepositoryImpl = ref.read(qrcodeRepositoryImplProvider(globalKey));
  final analyticsImpl = ref.read(analyticsImplProvider);
  final fetchDataImpl = ref.read(fetchDataImplProvider);
  return QrCodeShareNotifier(qrCodeRepositoryImpl, analyticsImpl, fetchDataImpl);
});
