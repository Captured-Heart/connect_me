
import '../../../../app.dart';

abstract class EducationRepository {
  Future<Either<AppException, void>> addEducationInfo({
    required String uuid,
    required String docId,
    required MapDynamicString map,
  });

  Future<Either<AppException, void>> deleteEducationInfo({
    required String uuid,
    required String docId,
  });
}
