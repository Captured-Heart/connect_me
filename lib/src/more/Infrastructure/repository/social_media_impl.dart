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

  @override
  Future<Either<AppException, void>> deleteSocialMedia({
    required String uuid,
    required String socialKey,
  }) async {
    try {
      Map<String, dynamic>? result = {};

      var deleteSocialMediaDetails =
          cloudFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);

      var completeMapFromGet = await deleteSocialMediaDetails
          .get()
          .then((value) => AuthUserModel.fromJson(value.data()!).socialMediaHandles);
      result = completeMapFromGet;
      completeMapFromGet?.remove(socialKey);
      result?.remove(socialKey);

      //
      log('this is current map: $completeMapFromGet');
      log('this is result map: $result');

      inspect(completeMapFromGet);
      inspect(result);

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

final socialMediaImplProvider = Provider<SocialMediaImpl>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return SocialMediaImpl(cloudFirestore);
});
