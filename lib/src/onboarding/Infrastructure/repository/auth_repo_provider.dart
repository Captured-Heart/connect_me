import 'package:connect_me/app.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final cloudFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final analyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

final currentUUIDProvider = Provider<String>((ref) {
  final googleSign = ref.read(googleSignInProvider);
  final firestore = ref.read(cloudFirestoreProvider);

  return AuthRepositoryImpl(ref.read(firebaseAuthProvider), googleSign, firestore).currentUUIDProvider!;
});

/// this is the auth provider [with_signIn_signout_google_signin]
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final googleSign = ref.read(googleSignInProvider);
  final firestore = ref.read(cloudFirestoreProvider);

  return AuthRepositoryImpl(ref.read(firebaseAuthProvider), googleSign, firestore);
});

/// auth services [signOut_signIn_etc]
final authStateChangesProvider = StreamProvider<User?>((ref) async* {
  yield* ref.watch(firebaseAuthProvider).authStateChanges();
});

final analyticsImplProvider = Provider<AnalyticsRepositoryImpl>((ref) {
  final analytics = ref.read(analyticsProvider);

  return AnalyticsRepositoryImpl(analytics);
});
