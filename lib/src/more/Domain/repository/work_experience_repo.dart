import 'package:connect_me/app.dart';

abstract class WorkExperienceRepository {
  Future<Either<AppException, void>> addWorkExperience();
  Future<Either<AppException, void>> deleteWorkExperience();
  Future<Either<AppException, void>> editWorkExperience();
}
