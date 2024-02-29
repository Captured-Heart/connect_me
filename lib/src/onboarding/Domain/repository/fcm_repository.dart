import 'package:connect_me/app.dart';
// ignore: depend_on_referenced_packages

abstract class FirebaseMessagingRepository {
  Future<void> requestPermissionAndSubscribe();
  Future<void> getTokenAndSaveToken({required String uuid});
  void onListenToMessages();
  void onInitializeFCM({required String uuid});
  void sendMessageToTopic({required PushNotificationModel pushNotificationModel});
}
