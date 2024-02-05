// import 'dart:developer';

import 'package:connect_me/app.dart';

//TODO: ADD EITHER TO THE FUNCTIONS HERE, TO SEPERATE ERROR CONDITONS
class FetchProfileRepoImpl implements ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  FetchProfileRepoImpl(this._firebaseFirestore);

//!  FETCH PROFILE
  @override
  Future<AuthUserModel> fetchProfile({required String uuid}) async {
    var result = _firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);

    return result.get().then((value) => AuthUserModel.fromJson(value.data()!));
  }

//! fetch list of connects uuid
  @override
  Future<List<String?>> fetchListOfConnectsUuid({required String uuid}) async {
    var result = await _firebaseFirestore
        .collection(FirebaseCollectionEnums.connects.value)
        .where(FirebaseDocsFieldEnums.userId.name, isEqualTo: uuid)
        .get();

    return result.docs.map((e) => AuthUserModel.fromJson(e.data()).connectTo).toList();
  }

//! fetch work is just for debugging
  @override
  Future<List<WorkExperienceModel>> fetchWorkList({
    required String uuid,
  }) async {
    var result = _firebaseFirestore
        .collection(FirebaseCollectionEnums.users.value)
        .doc(uuid)
        .collection(FirebaseCollectionEnums.workExperience.value)
        .get();
    // inspect(result.get().then((value) => value));

    return result.then((value) {
      return value.docs.map((e) {
        return WorkExperienceModel.fromJson(e.data());
      }).toList();
    });
    // docs.map((e) => WorkExperienceModel.fromJson(e.data())).toList();
  }

  //! FETCH EDUCATION LIST
  @override
  Future<List<EducationModel>> fetchEducationList({required String uuid}) async {
    var result = _firebaseFirestore
        .collection(FirebaseCollectionEnums.users.value)
        .doc(uuid)
        .collection(FirebaseCollectionEnums.education.value);

    return result
        .get()
        .then((value) => value.docs.map((e) => EducationModel.fromJson(e.data())).toList());
  }

  // ! fetch the list of contacts profile
  @override
  Future<List<AuthUserModel>> fetchContactsProfile({required List<String?> uuid}) async {
    var result = await _firebaseFirestore
        .collection(FirebaseCollectionEnums.users.value)
        .where(
          FirebaseDocsFieldEnums.docId.name,
          whereIn: uuid,
        )
        .get();
    return result.docs.map((e) => AuthUserModel.fromJson(e.data())).toList();
  }
}
