abstract class HelpCenterRepository {
  Future<void> contactWhatsapp(String whatsappUrl);
  Future<void> contactTwitter(String twitterUrl);
  Future<void> contactEmail(String email);
}
