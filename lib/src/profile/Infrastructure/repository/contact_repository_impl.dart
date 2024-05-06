

import '../../../../app.dart';

class ContactRepositoryImpl extends ContactRepository {
  final FirebaseFirestore _firebaseFirestore;

  ContactRepositoryImpl(this._firebaseFirestore);

  @override
  Future<Either<AppException, void>> addUsersToContact(
      {required String docId, required MapDynamicString map}) async {
    try {
      var addContact =
          _firebaseFirestore.collection(FirebaseCollectionEnums.connects.name).doc(docId);
      // map.putIfAbsent(FirebaseDocsFieldEnums.userId.name, () => uuid);
      return Right(addContact.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<List<AuthUserModel>> fetchContactsProfile({required String uuid}) async {
    try {
      var connects = await _firebaseFirestore
          .collection(FirebaseCollectionEnums.connects.value)
          .where(FirebaseDocsFieldEnums.userId.name, isEqualTo: uuid)
          .get();

      var uuidList =
          connects.docs.map((e) => AuthUserModel.fromJson(e.data()).connectTo).toSet().toList();
      uuidList.remove(null);
      if (uuidList.isEmpty) {
        throw TextConstant.noRecordFound;
      }

      var result = await _firebaseFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .where(
            FirebaseDocsFieldEnums.docId.name,
            whereIn: uuidList,
          )
          .get();
      return result.docs.map((e) => AuthUserModel.fromJson(e.data())).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}

final contactRepositoryImplProvider = Provider<ContactRepository>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  return ContactRepositoryImpl(firebaseFirestore);
});
