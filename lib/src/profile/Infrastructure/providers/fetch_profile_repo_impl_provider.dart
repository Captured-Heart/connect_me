import '../../../../app.dart';

final fetchProfileRepoImplProvider = Provider<ProfileRepository>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  return FetchProfileRepoImpl(firebaseFirestore);
});
