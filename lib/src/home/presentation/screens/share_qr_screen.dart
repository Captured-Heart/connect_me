import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';

class ShareQrCodeScreen extends ConsumerStatefulWidget {
  const ShareQrCodeScreen({
    super.key,
    this.authUserModel,
  });
  final AuthUserModel? authUserModel;
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
    final shareCode = ref.watch(qrcodeShareNotifierProvider);

    return Scaffold(
      // extendBody: true,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // floatingActionButton: flipWidgetBTN().padAll(10),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: ListenableBuilder(
            listenable: Listenable.merge([
              cardIndexNotifier,
              cardisVertNotifier,
            ]),
            builder: (context, _) {
              return Stack(
                children: [
                  RepaintBoundary(
                    key: _globalKey,

                    // CONTAINER WITH THE BACKGROUND WALLPAPER
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/qrcode_BG${cardIndexNotifier.value}.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Center(
                        //QR CODE WIDGET WITH A CARD
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
                                ? PortraitQrCodeWidget(
                                    authUserModel: widget.authUserModel,
                                  )
                                : LandscapeQrCodeWIdget(
                                    authUserModel: widget.authUserModel,
                                  ),
                          ),
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
                    height: context.sizeHeight(0.17),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // THE CONTAINER SELECT BACKGROUND WIDGET
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
                                    },
                                    child: Container(
                                      margin: AppEdgeInsets.eH4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/qrcode_BG$index.png'),
                                          fit: BoxFit.fill,
                                        ),
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
                                              ? Border.all(color: Colors.white)
                                              : null,
                                          borderRadius: AppBorderRadius.c12,
                                        ),
                                        child: const Icon(
                                          qrCodeIcon,
                                          size: 25,
                                          color: Colors.white,
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
                              if (widget.authUserModel != null) {
                                ref.read(qrcodeShareNotifierProvider.notifier).shareQrToOtherApps(
                                      _globalKey,
                                      authUserModel: widget.authUserModel!,
                                    );
                              }
                            },
                            iconData: shareIcon,
                            isLoading: shareCode.isLoading ?? false,
                            textColor: Colors.white,
                            text: TextConstant.shareQrCode,
                            color: buttonColor(cardIndexNotifier.value),
                          ).padSymmetric(horizontal: context.sizeWidth(0.08), vertical: 5)
                        ].columnInPadding(10),
                      ),
                    ),
                  ),

                  //! BACK BUTTON
                  // Positioned(
                  //   top: context.sizeWidth(0.13),
                  //   left: 10,
                  //   child: const BackButton(
                  //     color: Colors.white,
                  //   ),
                  // ),

                  // FLIP THE QR WIDGET TO LANDSCAPE AND PORTRAIT
                  Positioned(
                    top: context.sizeWidth(0.03),
                    right: 20,
                    child: flipWidgetBTN(),
                  ),
                ],
              );
            }),
      ),
    );
  }

  GestureDetector flipWidgetBTN() {
    return GestureDetector(
      onTap: () {
        cardisVertNotifier.value = !cardisVertNotifier.value;
      },
      child: Tooltip(
        message: cardisVertNotifier.value == true
            ? TextConstant.switchToLandscap
            : TextConstant.switchToPortrait,
        child: Container(
          padding: AppEdgeInsets.eA8,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
              )),
          child: Icon(
            cardisVertNotifier.value == false ? Icons.swap_vert : Icons.swap_horiz,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}
