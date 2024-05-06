
import '../../../../app.dart';

abstract class AccountInfoRepository {
  Future<Either<AppException, void>> addAccountInfo({
    required String uuid,
    required MapDynamicString map,
    required String imgUrl,
  });

  Future<Either<AppException, void>> updateScanCount({required String uuid});
  Future<Either<AppException, void>> deleteAccount({
    required String email,
    required String uuid,
  });
}
