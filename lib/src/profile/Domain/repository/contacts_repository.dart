import '../../../../app.dart';

abstract class ContactRepository {
  Future<Either<AppException, void>> addUsersToContact(
      {required String docId, required MapDynamicString map});
  Future<List<AuthUserModel>> fetchContactsProfile({required String uuid});
}
