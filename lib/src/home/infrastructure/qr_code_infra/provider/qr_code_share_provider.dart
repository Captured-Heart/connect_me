import 'package:connect_me/app.dart';

class QrCodeShareNotifier extends StateNotifier<QrCodeShareState> {
  QrCodeShareNotifier(this.qrCodeRepositoryImpl)
      : super(QrCodeShareState(isLoading: false));

  final QrCodeRepositoryImpl qrCodeRepositoryImpl;

  Future shareQrToOtherApps(GlobalKey<State<StatefulWidget>> globalKey) async {
    state = QrCodeShareState(isLoading: true, isCompleted: false);
    await Future.delayed(const Duration(seconds: 1));
    var result = await qrCodeRepositoryImpl.shareQrCodes(globalKey);
    state = result.fold(
      (error) => QrCodeShareState(
        errorMessage: error.message,
        isLoading: false,
        isCompleted: false,
      ),
      (successShare) => QrCodeShareState(
        isCompleted: true,
        isLoading: false,
        // successMessage: successShare.status.name,
      ),
    );
  }
}

final qrcodeShareNotifierProvider =
    StateNotifierProvider<QrCodeShareNotifier, QrCodeShareState>((ref) {
  final qrCodeRepositoryImpl = ref.read(qrcodeRepositoryImplProvider);
  return QrCodeShareNotifier(qrCodeRepositoryImpl);
});
