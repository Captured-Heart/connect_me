

import '../../../../app.dart';

class FetchAppDataRepositoryImpl extends FetchAppDataRepository {
  final FirebaseFirestore _firebaseFirestore;

  FetchAppDataRepositoryImpl(this._firebaseFirestore);

  @override
  Future<AppDataModel> fetchAppData() async {
    var appData = _firebaseFirestore
        .collection(FirebaseCollectionEnums.appData.value)
        .doc('socialMediaSupports')
        .get();
    return appData.then((value) => AppDataModel.fromJson(value.data()!));
  }
}

final fetchDataImplProvider = Provider<FetchAppDataRepository>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return FetchAppDataRepositoryImpl(cloudFirestore);
});
