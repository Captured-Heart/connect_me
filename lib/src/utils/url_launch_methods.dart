import '../../app.dart';

class UrlOptions {
  static Future<void> launchWeb(String url, {bool? launchModeEXT = false}) async {
    final launchUri = Uri.parse(url);
    try {
      await launchUrl(
        launchUri,
        mode: launchModeEXT == false ? LaunchMode.inAppWebView : LaunchMode.platformDefault,
      );
    } catch (e) {
      log('this is the error from launchWeb $e');
      if (e is ArgumentError) {
        throw e.message;
      } else {
        throw AppException(e.toString());
      }
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> sendSms(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'sms',
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
