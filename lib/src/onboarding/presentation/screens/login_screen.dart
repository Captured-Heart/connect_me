import 'package:connect_me/app.dart';

final flipCardControllerProvider = Provider.autoDispose<FlipCardController>((ref) {
  return FlipCardController();
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isFrontOfCard = false;
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(flipCardControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: FlipCard(
                controller: controller,
                flipOnTouch: false,
                onFlipDone: (isFront) {
                  setState(() {
                    isFrontOfCard = isFront;
                  });
                },
                fill: Fill.fillBack,
                back: const SignUpCardWidget().padAll(15),
                front: const SignInCardWidget().padAll(15),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AlreadyHaveAnAcctWidget(
                controller: controller,
                isFrontOfCard: isFrontOfCard,
              ),
            )
          ],
        ),
      ),
    );
  }
}
