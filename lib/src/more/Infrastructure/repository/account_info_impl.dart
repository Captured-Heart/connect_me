import 'dart:io';

import 'package:connect_me/app.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountInfoImpl extends AccountInfoRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  AccountInfoImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<AppException, void>> addAccountInfo({
    required String uuid,
    required MapDynamicString map,
    required String imgUrl,
  }) async {
    try {
      var imgUrlLink = await addImgToStorage(filePath: imgUrl, childPath: uuid)
          .onError((error, stackTrace) {
        throw Left(AppException(error.toString()));
      });

      map.putIfAbsent(FirebaseDocsFieldEnums.imgUrl.name, () => imgUrlLink);

      var addAccount = firebaseFirestore
          .collection(FirebaseCollectionEnums.users.value)
          .doc(uuid);
      return Right(addAccount.set(map, SetOptions(merge: true)));
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
        ),
      );
    }
  }
}

Future<String> addImgToStorage(
    {required String filePath, required String childPath}) async {
  // var filePath = 'sddsfv/sfvs';
//   log('''
// $filePath

// This is the file path above

// and childPath:  $childPath
// ''');
  Reference storageRef = FirebaseStorage.instance
      .ref(FirebaseCollectionEnums.accountInfo.value)
      .child(childPath);

  UploadTask putFile = storageRef.putFile(File(filePath));
  TaskSnapshot uploadedFile = await putFile.whenComplete(() {
    log('file has been uploaded');
  });

  return uploadedFile.ref.getDownloadURL();
}
