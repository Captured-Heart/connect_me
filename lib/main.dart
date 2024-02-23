import 'dart:io';

import 'package:connect_me/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:quick_actions/quick_actions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  SharedPreferencesHelper.initSharedPref();
// firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    //todo: change this to production
    log('built analytics in debug');
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      UncontrolledProviderScope(
        container: container,
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String shortcut = 'no actions';

  List<ShortcutItem> forIos = [
    const ShortcutItem(
        type: 'action_one', localizedTitle: TextConstant.viewQrCode, icon: 'AppIcon'),
    const ShortcutItem(type: 'action_two', localizedTitle: TextConstant.scanQr, icon: 'AppIcon')
  ];
  List<ShortcutItem> forAndroid = [
    const ShortcutItem(
        type: 'action_one', localizedTitle: TextConstant.viewQrCode, icon: 'ic_launcher'),
    const ShortcutItem(type: 'action_two', localizedTitle: TextConstant.scanQr, icon: 'ic_launcher')
  ];
  @override
  void initState() {
    initiateQuickActions();

    super.initState();
  }

  void initiateQuickActions() async {
    QuickActions quickActions = const QuickActions();

    quickActions.initialize((type) {
      setState(() {
        shortcut = type;
      });
    });

    quickActions
        .setShortcutItems(
      Platform.isIOS == true ? forIos : forAndroid,
    )
        .then((_) {
      setState(() {
        if (shortcut == 'action_one') {
          // push(context, const HomeScreen2(initialIndex: 0));
          push(context, const HomeScreen2(initialIndex: 1));
        } else if (shortcut == 'action_two') {
          // push(context, const HomeScreen2(initialIndex: 1));
          push(context, const HomeScreen2(initialIndex: 0));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      // final user = ref.watch(authStateChangesProvider);
      final analytics = ref.watch(analyticsProvider);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        analytics.logAppOpen();
      });
      return MaterialApp(
          restorationScopeId: 'connectMe',
          onGenerateTitle: (context) => TextConstant.appTitle,
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          theme: themeBuilder(
            defaultTheme: ThemeData.light(),
          ),
          darkTheme: themeBuilder(
            defaultTheme: ThemeData.dark(),
          ),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          home:
              // AccountInformationSignUpScreen()
              const SplashScreen()
          // user.value?.uid != null ? const MainScreen() : const SplashScreen(),
          );
    });
  }
}
