import 'package:connect_me/app.dart';
import 'package:connect_me/src/utils/create_app_widet.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:connect_me/src/home/presentation/screens/main_screen.dart' as app;
import '../../mocks.dart';

void main() async {
  setUpAll(() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // MockFirebase();
    // MockAnalytics();
    // MockFirebaseMessaging();
    // MockAuthRepository();
    // MockLoginProvider();
  });
  // TestWidgetsFlutterBinding.ensureInitialized();
  // MockFirebase();
  // MockAnalytics();
  // MockFirebaseMessaging();
  // MockAuthRepository();
  // MockLoginProvider();

  group('(Login Screen)', () {
    // await dotenv.load(fileName: ".env");
    // SharedPreferencesHelper.initSharedPref();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    testWidgets('find the widgets in login screen', (widgetTester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await widgetTester.pumpWidget(createAppRoot(child: const LoginScreen()));
      await widgetTester.pump();

      final iconAbc = find.text(TextConstant.returnToLogin);


      expect(iconAbc, findsOneWidget);
    });
  });
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        key: Key('sign-in_key'),
        body: Text('data'),
      ),
    );
  }
}
