import 'package:connect_me/app.dart';

class HelpCenterImpl extends HelpCenterRepository {
  @override
  Future<void> contactTwitter(String twitterUrl) async {
    try {
      return await UrlOptions.launchWeb(twitterUrl);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> contactWhatsapp(String whatsappUrl) async {
    try {
      return await UrlOptions.launchWeb(whatsappUrl, launchModeEXT: true);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> contactEmail(String email) async {
    try {
      return await UrlOptions.sendEmail(email);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> contactDevEmail(String email) async {
    try {
      return await UrlOptions.sendEmail(email);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> contactDevTwitter(String twitterUrl) async {
    try {
      return await UrlOptions.launchWeb(twitterUrl, launchModeEXT: true);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}

final helpCenterImplProvider = Provider<HelpCenterImpl>((ref) {
  return HelpCenterImpl();
});
