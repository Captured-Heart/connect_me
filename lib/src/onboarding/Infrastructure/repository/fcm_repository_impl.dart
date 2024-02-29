import 'dart:io';

import 'package:connect_me/app.dart';

import '../../Domain/repository/local_notification_repository.dart';

final _fcmInstance = FirebaseMessaging.instance;

enum AppState { onInitialMessage, inBackground, openFromNotification }

enum FcmSubscriptionTopics {
  allUsers,
  allIos,
  allAndroid,
}

class FirebaseMessagingRepositoryImpl implements FirebaseMessagingRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseMessagingRepositoryImpl(this._firebaseFirestore, this.localNotificationRepositoryImpl);

  LocalNotificationRepositoryImpl localNotificationRepositoryImpl;

  @override
  Future<void> getTokenAndSaveToken({required String uuid}) async {
    String? token = await _fcmInstance.getToken();
    log('this is the token: $token and this is the uuid: $uuid');
    if (token?.isNotEmpty == true && token != null) {
      //saved to local
      SharedPreferencesHelper.setStringPref(SharedKeys.token.name, token);
      //save to firestore
      return _firebaseFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid)
          .update({FirebaseDocsFieldEnums.token.name: token});
    }
  }

  @override
  Future<void> requestPermissionAndSubscribe() async {
    var notifationSettings =
        await _fcmInstance.requestPermission(alert: true, sound: true, badge: true);
    await _fcmInstance.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);

    if (notifationSettings.authorizationStatus == AuthorizationStatus.authorized ||
        notifationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      //subscribe the users according to platform
      if (Platform.isIOS) {
        _fcmInstance.subscribeToTopic(FcmSubscriptionTopics.allIos.name);
      } else {
        _fcmInstance.subscribeToTopic(FcmSubscriptionTopics.allAndroid.name);
      }

      //subscribe this user to a topic with his UUID
      String? userUUid = SharedPreferencesHelper.getStringPref(SharedKeys.userUID.name);
      if (userUUid != null && userUUid.isNotEmpty == true) {
        _fcmInstance.subscribeToTopic(userUUid);
      }
//Subscribe this user to a list of all users
      return _fcmInstance.subscribeToTopic(FcmSubscriptionTopics.allUsers.name);
    }
  }

  @override
  void onListenToMessages() {
    _fcmInstance.getInitialMessage().then((RemoteMessage? message) {
      log('this is message from getInitial: ${message?.notification?.title}');
      log('this is message from getInitial: $message');
      if (message != null) {
        localNotificationRepositoryImpl.showFlutterNotification(message);
      }
      return _handleNotification(message: message, appState: AppState.onInitialMessage);
    });

    // ! onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('this is message from onMessage: ${message.notification?.title}');
      log('this is message from onMessage: $message');
      return localNotificationRepositoryImpl.showFlutterNotification(message);
      // return _handleNotification(message: message, appState: AppState.inBackground);
    });

    // ! replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('this is message from onMessageOpened: ${message.notification?.title}');
      log('this is message from onMessageOpened: $message');
      return localNotificationRepositoryImpl.showFlutterNotification(message);

      // return _handleNotification(message: message, appState: AppState.openFromNotification);
    });
  }

  @override
  void onInitializeFCM({required String uuid}) {
    requestPermissionAndSubscribe().then((value) => getTokenAndSaveToken(uuid: uuid));
    onListenToMessages();
  }
}

final fcmRepositoryImplProvider = Provider<FirebaseMessagingRepositoryImpl>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  final localNotificationRepositoryImpl = ref.read(localNotificationsProvider);
  return FirebaseMessagingRepositoryImpl(firebaseFirestore, localNotificationRepositoryImpl);
});

//
void _handleNotification({required RemoteMessage? message, required AppState appState}) async {
  inspect(message);
  switch (appState) {
    case AppState.onInitialMessage:
      log('this is the appstate: onInitialMessage');
      break;
    case AppState.inBackground:
      log('this is the appstate: inbackground');
      break;
    case AppState.openFromNotification:
      log('this is the appstate: open from notification');

      break;
  }
}
