import 'package:connect_me/app.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class FirebaseMessagingRepository {
  Future<void> requestPermissionAndSubscribe();
  Future<void> getTokenAndSaveToken({required String uuid});
  void onListenToMessages();
  void onInitializeFCM({required String uuid});
}

void sendMessageToTopic() async {
  // Firebase Cloud Messaging server key
  //TODO: HIDE SERVER KEYS
  String serverKey = EnvHelper.getEnv(EnvKeys.fcmServerKeys);
  

  // Define the message payload
  final Map<String, dynamic> message = {
    'notification': {
      'title': 'Welcome to the App',
      'body': 'This is a message sent from the admin.',
    },
    'topic': FcmSubscriptionTopics
        .allAndroid.name, // Replace with the topic you want to send the message to
    "to": "/topics/${FcmSubscriptionTopics.allUsers.name}"
  };

  // Send the message to the specified topic using FCM REST API
  try {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    // return response.body;
  } catch (e) {
    log('this is the catch ${e.toString()}');
  }
}
