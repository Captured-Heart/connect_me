import 'package:connect_me/app.dart';

class WorkExperienceImpl implements WorkExperienceRepository {
  final FirebaseFirestore _firebaseFirestore;

  WorkExperienceImpl(this._firebaseFirestore);

  @override
  Future<Either<AppException, void>> addWorkExperience({
    required String uuid,
    required String docId,
    required MapDynamicString map,
  }) async {
    try {
      var addWorkDetails = _firebaseFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid)
          .collection(FirebaseCollectionEnums.workExperience.value)
          .doc(docId);

      return Right(addWorkDetails.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> deleteWorkExperience({
    required String uuid,
    required String docId,
  }) async {
    try {
      var deleteWorkDetails = _firebaseFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid)
          .collection(FirebaseCollectionEnums.workExperience.value)
          .doc(docId);

      return Right(deleteWorkDetails.delete());
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> editWorkExperience() {
    throw UnimplementedError();
  }
}

final workExperienceImplProvider = Provider<WorkExperienceImpl>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return WorkExperienceImpl(cloudFirestore);
});
