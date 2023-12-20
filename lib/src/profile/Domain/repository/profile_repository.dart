import 'package:connect_me/app.dart';

abstract class ProfileRepository {
  Future<AuthUserModel> fetchProfile({required String uuid});
  Stream<List<AuthUserModel>> fetchListOfConnects(
      {required List<dynamic> connectsList});
}
