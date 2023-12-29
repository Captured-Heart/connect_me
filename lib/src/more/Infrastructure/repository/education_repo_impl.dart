import 'package:connect_me/app.dart';

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
}

final educationImplProvider = Provider<EducationRepositoryImpl>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return EducationRepositoryImpl(cloudFirestore);
});
