import 'package:connect_me/app.dart';

abstract class AccountInfoRepository {
  Future<Either<AppException, void>> addAccountInfo({
    required String uuid,
    required MapDynamicString map,
    required String imgUrl,
  });
}
