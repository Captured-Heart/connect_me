import 'package:connect_me/app.dart';

abstract class AdditionalDetailsRepository {
  Future<Either<AppException, void>> addAdditionalDetailsInfo({
    required String uuid,
    required MapDynamicString map,
  });
}
