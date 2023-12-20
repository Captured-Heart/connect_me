import 'package:connect_me/app.dart';
import 'package:connect_me/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        home:
            user.value?.uid != null ? const MainScreen() : const SplashScreen(),
      );
    });
  }
}
