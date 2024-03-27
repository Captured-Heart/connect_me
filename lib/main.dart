import 'dart:io';

import 'package:connect_me/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:quick_actions/quick_actions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );

  //load theme on startup
  container.read(themeProvider.notifier).loadCurrentThemeMode();

  // load the env variables
  await dotenv.load(fileName: ".env");

  /// initialize local storage [SharedPreferences]
  SharedPreferencesHelper.initSharedPref();
// initialize firebase in project
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //request perpmission fro firebase messaging
  container.read(fcmRepositoryImplProvider).requestPermissionAndSubscribe();
  // firebase messgaing listening to messages
  container.read(fcmRepositoryImplProvider).onListenToMessages();
  // initalizes local_notification to display message from cloud
  container.read(localNotificationsProvider).initializeLocalNotifications();

// enable analytics
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  // forcing the orientation of the app to be portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      UncontrolledProviderScope(
        container: container,
        child:
            // DevicePreview(
            //   enabled: !kReleaseMode,
            //   builder: (context) =>

            //   const MainApp(),
            // ),
            const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  // TODO: REFACTOR HOE WIDGET INTO A CLASS
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
          push(
            context,
            const HomeScreen2(initialIndex: 1),
            ref: ref,
            routeName: ScreenName.homeScreen,
          );
        } else if (shortcut == 'action_two') {
          // push(context, const HomeScreen2(initialIndex: 1));
          push(
            context,
            const HomeScreen2(initialIndex: 0),
            ref: ref,
            routeName: ScreenName.homeScreen,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final themeMode = ref.watch(themeProvider);

      // final analytics = ref.watch(analyticsProvider);

      return MaterialApp(
        restorationScopeId: 'connectMe',
        onGenerateTitle: (context) => TextConstant.appTitle,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        themeMode: themeMode,
        // builder: DevicePreview.appBuilder,
        // useInheritedMediaQuery: true,
        theme: themeBuilder(
          defaultTheme: ThemeData.light(),
        ),
        darkTheme: themeBuilder(
          defaultTheme: ThemeData.dark(),
        ),
        // navigatorObservers: [
        //   FirebaseAnalyticsObserver(analytics: analytics),
        // ],
        home: const SplashScreen(),
      );
    });
  }
}
