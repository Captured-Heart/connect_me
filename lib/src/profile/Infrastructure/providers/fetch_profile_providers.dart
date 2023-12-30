import 'package:connect_me/app.dart';

// !fetch profile
final fetchProfileProvider =
    FutureProvider.autoDispose.family<AuthUserModel, String>((ref, uuidOthers) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchProfile(
      uuid: uuidOthers.isNotEmpty == true ? uuidOthers : uuid);
});


//! fetch work experience
final fetchWorkListProvider = FutureProvider.autoDispose<List<WorkExperienceModel>>((ref) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchWorkList(uuid: uuid);
});
