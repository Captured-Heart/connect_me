import 'dart:io';

import 'package:connect_me/app.dart';
import 'package:connect_me/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_actions/quick_actions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );

// firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
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

  void initiateQuickActions() async{
    QuickActions quickActions = const QuickActions();

    quickActions.initialize((type) {
      log('type is: $type');

      if (type == 'action_one') {
        push(context, const ProfileScreen());
        push(context, const ProfileScreen());

      } else if (type == 'action_two') {
        push(context, const QrCodeScreen());
        push(context, const QrCodeScreen());

      }
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
          pushAsVoid(context, const HomeScreen2());
        } else if (shortcut == 'action_two') {
          pushAsVoid(context, const QrCodeScreen());
        }
        // if (shortcut == 'no actions') {
        //   shortcut = 'actions ready';
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final user = ref.watch(authStateChangesProvider);
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
        home: user.value?.uid != null ? const MainScreen() : const SplashScreen(),
      );
    });
  }
}
