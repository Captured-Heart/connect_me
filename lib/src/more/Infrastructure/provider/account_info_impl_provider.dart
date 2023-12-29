import 'package:connect_me/app.dart';

final accountInfoImplProvider = Provider<AccountInfoImpl>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  final firebaseStorage = ref.read(firebaseStorageProvider);
  return AccountInfoImpl(
      firebaseFirestore: firebaseFirestore, firebaseStorage: firebaseStorage);
});
