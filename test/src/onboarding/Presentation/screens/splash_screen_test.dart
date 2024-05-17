import 'package:connect_me/app.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/create_app_widget.dart';

void main() {
  initializeFirebaseForTest();

  group('splash_screen_test', () {
    testWidgets('Check for splash widgets', (widgetTester) async {
      await widgetTester.pumpWidget(
        createAppRoot(
          child: const SplashScreen(),
        ),
      );

      //gives time for the timer to dispose
      await widgetTester.pump(const Duration(seconds: 2));
      //find the image widget in splash screen
      final image = find.byType(Image);
      //find the title of the app
      final title = find.widgetWithText(AutoSizeText, 'Connect Me');
      //expect the image to be present
      expect(image, findsOneWidget);
      //expect the title to be present
      expect(title, findsOneWidget);

      //find the app logo image
      expect(find.widgetWithImage(FadeInRightBig, const AssetImage(ImagesConstant.appLogoBrown)),
          findsOneWidget);
    });

    testWidgets('check for navigation in splash screen', (widgetTester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await widgetTester.pumpWidget(
        createAppRoot(
          child: const SplashScreen(),
          navigatorKey: navigatorKey,
        ),
      );

      await widgetTester.pump(const Duration(seconds: 2));

      //check if the splash navigates to the check_auth_state_screen
      expect(find.byKey(const ValueKey('check_auth_state_screen'), skipOffstage: false),
          findsOneWidget);

      //check if the navigation is done to login screen
      // NB: It can't popped because i pushReplaced the splash screen
      expect(navigatorKey.currentState?.canPop(), isFalse);
    });
  });
}
