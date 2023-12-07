import 'package:connect_me/app.dart';

class QrCodeScreen extends ConsumerWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code screen tests'),
      ),
      body: Column(
        children: [
          QrImageView(
            data: 'data is life forget it',
            backgroundColor: context.colorScheme.onSurface,
            eyeStyle: QrEyeStyle(
                color: context.colorScheme.surface,
                eyeShape: QrEyeShape.square),
            dataModuleStyle: QrDataModuleStyle(
                color: context.colorScheme.surface,
                dataModuleShape: QrDataModuleShape.circle),
            version: 3,
            size: 200,
            gapless: false,
          )
        ],
      ),
    );
  }
}
