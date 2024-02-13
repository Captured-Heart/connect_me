import 'package:connect_me/app.dart';

abstract class ContactRepository {
  Future<Either<AppException, void>> addUsersToContact(
      {required String docId, required MapDynamicString map});
  Future<List<AuthUserModel>> fetchContactsProfile({required String uuid});
  // Future<List<String?>> fetchListOfConnectsUuid({required String uuid});
}
