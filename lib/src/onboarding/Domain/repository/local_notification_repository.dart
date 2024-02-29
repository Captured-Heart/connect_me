import 'package:connect_me/app.dart';
import 'package:flutter/foundation.dart';

abstract class LocalNotificationRepository {
  Future<void> initializeLocalNotifications();
  void showFlutterNotification(RemoteMessage message);
}

class LocalNotificationRepositoryImpl implements LocalNotificationRepository {
  late AndroidNotificationChannel channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initialize
  @override
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse? notificationResponse) async {
      // Handle notification taps
      log('this is notification response: ${notificationResponse?.payload}');
    });

//  Initialize Android Channel
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// Create an Android Notification Channel.
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  //
  @override
  void showFlutterNotification(RemoteMessage message) {
    
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    if (notification != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
            importance: Importance.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentBadge: true,
            presentAlert: true,
            presentBanner: true,
            presentSound: true,
          ),
        ),
      );
    }
  }
}

final localNotificationsProvider = Provider<LocalNotificationRepositoryImpl>((ref) {
  return LocalNotificationRepositoryImpl();
});
