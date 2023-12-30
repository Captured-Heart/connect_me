import 'package:connect_me/app.dart';

abstract class ProfileRepository {
  Future<AuthUserModel> fetchProfile({required String uuid});
  Future<List<AuthUserModel>> fetchContactsProfile({required List<String> uuid});

  Future<List<WorkExperienceModel>> fetchWorkList({required String uuid});
  Future<List<String?>> fetchListOfConnectsUuid({
    required String uuid,
  });
  Future<List<EducationModel>> fetchEducationList({required String uuid});
}
