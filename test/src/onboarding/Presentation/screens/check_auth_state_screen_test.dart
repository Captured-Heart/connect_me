import 'package:connect_me/app.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  final MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
  GoogleSignInAccount? googleAccount = mockGoogleSignIn.currentUser;
  final user = MockUser(isEmailVerified: true, email: 'knkpozi@gmail.com', phoneNumber: '+2345667');
  final MockFirebaseAuth mockFirebaseAuth =
      MockFirebaseAuth(mockUser: user, verifyEmailAutomatically: false);

  group(
    'check_auth_state_screen_test',
    () {
      testWidgets('check if user is signed in', (widgetTester) async {
        googleAccount ??= await mockGoogleSignIn.signIn();
        googleAccount ??= await mockGoogleSignIn.signInSilently();
        final GoogleSignInAuthentication googleAuth = await googleAccount!.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await mockFirebaseAuth.signInWithCredential(credential);
        final user = userCredential.user;
        print(user);
      });
    },
  );
}
