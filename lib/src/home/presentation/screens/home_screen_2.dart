import 'dart:developer';

import 'package:connect_me/app.dart';

class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(qrcodeShareNotifierProvider);
    final users = ref.watch(fetchProfileProvider(''));

    log(isLoading.errorMessage ?? '');
    // shareQrCodeTemplate(context, globalKey: _globalKey);

    return FullScreenLoader(
      isLoading: isLoading.isLoading ?? false,
      child: Scaffold(
          appBar: const HomeScreenAppBar(
            hideTitle: true,
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: SpeedDial(
            icon: qrCodeIcon,
            overlayOpacity: 0.6,
            direction: SpeedDialDirection.up,
            children: [
              SpeedDialChild(
                child: const Icon(
                  Bootstrap.camera,
                  color: Colors.white,
                ),
                onTap: () {
                  // scan qr scan
                },
                label: TextConstant.scanQr,
                backgroundColor: Colors.red,
              ),
              SpeedDialChild(
                child: const Icon(
                  shareIcon,
                  color: Colors.white,
                ),
                label: TextConstant.shareProfile,
                backgroundColor: Colors.blue,
                onTap: () {
                  //share QR
                  // showAwesomeQrDilaogs(
                  //   context,
                  //   globalKey: _globalKey,
                  //   onShareQrcode: () {
                  //     ref.read(qrcodeShareNotifierProvider.notifier).shareQrToOtherApps(_globalKey);
                  //   },
                  // );

                  ref.read(qrcodeShareNotifierProvider.notifier).shareQrToOtherApps(_globalKey);
                },
              ),
            ],
            spacing: 10,
            mini: false,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
          body: users.when(
            data: (data) {
              return RepaintBoundary(
                key: _globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ProfilePicWidget(
                          authUserModel: data,
                        ),
                        CustomListTileWidget(
                          title: data.username ?? '',
                          showAtsign: true,
                        ),
                        data.bio?.isNotEmpty == true
                            ? Visibility(
                                visible: isLoading.isLoading == true ? false : true,
                                child: ListTile(
                                  title: const Text('Bio').padOnly(left: 20),
                                  contentPadding: AppEdgeInsets.eH20,
                                  subtitle: AutoSizeText(
                                    faker.lorem.sentences(15).toString(),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                      ].columnInPadding(10),
                    ),

                    //
                    Flexible(
                      child: Container(
                        margin: AppEdgeInsets.eA12,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.white),
                          gradient: whiteGradient(context: context),
                        ),
                        child: QrImageView(
                          data: data.docId!,
                          backgroundColor: context.colorScheme.onSurface,
                          eyeStyle: QrEyeStyle(
                              color: context.colorScheme.surface, eyeShape: QrEyeShape.square),
                          dataModuleStyle: QrDataModuleStyle(
                            color: context.colorScheme.surface,
                            dataModuleShape: QrDataModuleShape.circle,
                          ),
                          version: 5,
                          // size: context.sizeHeight(0.4),
                          gapless: false,
                          // padding: const EdgeInsets.all(12),
                        ).padSymmetric(horizontal: 5).padOnly(bottom: 0),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, _) {},
            loading: () => CircularProgressIndicator.adaptive(),
          )),
    );
  }

  Color convertGradientToSingleColor(List<Color> gradientColors) {
    // Calculate the average color of the gradient
    int totalRed = 0;
    int totalGreen = 0;
    int totalBlue = 0;

    for (Color color in gradientColors) {
      totalRed += color.red;
      totalGreen += color.green;
      totalBlue += color.blue;
    }

    int averageRed = (totalRed / gradientColors.length).round();
    int averageGreen = (totalGreen / gradientColors.length).round();
    int averageBlue = (totalBlue / gradientColors.length).round();

    // Create and return the average color
    return Color.fromARGB(255, averageRed, averageGreen, averageBlue);
  }

  Color gradientToSingleColor(LinearGradient gradient, double position) {
    assert(position >= 0.0 && position <= 1.0);

    // Evaluate the gradient at the specified position
    List<Color> colors = gradient.colors;
    List<double> stops =
        gradient.stops ?? List.generate(colors.length, (index) => index / (colors.length - 1));

    for (int i = 0; i < stops.length - 1; i++) {
      if (position >= stops[i] && position <= stops[i + 1]) {
        double t = (position - stops[i]) / (stops[i + 1] - stops[i]);
        return Color.lerp(colors[i], colors[i + 1], t)!;
      }
    }

    // Return the color at the last stop if position is greater than 1.0
    return colors.last;
  }
}
