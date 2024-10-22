import 'dart:async';

import '../../../../../app.dart';

class QrCodeScanNotifier extends StateNotifier<QrCodeShareState> {
  QrCodeScanNotifier(this.qrScanRepository, this._analyticsRepositoryImpl)
      : super(const QrCodeShareState(isLoading: false));

  final QRScanRepository qrScanRepository;
  final AnalyticsRepository _analyticsRepositoryImpl;

  Future scanQrCodeMethod({
    required String scannedRawUUID,
    required WidgetRef ref,
  }) async {
    state = const QrCodeShareState(isLoading: true, isCompleted: false);
    await Future.delayed(const Duration(seconds: 1));
    var result = await qrScanRepository.scanQrCode(
      scannedRawUUID: scannedRawUUID,
      ref: ref,
    );
    state = result.fold(
      (error) => QrCodeShareState(
        errorMessage: error.message,
        isLoading: false,
        isCompleted: false,
      ),
      (contactProfile) {
        unawaited(
          _analyticsRepositoryImpl.scanQrCode(
            authUserModel: contactProfile ?? const AuthUserModel(),
          ),
        );
        return QrCodeShareState(
          isCompleted: true,
          isLoading: false,
          data: contactProfile,
          successMessage: TextConstant.successful,
        );
      },
    );
  }
}

final qrCodeScanNotifierProvider =
    StateNotifierProvider.autoDispose<QrCodeScanNotifier, QrCodeShareState>((ref) {
  final qrScanRepository = ref.read(qrScanRepositoryImplProvider);
  final analyticsImpl = ref.read(analyticsImplProvider);
  return QrCodeScanNotifier(qrScanRepository, analyticsImpl);
});
