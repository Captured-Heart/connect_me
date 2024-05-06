import '../../../../app.dart';

abstract class ProfileRepository {
  Future<AuthUserModel> fetchProfile({required String uuid});

  Future<List<WorkExperienceModel>> fetchWorkList({required String uuid});
  Future<List<EducationModel>> fetchEducationList({required String uuid});
}
