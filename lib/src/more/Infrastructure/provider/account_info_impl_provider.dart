
import '../../../../app.dart';

final accountInfoImplProvider = Provider<AccountInfoImpl>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  final firebaseStorage = ref.read(firebaseStorageProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return AccountInfoImpl(
    firebaseFirestore: firebaseFirestore,
    firebaseStorage: firebaseStorage,
    firebaseAuth: firebaseAuth,
  );
});
