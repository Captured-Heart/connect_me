// import 'dart:developer';

import 'package:connect_me/app.dart';

class FetchProfileRepoImpl implements ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  FetchProfileRepoImpl(this._firebaseFirestore);

  @override
  Future<AuthUserModel> fetchProfile({required String uuid}) async {
    var result = _firebaseFirestore
        .collection(FirebaseCollectionEnums.users.value)
        .doc(uuid);
    // inspect(result.get().then((value) => value));
    return result.get().then((value) => AuthUserModel.fromJson(value.data()!));
  }

  @override
  Stream<List<AuthUserModel>> fetchListOfConnects(
      {required List<dynamic> connectsList}) async* {
    var result = _firebaseFirestore
        .collection(FirebaseCollectionEnums.users.value)
        .snapshots();

    var finalList = result.map((event) => event.docs).map(
          (event) => List.generate(
            connectsList.length,
            (index) => AuthUserModel.fromJson(
              event[index].data(),
            ),
          ),
        );

    yield* finalList;
  }

  @override
  Future<MapDynamicString> fetchWork({required String uuid}) {
    var result = _firebaseFirestore
        .collection(FirebaseCollectionEnums.users.value)
        .doc(uuid);
    // inspect(result.get().then((value) => value));
    return result.get().then((value) => value.get('socials'));
  }
}
