import 'package:connect_me/app.dart';

final firebaseProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final currentUUIDProvider = Provider<String>((ref) {
  return AuthRepositoryImpl(ref.read(firebaseProvider)).currentUUIDProvider!;
});

/// this is the auth provider [with_signIn_signout_google_signin]
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(ref.read(firebaseProvider));
});

/// auth services [signOut_signIn_etc]
final authStateChangesProvider = StreamProvider<User?>((ref) async* {
  yield* ref.watch(firebaseProvider).authStateChanges();
});
