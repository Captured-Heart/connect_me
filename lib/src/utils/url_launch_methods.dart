import 'package:connect_me/app.dart';

class UrlOptions {
  static Future<void> launchWeb(String url,
      {bool? launchModeEXT = false}) async {
    final launchUri = Uri.parse(url);
    await launchUrl(
      launchUri,
      mode: launchModeEXT == false
          ? LaunchMode.inAppWebView
          : LaunchMode.platformDefault,
    );
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> sendEmail(String email) async {
    final launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}
