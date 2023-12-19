import 'dart:developer';

import 'package:connect_me/app.dart';

class ShareQrCodeScreen extends ConsumerStatefulWidget {
  const ShareQrCodeScreen({super.key});

  @override
  ConsumerState<ShareQrCodeScreen> createState() => _ShareQrCodeScreenState();
}

class _ShareQrCodeScreenState extends ConsumerState<ShareQrCodeScreen> {
  final ValueNotifier<int> cardIndexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> cardisVertNotifier = ValueNotifier<bool>(true);
  final GlobalKey _globalKey = GlobalKey();

  Color buttonColor(int index) {
    switch (index) {
      case 0:
        return Colors.purple[800]!;
      case 1:
        return const Color(0xff901f44);
      case 2:
        return const Color(0xffc02c96);
      default:
        return Colors.purple[800]!;
    }
  }

  @override
  void dispose() {
    cardIndexNotifier.dispose();
    cardisVertNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: Listenable.merge([
            cardIndexNotifier,
            cardisVertNotifier,
          ]),
          builder: (context, _) {
            log('layout: ${cardisVertNotifier.value}');
            return Stack(
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/qrcode_BG${cardIndexNotifier.value}.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Center(
                      child: Card(
                        color: Colors.white,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          transformAlignment: Alignment.bottomLeft,
                          height: cardisVertNotifier.value == true
                              ? context.sizeHeight(0.45)
                              : context.sizeHeight(0.28),
                          width: cardisVertNotifier.value == true
                              ? context.sizeWidth(0.65)
                              : context.sizeWidth(0.9),
                          child: cardisVertNotifier.value == true
                              ? const PortraitQrCodeWidget()
                              : const LandscapeQrCodeWIdget(),
                        ),
                        // cardisVertNotifier.value == true
                        //     ? const PortraitQrCodeWidget()
                        //     : const LandscapeQrCodeWIdget(),
                      ).padOnly(
                        bottom: context.sizeHeight(0.1),
                        left: 10,
                        right: 10,
                      ),
                    ),
                  ),
                ),

                //
                Positioned.directional(
                  textDirection: TextDirection.ltr,
                  bottom: 0,
                  height: context.sizeHeight(0.2),
                  width: context.sizeWidth(1),
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    color: Colors.white,
                    // width: context.sizeWidth(1),
                    // decoration: BoxDecoration(color: Colors.white, borderRadius: AppBorderRadius.c12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    cardIndexNotifier.value = index;
                                    log(index.toString());
                                  },
                                  child: Container(
                                    margin: AppEdgeInsets.eH4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/qrcode_BG$index.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      border: cardIndexNotifier.value == index
                                          ? Border.all(color: context.colorScheme.onBackground)
                                          : null,
                                      borderRadius: AppBorderRadius.c12,
                                    ),
                                    child: Container(
                                      margin: AppEdgeInsets.eA4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/qrcode_BG$index.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        border: cardIndexNotifier.value == index
                                            ? Border.all(color: context.colorScheme.onBackground)
                                            : null,
                                        borderRadius: AppBorderRadius.c12,
                                      ),
                                      child: const Icon(
                                        qrCodeIcon,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ).padOnly(top: 20, left: 10, right: 10),
                        ),

                        //share button
                        SocialButtons(
                          onTap: () {
                            ref
                                .read(qrcodeShareNotifierProvider.notifier)
                                .shareQrToOtherApps(_globalKey);
                          },
                          iconData: shareIcon,
                          text: 'Share QR Code',
                          color: buttonColor(cardIndexNotifier.value),
                        ).padSymmetric(horizontal: context.sizeWidth(0.08), vertical: 5)
                      ].columnInPadding(10),
                    ),
                  ),
                ),
                Positioned(
                  top: context.sizeWidth(0.13),
                  left: 10,
                  child: const BackButton(),
                ),
                Positioned(
                  top: context.sizeWidth(0.13),
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      cardisVertNotifier.value = !cardisVertNotifier.value;
                    },
                    child: Container(
                      padding: AppEdgeInsets.eA4,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: Icon(
                        cardisVertNotifier.value == false ? Icons.swap_vert : Icons.swap_horiz,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
