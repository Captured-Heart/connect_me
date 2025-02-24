

import '../../../../app.dart';

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

  @override
  Future<Either<AppException, void>> deleteSocialMedia({
    required String uuid,
    required String socialKey,
  }) async {
    try {
      var deleteSocialMediaDetails =
          cloudFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);

      var completeMapFromGet = await deleteSocialMediaDetails
          .get()
          .then((value) => AuthUserModel.fromJson(value.data()!).socialMediaHandles);
      completeMapFromGet?.remove(socialKey);

      //
      log('this is current map: $completeMapFromGet');

      inspect(completeMapFromGet);

      return Right(
        deleteSocialMediaDetails
            .update({FirebaseDocsFieldEnums.socialMediaHandles.name: completeMapFromGet}),
      );
      // throw Left(AppException('testing'));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}

final socialMediaImplProvider = Provider<SocialMediaRepository>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return SocialMediaImpl(cloudFirestore);
});
