import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../app.dart';

final _fcmInstance = FirebaseMessaging.instance;

enum AppState { onInitialMessage, inBackground, openFromNotification }

enum FcmSubscriptionTopics {
  allUsers,
  allIos,
  allAndroid,
}

class FirebaseMessagingRepositoryImpl implements FirebaseMessagingRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseMessagingRepositoryImpl(this._firebaseFirestore, this.localNotificationRepository);

  LocalNotificationRepository localNotificationRepository;

  @override
  Future<void> getTokenAndSaveToken({required String uuid}) async {
    //check if the token exists

    String? token = await _fcmInstance.getToken();
    // log('this is the token: $token and this is the uuid: $uuid');
    if (token?.isNotEmpty == true && token != null) {
      //saved to local
      SharedPreferencesHelper.setStringPref(SharedKeys.token.name, token);
      //save to firestore
      return _firebaseFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid)
          .set({FirebaseDocsFieldEnums.token.name: token}, SetOptions(merge: true));
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
        localNotificationRepository.showFlutterNotification(message);
      }
      return _handleNotification(message: message, appState: AppState.onInitialMessage);
    });

    // ! onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('this is message from onMessage: ${message.notification?.title}');
      log('this is message from onMessage: $message');
      return localNotificationRepository.showFlutterNotification(message);
      // return _handleNotification(message: message, appState: AppState.inBackground);
    });

    // ! replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('this is message from onMessageOpened: ${message.notification?.title}');
      log('this is message from onMessageOpened: $message');
      return localNotificationRepository.showFlutterNotification(message);

      // return _handleNotification(message: message, appState: AppState.openFromNotification);
    });
  }

  @override
  void onInitializeFCM({required String uuid}) {
    requestPermissionAndSubscribe().then((value) => getTokenAndSaveToken(uuid: uuid));
    onListenToMessages();
  }

  @override
  void sendMessageToTopic({required PushNotificationModel pushNotificationModel}) async {
    // Firebase Cloud Messaging server key
    String serverKey = EnvHelper.getEnv(EnvKeys.fcmServerKeys);
    String fcmURL = EnvHelper.getEnv(EnvKeys.fcmPostUrl);

    // Define the message payload
    final Map<String, dynamic> message = {
      'notification': {
        'title': pushNotificationModel.title,
        'body': pushNotificationModel.body,
      },
      'topic': pushNotificationModel.topic,
      "to": "/topics/${pushNotificationModel.topic}"
    };

    // Send the message to the specified topic using FCM REST API
    try {
      final url = Uri.parse(fcmURL);
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(message),
      );

      // return response.body;
    } catch (e) {
      log('this is the catch ${e.toString()}');
    }
  }
}

final fcmRepositoryImplProvider = Provider<FirebaseMessagingRepositoryImpl>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  final localNotificationRepository = ref.read(localNotificationsProvider);
  return FirebaseMessagingRepositoryImpl(firebaseFirestore, localNotificationRepository);
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

class PushNotificationModel extends Equatable {
  final String title;
  final String body;
  final String topic;
  final String token;

  const PushNotificationModel({
    required this.title,
    required this.body,
    required this.topic,
    required this.token,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        topic,
        token,
      ];
}






  // @override
  // void sendMessageToToken({required PushNotificationModel pushNotificationModel}) async {
  //   // Firebase Cloud Messaging server key
  //   // String serverKey = EnvHelper.getEnv(EnvKeys.fcmServerKeys);
  //   String fcmURL = EnvHelper.getEnv(EnvKeys.fcmPostUrlV2);
  //   String accesTokenEnv = EnvHelper.getEnv(EnvKeys.googleCredentials);
  //   // Read the service account key file
  //   String serviceAccountJson = await File(accesTokenEnv).readAsString();
  //   final credentials = ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));
  //   // Parse the JSON content
  //   final client = await clientViaServiceAccount(
  //       credentials, ['https://www.googleapis.com/auth/firebase.messaging']);
  //   Map<String, dynamic> serviceAccountMap = json.decode(serviceAccountJson);

  //   // Extract the access token
  //   String accessToken = client.credentials.accessToken.data;
  //   // SharedPreferencesHelper.getStringPref(SharedKeys.accessToken.name) ?? 'dvsd';
  //   // serviceAccountMap['token'];

  //   log('\n\n this is the accessToken: $accessToken');
  //   // Define the message payload
  //   final Map<String, dynamic> message = {
  //     "message": {
  //       "token": pushNotificationModel.token,
  //       "notification": {
  //         "body": pushNotificationModel.body,
  //         "title": pushNotificationModel.title,
  //       }
  //     }
  //   };

  //   // Send the message to the specified topic using FCM REST API
  //   try {
  //     log('trying to send fcm to token: ${pushNotificationModel.token}');
  //     final url = Uri.parse(fcmURL);
  //     await http
  //         .post(
  //           url,
  //           headers: <String, String>{
  //             'Content-Type': 'application/json',
  //             'Authorization': 'Bearer $accessToken',
  //           },
  //           body: jsonEncode(message),
  //         )
  //         .then((value) =>
  //             log('this is the status code: ${value.statusCode}, thi sis the body: ${value.body}'));

  //     // return response.body;
  //   } catch (e) {
  //     log('this is the catch ${e.toString()}');
  //   }
  // }