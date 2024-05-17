import 'package:connect_me/app.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/create_app_widget.dart';

void main() {
  initializeFirebaseForTest();
  group(
    'login_screen_test',
    () {
      testWidgets('identify widgets to confirm i am in login_screen', (widgetTester) async {
        await widgetTester.pumpWidget(createAppRoot(child: const LoginScreen()));
        await widgetTester.pump();

        /// finds the parent body widget [safearea]
        expect(find.byType(LoginScreen), findsOneWidget);
        //find pageview widget
        expect(
          find.byWidgetPredicate((widget) =>
              widget is PageView && widget.physics == const NeverScrollableScrollPhysics()),
          findsOneWidget,
        );
      });

      testWidgets('navigate to sign_up_screen / sign_in_screen / forgot password',
          (widgetTester) async {
        await widgetTester.pumpWidget(createAppRoot(child: const LoginScreen()));

        await widgetTester.pump();
        // once the screen loads, i shpuld see the sign-in card
        expect(find.byKey(const Key('sign-in-key'), skipOffstage: false), findsOneWidget);

        // i should see the already have an account widget
        expect(
          find.byWidgetPredicate(
              (widget) => widget is AlreadyHaveAnAcctWidget && widget.isLoginScreen == false),
          findsOneWidget,
        );

        // i have a gesture detector inside of the already have an account widget
        final onTapAlreadyHaveAcctWidget =
            find.byType(GestureDetector).descendantOf(find.byType(AlreadyHaveAnAcctWidget));

        expect(onTapAlreadyHaveAcctWidget, findsOneWidget);

        /// i navigate to the sign-up card by tapping the [AlreadyhaveAcct widget]
        await widgetTester.tap(onTapAlreadyHaveAcctWidget);
        await widgetTester.pump();

        //now the sign-up card is visible
        expect(find.byKey(const Key('sign-up-key'), skipOffstage: false), findsOneWidget);

        //tapped on the button again to navigate to the sign-in card
        await widgetTester.tap(onTapAlreadyHaveAcctWidget);
        await widgetTester.pump();
        expect(find.byKey(const Key('sign-in-key'), skipOffstage: false), findsOneWidget);

        //confirm that i can see forgotten password
        expect(find.text(TextConstant.forgottenPassword), findsOneWidget);

        final onTapForgotPassword = find
            .widgetWithText(TextButton, TextConstant.forgottenPassword)
            .descendantOf(find.byType(SignInCardWidget));
        // i found the [TextButton] in the [SignInCardWidget] for navigating to Forgot password
        expect(onTapForgotPassword, findsOneWidget);
      });

      testWidgets('test forgot password with infinite animation', (widgetTester) async {
        await widgetTester.pumpWidget(createAppRoot(child: const LoginScreen()));
        await widgetTester.pump(const Duration(seconds: 3));

        //find the forgot password button
        final onTapForgotPassword = find
            .widgetWithText(TextButton, TextConstant.forgottenPassword)
            .descendantOf(find.byType(SignInCardWidget));
        // //
        expect(onTapForgotPassword, findsOneWidget);
        await widgetTester.tap(onTapForgotPassword);
        //for inifinite animation, i had to pump twice, first pump draws the frame, 2nd pump handles the animation timer
        await widgetTester.pump();
        await widgetTester.pump(const Duration(seconds: 3));

        expect(find.byType(ForgotPasswordCard), findsOneWidget);
      });

      testWidgets('test if the textfield is empty onSubmit', (widgetTester) async {
        await widgetTester.pumpWidget(createAppRoot(child: const LoginScreen()));
        await widgetTester.pump();

        //found the textfield widgets
        expect(find.byType(AuthTextFieldWidget), findsExactly(2));

        // VARIABLES

        //keys
        Key emailTextFieldKey = const Key('sign-in-email-field');
        Key passwordTextFieldKey = const Key('sign-in-password-field');
        //email_textfield_finder
        Finder emailTextFieldFinder = find.byWidgetPredicate(
            (widget) => widget is AuthTextFieldWidget && widget.key == emailTextFieldKey,
            description: 'this is the email Textfield widget');

        Finder passwordTextFieldFinder = find.byWidgetPredicate(
            (widget) => widget is AuthTextFieldWidget && widget.key == passwordTextFieldKey,
            description: 'this is the password Textfield widget');
        Finder submitButton =
            find.byType(ElevatedButton).descendantOf(find.byType(SignInCardWidget));

        //email_textfield_widget
        AuthTextFieldWidget emailTextFieldWidget = widgetTester.widget(emailTextFieldFinder);
        //password_textfield_widget
        AuthTextFieldWidget passwordTextFieldWidget = widgetTester.widget(passwordTextFieldFinder);

        // the object expected
        MapDynamicString userDetails = {'email': 'Marcel', 'Password': 1234};

        expect(emailTextFieldFinder, findsOneWidget);

        //enter email
        await widgetTester.enterText(emailTextFieldFinder, 'Marcel');
        await widgetTester.pump();

        //enter password
        await widgetTester.enterText(passwordTextFieldFinder, '1234');
        await widgetTester.pump();

        expect(emailTextFieldWidget.controller?.text, isNotEmpty);
        expect(passwordTextFieldWidget.controller?.text, equals('1234'));

        // test the scope of the email text field widget
        expect(FocusScope.of(widgetTester.element(passwordTextFieldFinder)).hasFocus, isTrue);

        await widgetTester.tap(emailTextFieldFinder);
        await widgetTester.pump();
        expect(FocusScope.of(widgetTester.element(emailTextFieldFinder)).hasFocus, isTrue);
      });
    },
  );
}
