import 'package:connect_me/app.dart';
import 'package:connect_me/src/profile/Domain/entities/entities.dart';

class FetchAppDataImpl extends FetchAppDataRepository {
  final FirebaseFirestore _firebaseFirestore;

  FetchAppDataImpl(this._firebaseFirestore);

  @override
  Future<AppDataModel> fetchAppData() async {
    var appData = _firebaseFirestore
        .collection(FirebaseCollectionEnums.appData.value)
        .doc('socialMediaSupports')
        .get();
    return appData.then((value) => AppDataModel.fromJson(value.data()!));
  }
}

final fetchDataImplProvider = Provider<FetchAppDataImpl>((ref) {
  final cloudFirestore = ref.read(cloudFirestoreProvider);
  return FetchAppDataImpl(cloudFirestore);
});
