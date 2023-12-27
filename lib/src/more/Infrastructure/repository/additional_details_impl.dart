import 'package:connect_me/app.dart';

class AdditionalDetailsImpl extends AdditionalDetailsRepository {
  final FirebaseFirestore cloudFirestore;

  AdditionalDetailsImpl(this.cloudFirestore);
  @override
  Future<Either<AppException, void>> addAdditionalDetailsInfo({
    required String uuid,
    required MapDynamicString map,
  }) async {
    try {
      var addAdditionalDetails =
          cloudFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);
      return Right(addAdditionalDetails.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}

final additionalImplProvider = Provider<AdditionalDetailsImpl>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return AdditionalDetailsImpl(cloudFirestore);
});
