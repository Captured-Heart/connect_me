import 'package:connect_me/app.dart';

abstract class WorkExperienceRepository {
  Future<Either<AppException, void>> addWorkExperience({
    required String uuid,
    required String docId,
    required MapDynamicString map,
  });
  Future<Either<AppException, void>> deleteWorkExperience();
  Future<Either<AppException, void>> editWorkExperience();
}
