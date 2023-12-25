import 'package:connect_me/app.dart';

class WorkExperienceImpl implements WorkExperienceRepository {
  // final FirebaseFirestore _firebaseFirestore;

  @override
  Future<Either<AppException, void>> addWorkExperience() async {
    // try {
    //   // _firebaseFirestore.collection(FirebaseCollectionEnums.users.value);
    // } on AppException catch (e) {}
    throw UnimplementedError();
  }

  @override
  Future<Either<AppException, void>> deleteWorkExperience() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppException, void>> editWorkExperience() {
    throw UnimplementedError();
  }
}
