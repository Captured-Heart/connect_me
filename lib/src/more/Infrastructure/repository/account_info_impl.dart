import 'dart:io';

import '../../../../app.dart';


class AccountInfoImpl extends AccountInfoRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  AccountInfoImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseAuth,
  });

  @override
  Future<Either<AppException, void>> addAccountInfo({
    required String uuid,
    required MapDynamicString map,
    required String imgUrl,
  }) async {
    try {
      if (imgUrl.isNotEmpty) {
        var imgUrlLink =
            await addImgToStorage(filePath: imgUrl, childPath: uuid).onError((error, stackTrace) {
          throw Left(AppException(error.toString()));
        });
        map.putIfAbsent(FirebaseDocsFieldEnums.imgUrl.name, () => imgUrlLink);
      }

      map.putIfAbsent(FirebaseDocsFieldEnums.completedSignUp.name, () => true);
      var addAccount = firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);
      return Right(addAccount.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<AppException, void>> updateScanCount({required String uuid}) async {
    try {
      var addAccount = firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid);

      return Right(
        addAccount.set(
          {
            FirebaseDocsFieldEnums.scanCount.name: FieldValue.increment(1),
          },
          SetOptions(merge: true),
        ),
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<AppException, void>> deleteAccount({
    required String email,
    required String uuid,
  }) async {
    try {
      // //delete img from storage
      // await deleteImgFromStorage(childPath: uuid);

      //delete connects from cloud firestore
      var connects = await firebaseFirestore
          .collection(FirebaseCollectionEnums.connects.value)
          .where(FirebaseDocsFieldEnums.userId.name, isEqualTo: uuid)
          .get();
      if (connects.docs.isNotEmpty) {
        for (var element in connects.docs) {
          element.reference.delete();
        }
      }

//deleting user records in firetstore and storage
      if (uuid.isNotEmpty == true) {
        var user =
            await firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid).get();
        if (user.exists == true) {
          var userMap = user.data();
          if (userMap?[FirebaseDocsFieldEnums.imgUrl.name] != null) {
            await deleteImgFromStorage(imgUrl: userMap?[FirebaseDocsFieldEnums.imgUrl.name]);
          }
          await user.reference.delete();
          //  await firebaseAuth.currentUser?.delete();
        }
      }
      // await firebaseFirestore.collection(FirebaseCollectionEnums.users.value).doc(uuid).delete();

      var deleteAuthAccount = await firebaseAuth.currentUser?.delete();

      // delete account
      return Right(deleteAuthAccount);
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
        ),
      );
    }
  }
}

Future<String> addImgToStorage({required String filePath, required String childPath}) async {
  // var filePath = 'sddsfv/sfvs';
//   log('''
// $filePath

// This is the file path above

// and childPath:  $childPath
// ''');
  Reference storageRef =
      FirebaseStorage.instance.ref(FirebaseCollectionEnums.accountInfo.value).child(childPath);

  UploadTask putFile = storageRef.putFile(File(filePath));
  TaskSnapshot uploadedFile = await putFile.whenComplete(() {
    log('file has been uploaded');
  });

  return uploadedFile.ref.getDownloadURL();
}

Future<void> deleteImgFromStorage({required String imgUrl}) async {
  var storageRef = FirebaseStorage.instance.refFromURL(imgUrl);
  await storageRef.delete();
  // //check if this file exist before deleting
  // if (url != null || url.isNotEmpty == true || storageRef.fullPath.isNotEmpty == true) {
  //   return storageRef.delete();
  // }

  // return storageRef.delete();
}
