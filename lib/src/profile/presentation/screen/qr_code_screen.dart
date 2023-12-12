import 'dart:io';

import 'package:connect_me/app.dart';

class QrCodeScreen extends ConsumerStatefulWidget {
  const QrCodeScreen({super.key});

  @override
  ConsumerState<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends ConsumerState<QrCodeScreen> {
  QRViewController? controller;
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code screen tests'),
      ),
      body: Column(
        children: [
          QrImageView(
            data: 'data jfutukftkuyfyg ygluyigui',
            backgroundColor: context.colorScheme.onSurface,
            eyeStyle: QrEyeStyle(color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
            dataModuleStyle: QrDataModuleStyle(
                color: context.colorScheme.surface, dataModuleShape: QrDataModuleShape.circle),
            version: 3,
            size: 200,
            gapless: false,
          ),
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
              child: Center(
            child: (result != null)
                ? Text('Barcode Type: ${(result!.format)}   Data: ${result!.code}')
                : Text('Scan a code'),
          ))
        ],
      ),
    );
  }
}
