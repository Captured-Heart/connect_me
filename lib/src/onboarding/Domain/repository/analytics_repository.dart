import 'package:connect_me/app.dart';

abstract class AnalyticsRepository {
  Future<void> login({required String email, required String uid, required String loginMethod});

  Future<void> signUp({required String email, required String uid, required String signUpMethod});
  Future<void> shareQrCode(
      {required AuthUserModel authUserModel, required String sharedDestination});
  Future<void> scanQrCode({required AuthUserModel authUserModel});
  Future<void> profileVisit({required AuthUserModel authUserModel});
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
      {required AuthUserModel authUserModel, required String sharedDestination}) {
    return _analytics.logShare(
      contentType: "sender: ${authUserModel.email} \n receiver: $sharedDestination ",
      itemId: 'userId: ${authUserModel.docId},',
      method: 'QR-code_share',
      parameters: {
        'receiver': sharedDestination,
        'sender_country': authUserModel.additionalDetails?.country,
        'sender_state': authUserModel.additionalDetails?.state
      },
    );
  }

  @override
  Future<void> scanQrCode({required AuthUserModel authUserModel}) {
    return _analytics.logEvent(
      name: 'Scanned Qr-Code',
      parameters: {
        'Scanned email': authUserModel.email,
        'country code': authUserModel.phonePrefix,
        'full-name': authUserModel.fullname,
        'country': authUserModel.additionalDetails?.country,
        'state': authUserModel.additionalDetails?.state
      },
    );
  }

  @override
  Future<void> profileVisit({required AuthUserModel authUserModel}) {
    return _analytics.logEvent(
      name: 'profile-Visit',
      parameters: {
        'visited_user': authUserModel.email,
        'country code': authUserModel.phonePrefix,
        'full-name': authUserModel.fullname,
        'country': authUserModel.additionalDetails?.country,
        'state': authUserModel.additionalDetails?.state
      },
    );
  }
}
