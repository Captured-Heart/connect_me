import 'package:connect_me/app.dart';

abstract class ProfileRepository {
  Future<AuthUserModel> fetchProfile({required String uuid});
  Future<List<AuthUserModel>> fetchContactsProfile({required List<String> uuid});

  Future<MapDynamicString> fetchWork({required String uuid});
  Future<List<String?>> fetchListOfConnects({
    required String uuid,
  });
  Future<List<EducationModel>> fetchEducationList({required String uuid});
}
