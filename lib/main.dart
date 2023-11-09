import 'package:animate_do/animate_do.dart';
import 'package:connect_me/app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'connectMe',
      onGenerateTitle: (context) => TextConstant.appTitle,
      debugShowCheckedModeBanner: false,
      // scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: themeBuilder(
        defaultTheme: ThemeData.light(),
      ),
      darkTheme: themeBuilder(
        defaultTheme: ThemeData.dark(),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToNexToScreen().then((_) {
      pushReplacement(context, const LoginScreen());
    });
    super.initState();
  }

  Future<void> navigateToNexToScreen() async {
    return await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Positioned(
            bottom: context.sizeHeight(0.3),
            right: context.sizeWidth(0.0001),
            left: context.sizeWidth(0.0001),
            child: FadeInRightBig(
                child: Image.asset(
              ImagesConstant.appLogoBrown,
              fit: BoxFit.contain,
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
