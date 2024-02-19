import 'package:connect_me/app.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    navigateToNexToScreen().then((_) {
      pushReplacement(context, const CheckAuthStateScreen());
    });
    super.initState();
  }

  Future<void> navigateToNexToScreen() async {
    return await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: context.sizeHeight(0.3),
            right: context.sizeWidth(0.0001),
            left: context.sizeWidth(0.0001),
            child: FadeInRightBig(
                child: Hero(
              tag: 'logo',
              child: Image.asset(
                ImagesConstant.appLogoBrown,
                fit: BoxFit.contain,
              ),
            )),
          ),
          Positioned(
            bottom: context.sizeHeight(0.33),
            left: context.sizeWidth(0.2),
            child: FadeInLeft(
              child: Text(
                'Connect Me',
                style: GoogleFonts.kenia(
                  fontWeight: AppFontWeight.w600,
                  fontSize: 25,
                ),
                textScaleFactor: 2.3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
