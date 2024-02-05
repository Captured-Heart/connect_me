import 'package:connect_me/app.dart';

abstract class ProfileRepository {
  Future<AuthUserModel> fetchProfile({required String uuid});
  Future<List<AuthUserModel>> fetchContactsProfile({required List<String> uuid});

  Future<List<WorkExperienceModel>> fetchWorkList({required String uuid});
  Future<List<String?>> fetchListOfConnectsUuid({required String uuid});
  Future<List<EducationModel>> fetchEducationList({required String uuid});
}

  // Future<Either<AppException, AuthUserModel>> fetchProfile({required String uuid});
  // Future<Either<AppException, List<AuthUserModel>>> fetchContactsProfile(
  //     {required List<String> uuid});

  // Future<Either<AppException, List<WorkExperienceModel>>> fetchWorkList({required String uuid});
  // Future<Either<AppException, List<String?>>> fetchListOfConnectsUuid({required String uuid});
  // Future<Either<AppException, List<EducationModel>>> fetchEducationList({required String uuid});