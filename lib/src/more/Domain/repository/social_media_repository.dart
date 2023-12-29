import 'package:connect_me/app.dart';

abstract class SocialMediaRepository {
  Future<Either<AppException, void>> addSocialMedia({
    required String uuid,
    required MapDynamicString map,
  });
}
