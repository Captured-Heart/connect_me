import 'package:connect_me/app.dart';

class SocialMediaImpl extends SocialMediaRepository {
  final FirebaseFirestore cloudFirestore;

  SocialMediaImpl(this.cloudFirestore);

  @override
  Future<Either<AppException, void>> addSocialMedia(
      {required String uuid, required MapDynamicString map}) async {
    try {
      var addSocialMediaDetails =
          cloudFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);
      return Right(addSocialMediaDetails.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}

final socialMediaImplProvider = Provider<SocialMediaImpl>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return SocialMediaImpl(cloudFirestore);
});
