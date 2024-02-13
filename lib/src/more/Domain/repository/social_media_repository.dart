import 'package:connect_me/app.dart';

abstract class SocialMediaRepository {
  Future<Either<AppException, void>> addSocialMedia(
      {required String uuid, required MapDynamicString map});

  Future<Either<AppException, void>> deleteSocialMedia(
      {required String uuid, required String socialKey});
}
