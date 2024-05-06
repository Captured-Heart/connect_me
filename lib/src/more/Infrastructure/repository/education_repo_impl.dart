
import '../../../../app.dart';

class EducationRepositoryImpl extends EducationRepository {
  final FirebaseFirestore cloudFirestore;

  EducationRepositoryImpl(this.cloudFirestore);

  @override
  Future<Either<AppException, void>> addEducationInfo({
    required String uuid,
    required MapDynamicString map,
    required String docId,
  }) async {
    try {
      var addEducationDetails = cloudFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid)
          .collection(FirebaseCollectionEnums.education.value)
          .doc(docId);
      // .add(map);

      return Right(addEducationDetails.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> deleteEducationInfo(
      {required String uuid, required String docId}) async {
    try {
      var deleteInfo = cloudFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid)
          .collection(FirebaseCollectionEnums.education.value)
          .doc(docId);
      return Right(deleteInfo.delete());
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}

final educationImplProvider = Provider<EducationRepository>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return EducationRepositoryImpl(cloudFirestore);
});
