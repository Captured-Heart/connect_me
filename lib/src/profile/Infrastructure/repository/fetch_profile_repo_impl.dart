// import 'dart:developer';

import 'package:connect_me/app.dart';

//TODO: ADD EITHER TO THE FUNCTIONS HERE, TO SEPERATE ERROR CONDITONS
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

  // // ! fetch the list of contacts profile
  // @override
  // Future<List<AuthUserModel>> fetchContactsProfile({required List<String?> uuid}) async {
  //   try {
  //     if (uuid.isEmpty) {
  //       throw TextConstant.noRecordFound;
  //     }
  //     var result = await _firebaseFirestore
  //         .collection(FirebaseCollectionEnums.users.value)
  //         .where(
  //           FirebaseDocsFieldEnums.docId.name,
  //           whereIn: uuid,
  //         )
  //         .get();
  //     return result.docs.map((e) => AuthUserModel.fromJson(e.data())).toList();
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}

// // import 'dart:developer';

// import 'package:connect_me/app.dart';

// class FetchProfileRepoImpl implements ProfileRepository {
//   final FirebaseFirestore _firebaseFirestore;

//   FetchProfileRepoImpl(this._firebaseFirestore);

// //!  FETCH PROFILE
//   @override
//   Future<Either<AppException, AuthUserModel>> fetchProfile({required String uuid}) async {
//     try {
//       if (uuid.isEmpty) {
//         return const Left(AppException(TextConstant.noUserFound));
//       } else {
//         var result = _firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);

//         return Right(await result.get().then((value) => AuthUserModel.fromJson(value.data()!)));
//       }
//     } catch (e) {
//       return Left(AppException(e.toString()));
//     }
//   }

// //! fetch list of connects uuid
//   @override
//   Future<Either<AppException, List<String?>>> fetchListOfConnectsUuid(
//       {required String uuid}) async {
//     try {
//       if (uuid.isEmpty) {
//         return const Left(AppException(TextConstant.noUserFound));
//       } else {
//         var result = await _firebaseFirestore
//             .collection(FirebaseCollectionEnums.connects.value)
//             .where(FirebaseDocsFieldEnums.userId.name, isEqualTo: uuid)
//             .get();

//         return Right(result.docs.map((e) => AuthUserModel.fromJson(e.data()).connectTo).toList());
//       }
//     } catch (e) {
//       return Left(AppException(e.toString()));
//     }
//   }

// //! fetch work is just for debugging
//   @override
//   Future<Either<AppException, List<WorkExperienceModel>>> fetchWorkList({
//     required String uuid,
//   }) async {
//     try {
//       if (uuid.isEmpty) {
//         return const Left(AppException(TextConstant.noRecordFound));
//       } else {
//         var result = _firebaseFirestore
//             .collection(FirebaseCollectionEnums.users.value)
//             .doc(uuid)
//             .collection(FirebaseCollectionEnums.workExperience.value)
//             .get();
//         // inspect(result.get().then((value) => value));

//         return Right(await result.then(
//             (value) => value.docs.map((e) => WorkExperienceModel.fromJson(e.data())).toList()));
//       }
//     } catch (e) {
//       return Left(AppException(e.toString()));
//     }
//   }

//   //! FETCH EDUCATION LIST
//   @override
//   Future<Either<AppException, List<EducationModel>>> fetchEducationList(
//       {required String uuid}) async {
//     try {
//       if (uuid.isEmpty) {
//         return const Left(AppException(TextConstant.noRecordFound));
//       } else {
//         var result = _firebaseFirestore
//             .collection(FirebaseCollectionEnums.users.value)
//             .doc(uuid)
//             .collection(FirebaseCollectionEnums.education.value);

//         return Right(await result
//             .get()
//             .then((value) => value.docs.map((e) => EducationModel.fromJson(e.data())).toList()));
//       }
//     } catch (e) {
//       return Left(AppException(e.toString()));
//     }
//   }

//   // ! fetch the list of contacts profile
//   @override
//   Future<Either<AppException, List<AuthUserModel>>> fetchContactsProfile(
//       {required List<String?> uuid}) async {
//     try {
//       if (uuid.isEmpty) {
//         return const Left(AppException(TextConstant.noContactsFound));
//       } else {
//         var result = await _firebaseFirestore
//             .collection(FirebaseCollectionEnums.users.value)
//             .where(
//               FirebaseDocsFieldEnums.docId.name,
//               whereIn: uuid,
//             )
//             .get();
//         return Right(result.docs.map((e) => AuthUserModel.fromJson(e.data())).toList());
//       }
//     } catch (e) {
//       return Left(AppException(e.toString()));
//     }
//   }
// }
