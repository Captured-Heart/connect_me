import 'dart:math' hide log;

import 'package:connect_me/app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScanScreen extends ConsumerStatefulWidget {
  const QrCodeScanScreen({super.key, required this.tabController});
  final TabController tabController;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrCodeScanScreenState();
}

class _QrCodeScanScreenState extends ConsumerState<QrCodeScanScreen> {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.unrestricted,
    detectionTimeoutMs: 500,
    // formats: [BarcodeFormat.qrCode],
  );

  bool isStarted = true;
  String userUUid = '';
  int? numberOfCameras;

  @override
  Widget build(BuildContext context) {
    var isLoading = ref.watch(qrCodeScanNotifierProvider);
    ref.listen(qrCodeScanNotifierProvider, (previous, next) {
      if (next.isCompleted == true && next.data != null) {
        ref.read(addAccountInfoProvider.notifier).updateScanCount();
        Vibration.vibrate(duration: 200);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Container(
              width: context.sizeWidth(0.75),
              decoration: const BoxDecoration(
                color: AppThemeColorDark.textDark,
                borderRadius: AppBorderRadius.c12,
              ),
              child: PortraitQrCodeWidget(
                authUserModel: next.data as AuthUserModel,
                isAfterScanDialog: true,
                viewFullProfileBTN: () {
                  pop(context);
                  push(
                    context,
                    ProfileScreenOthers(
                      uuid: userUUid,
                      fromScanScreen: true,
                      users: next.data as AuthUserModel,
                      tabController: widget.tabController,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }
    });
    var scanWindow = Rect.fromCenter(
      center: context.center(
        Offset(
          1,
          -context.sizeHeight(0.12),
        ),
      ),
      width: context.sizeWidth(0.65),
      height: context.sizeHeight(0.35),
    );

    // log('is just starting: ${controller.isStarting}');

    return FullScreenLoader(
      isLoading: isLoading.isLoading ?? false,
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  onScannerStarted: (arguments) {
                    inspect(arguments);
                    if (mounted && arguments?.numberOfCameras != null) {
                      numberOfCameras = arguments!.numberOfCameras;
                      setState(() {});
                    }
                  },
                  scanWindow: scanWindow,
                  controller: controller,
                  errorBuilder: (context, error, child) {
                    return Center(
                      child: Text(
                        '''Check Camera Permissions! 
                        or 
        Restart scan process'''
                            .hardCodedString,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  onDetect: (barcode) {
                    //check if the qr_code contains connect_me symbol/TAg
                    if (barcode.barcodes.first.rawValue?.startsWith(TextConstant.uuidPrefixTag) ==
                        true) {
                      var scannedRawUUID = barcode.barcodes.first.rawValue.toString();

                      ref
                          .read(qrCodeScanNotifierProvider.notifier)
                          .scanQrCodeMethod(scannedRawUUID: scannedRawUUID, ref: ref);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AppCustomSuccessDialog(
                            dialogModel: DialogModel(
                              title: 'Scan a Connect_Me\n QR Code instead',
                              hasImage: true,
                              postiveActionText: TextConstant.ok,
                              onPostiveAction: () {
                                pop(context);
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),

                //!Overlay widget
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomPaint(
                    size: Size(
                      context.sizeWidth(1),
                      context.sizeHeight(0.1),
                    ),
                    painter: ScannerOverlay(scanWindow),
                  ),
                ),
                // Align(
                //   child: CircularProgressIndicator(
                //     strokeWidth: 2.2,
                //   ),
                // ),
                // All the action buttons [Image], [Switch Camera], [Flash]
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //! FLASH TORCH
                        ValueListenableBuilder(
                          valueListenable: controller.hasTorchState,
                          builder: (context, state, child) {
                            if (state != true) {
                              return const SizedBox.shrink();
                            }
                            return IconButton(
                              color: Colors.white,
                              icon: ValueListenableBuilder<TorchState>(
                                valueListenable: controller.torchState,
                                builder: (context, state, child) {
                                  switch (state) {
                                    case TorchState.off:
                                      return const Icon(
                                        Icons.flash_off,
                                        color: Colors.grey,
                                      );
                                    case TorchState.on:
                                      return const Icon(
                                        Icons.flash_on,
                                        color: Colors.yellow,
                                      );
                                  }
                                },
                              ),
                              iconSize: 32.0,
                              onPressed: () => controller.toggleTorch(),
                            );
                          },
                        ),
                        // IconButton(
                        //   color: Colors.white,
                        //   icon: isStarted ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
                        //   iconSize: 32.0,
                        //   onPressed: _startOrStop,
                        // ),
                        // Center(
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width - 200,
                        //     height: 50,
                        //     child: FittedBox(
                        //       child: Text(
                        //         barcode?.barcodes.first.rawValue ?? 'Scan something!',
                        //         overflow: TextOverflow.fade,
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headlineMedium!
                        //             .copyWith(color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        //! CAMERA SWITCH
                        IconButton(
                          color: AppThemeColorDark.textDark,
                          tooltip: 'Switch Camera'.hardCodedString,
                          icon: ValueListenableBuilder<CameraFacing>(
                            valueListenable: controller.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state) {
                                case CameraFacing.front:
                                  return const Icon(Icons.camera_rear);
                                case CameraFacing.back:
                                  return const Icon(Icons.cameraswitch_outlined);
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed:
                              (numberOfCameras ?? 0) < 2 ? null : () => controller.switchCamera(),
                        ),
                        //! SELECT IMAGE
                        IconButton(
                          tooltip: 'Select image'.hardCodedString,
                          color: AppThemeColorDark.textDark,
                          icon: const Icon(Icons.image),
                          iconSize: 32.0,
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();

                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (image != null) {
                              await controller.analyzeImage(image.path);
                              if (await controller.analyzeImage(image.path)) {
                                showScaffoldSnackBarMessage(
                                  TextConstant.successful,
                                );
                              } else {
                                if (!mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AppCustomSuccessDialog(
                                      dialogModel: DialogModel(
                                        title: 'Scan a Connect_Me\n QR Code instead',
                                        hasImage: true,
                                        postiveActionText: TextConstant.ok,
                                        onPostiveAction: () {
                                          pop(context);
                                          widget.tabController.animateTo(0);
                                        },
                                      ),
                                    );
                                  },
                                );
                                showScaffoldSnackBarMessage(
                                  'QR Code could not be recognized'.hardCodedString,
                                  isError: true,
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomOverlayShape extends ShapeBorder {
  CustomOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    double? cutOutSize,
    double? cutOutWidth,
    double? cutOutHeight,
    this.cutOutBottomOffset = 0,
  })  : cutOutWidth = cutOutWidth ?? cutOutSize ?? 250,
        cutOutHeight = cutOutHeight ?? cutOutSize ?? 250 {
    assert(
      borderLength <= min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2}",
    );
    assert(
        (cutOutWidth == null && cutOutHeight == null) ||
            (cutOutSize == null && cutOutWidth != null && cutOutHeight != null),
        'Use only cutOutWidth and cutOutHeight or only cutOutSize');
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;
  final double cutOutBottomOffset;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final _borderLength = borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
        ? borderWidthSize / 2
        : borderLength;
    final _cutOutWidth = cutOutWidth < width ? cutOutWidth : width - borderOffset;
    final _cutOutHeight = cutOutHeight < height ? cutOutHeight : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - _cutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset + rect.top + height / 2 - _cutOutHeight / 2 + borderOffset,
      _cutOutWidth - borderOffset * 2,
      _cutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - _borderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + _borderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + _borderLength,
          cutOutRect.top + _borderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - _borderLength,
          cutOutRect.bottom - _borderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - _borderLength,
          cutOutRect.left + _borderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return CustomOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;
  final double borderRadius = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    // Create a Paint object for the white border
    final borderPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.0; // Adjust the border width as needed

    // Calculate the border rectangle with rounded corners
// Adjust the radius as needed
    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // Draw the white border
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
