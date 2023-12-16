import 'dart:developer';
import 'dart:io';
// import 'package:qr_code_scanner/qr_code_scanner.dart' as scan;

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
  bool flashStatus = false;
  String cameraSide = 'Rear';

  @override
  void initState() {
    if (controller != null) {
      controller!.resumeCamera();
    }
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen(
      (scanData) {
        controller.stopCamera();

        if (context.mounted) {
          // push(
          //   context,
          // ContactScreen(
          //   message: scanData.code,
          // ),
          // );
        }

        // setState(() {
        //   result = scanData;
        // });
      },
      cancelOnError: true,
      onDone: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code screen tests'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                _buildQrView(context),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientShortBTN(
                              iconData: Icons.flip_camera_ios_outlined,
                              isThinBorder: true,
                              tooltip: TextConstant.flipCamera,
                              onTap: () async {
                                var cameraFront =
                                    await controller?.getCameraInfo().then((value) => value.name);
                                log('cameraSide: $cameraFront');
                                setState(() {
                                  cameraSide = cameraFront!;
                                });
                                if (controller != null) {
                                  controller?.flipCamera();
                                }
                              },
                            ),

                            //flash button
                            GradientShortBTN(
                              iconData: cameraSide.contains('back')
                                  ? Icons.flashlight_off
                                  : Icons.flashlight_on_rounded,
                              isThinBorder: true,
                              tooltip: TextConstant.flash,
                              onTap: () async {
                                var cameraFront =
                                    await controller?.getCameraInfo().then((value) => value.name);
                                var flash =
                                    await controller?.getFlashStatus().then((value) => value);

                                setState(() {
                                  flashStatus = flash!;
                                });
                                if (cameraFront!.contains('back')) {
                                  controller?.toggleFlash();
                                } else {
                                  if (context.mounted) {
                                    showScaffoldSnackBarMessageNoColor(
                                      'Flash is used only in rear camera mode',
                                      context: context,
                                      isError: true,
                                    );
                                  }
                                }
                              },
                            ),

                            // //

                            // GradientShortBTN(
                            //   isThinBorder: true,
                            // ),
                          ].rowInPadding(20))
                      .padOnly(top: 20),
                ),
              ],
            ),
          ),
          Center(
            child: (result != null)
                ? Text('Barcode Type: ${(result!.format)}   Data: ${result!.code}')
                : Text('Focus to scan Qr code'),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // var scanArea =
    //     (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
    //         ? 150.0
    //         : 300.0;

    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.front,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: context.sizeHeight(0.4)),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      showScaffoldSnackBarMessageNoColor('No permission', context: context, isError: true);
    }
  }
}
