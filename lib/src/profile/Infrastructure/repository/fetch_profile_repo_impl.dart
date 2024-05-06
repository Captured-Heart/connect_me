// import 'dart:developer';

//TODO: USE RECORDS HERE, ADD EITHER TO THE FUNCTIONS HERE, TO SEPERATE ERROR CONDITONS,
import '../../../../app.dart';

class FetchProfileRepoImpl implements ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  FetchProfileRepoImpl(this._firebaseFirestore);

//!  FETCH PROFILE
  @override
  Future<AuthUserModel> fetchProfile({required String uuid}) async {
    // try {
    if (uuid.isEmpty) {
      throw TextConstant.noUserFound;
    }
    var result =
        await _firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid).get();
    if (result.exists) {
      return AuthUserModel.fromJson(result.data()!);
    } else {
      throw TextConstant.noUserFound;
    }
    // } catch (e) {
    //   throw e.toString();
    // }
  }

//! fetch work experience
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
        return WorkExperienceModel.fromJson(
          e.data(),
        );
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
}
