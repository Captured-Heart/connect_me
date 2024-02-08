import 'package:connect_me/app.dart' hide CameraFacing;
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScanScree extends ConsumerStatefulWidget {
  const QrCodeScanScree({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrCodeScanScreeState();
}

class _QrCodeScanScreeState extends ConsumerState<QrCodeScanScree> {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
      // torchEnabled: false, useNewCameraSelector: true,
      // formats: [BarcodeFormat.qrCode]
      // facing: CameraFacing.front,
      // detectionSpeed: DetectionSpeed.normal
      // detectionTimeoutMs: 1000,
      // returnImage: false,
      );

  bool isStarted = true;

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  int? numberOfCameras;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('With controller')),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                onScannerStarted: (arguments) {
                  if (mounted && arguments?.numberOfCameras != null) {
                    numberOfCameras = arguments!.numberOfCameras;
                    setState(() {});
                  }
                },
                controller: controller,
                errorBuilder: (context, error, child) {
                  return Center(
                    child: Text(error.errorDetails?.message ?? 'error'),
                  );
                },
                fit: BoxFit.contain,
                onDetect: (barcode) {
                  setState(() {
                    this.barcode = barcode;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                      IconButton(
                        color: Colors.white,
                        icon: isStarted ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: _startOrStop,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              barcode?.barcodes.first.rawValue ?? 'Scan something!',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder<CameraFacing>(
                          valueListenable: controller.cameraFacingState,
                          builder: (context, state, child) {
                            switch (state) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed:
                            (numberOfCameras ?? 0) < 2 ? null : () => controller.switchCamera(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image),
                        iconSize: 32.0,
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            if (await controller.analyzeImage(image.path)) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Barcode found!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No barcode found!'),
                                  backgroundColor: Colors.red,
                                ),
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
    );
  }
}
