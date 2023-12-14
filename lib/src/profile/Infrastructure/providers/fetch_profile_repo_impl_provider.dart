import 'package:connect_me/app.dart';

final fetchProfileRepoImplProvider = Provider<FetchProfileRepoImpl>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  return FetchProfileRepoImpl(firebaseFirestore);
});
