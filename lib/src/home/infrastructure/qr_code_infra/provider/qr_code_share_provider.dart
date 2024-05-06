import 'dart:async';

import '../../../../../app.dart';


class QrCodeShareNotifier extends StateNotifier<QrCodeShareState> {
  QrCodeShareNotifier(this.qrCodeRepository, this._analytics, this.fetchAppData)
      : super(QrCodeShareState(isLoading: false));

  final QrCodeRepository qrCodeRepository;
  final AnalyticsRepository _analytics;
  final FetchAppDataRepository fetchAppData;

  Future shareQrToOtherApps(
      // GlobalKey<State<StatefulWidget>> globalKey,
      {
    required AuthUserModel authUserModel,
  }) async {
    state = QrCodeShareState(isLoading: true, isCompleted: false);
    var fetchedData = await fetchAppData.fetchAppData();
    // await Future.delayed(const Duration(milliseconds: 700));
    var result = await qrCodeRepository.shareQrCodes(
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
  final qrCodeRepository = ref.read(qrcodeRepositoryImplProvider(globalKey));
  final analyticsImpl = ref.read(analyticsImplProvider);
  final fetchDataImpl = ref.read(fetchDataImplProvider);
  return QrCodeShareNotifier(qrCodeRepository, analyticsImpl, fetchDataImpl);
});
