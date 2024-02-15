import 'package:connect_me/app.dart';

abstract class AnalyticsRepository {
  Future<void> login({required String email, required String uid, required String loginMethod});

  Future<void> signUp({required String email, required String uid, required String signUpMethod});
  Future<void> shareQrCode(
      {required String email, required String scannedUUID, required String signUpMethod});
}

class AnalyticsRepositoryImpl extends AnalyticsRepository {
  final FirebaseAnalytics _analytics;

  AnalyticsRepositoryImpl(this._analytics);
  @override
  Future<void> login({required String email, required String uid, required String loginMethod}) {
    return _analytics.logLogin(loginMethod: loginMethod, parameters: {
      FirebaseDocsFieldEnums.email.name: email,
      FirebaseDocsFieldEnums.userId.name: uid,
    });
  }

  @override
  Future<void> signUp({
    required String email,
    required String uid,
    required String signUpMethod,
  }) {
    return _analytics.logSignUp(signUpMethod: signUpMethod, parameters: {
      FirebaseDocsFieldEnums.email.name: email,
      FirebaseDocsFieldEnums.userId.name: uid,
    });
  }

  @override
  Future<void> shareQrCode(
      {required String email, required String scannedUUID, required String signUpMethod}) {
    return _analytics.logShare(
        contentType: "email of scanner: $email\n ", itemId: scannedUUID, method: 'QR-code_share');
  }
}

// final analyticsRepositoryImplProvider = Provider<AnalyticsRepositoryImpl>((ref) {
//   final analytics = ref.read(analyticsProvider);
//   return AnalyticsRepositoryImpl(analytics);
// });
