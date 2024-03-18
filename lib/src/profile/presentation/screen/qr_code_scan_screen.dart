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
                    ref: ref,
                    routeName: ScreenName.profileOthersScreen,
                    ProfileScreenOthers(
                      uuid: (next.data as AuthUserModel).docId,
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
                                //TODO: ADD ANALYTICS TO SHOW SCAN METHOD
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




//Connect Me: QR code Digital ID