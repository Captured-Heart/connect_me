import 'package:connect_me/app.dart';

abstract class EducationRepository {
  Future<Either<AppException, void>> addEducationInfo({
    required String uuid,
    required String docId,
    required MapDynamicString map,
  });
}
