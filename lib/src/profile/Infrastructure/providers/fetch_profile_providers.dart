import 'package:connect_me/app.dart';

// !fetch profile
final fetchProfileProvider = FutureProvider<AuthUserModel>((ref) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchProfile(uuid: uuid);
});

final fetchOthersProfileProvider =
    FutureProvider.family.autoDispose<AuthUserModel, String?>((ref, otherUuid) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchProfile(
      uuid: otherUuid?.isEmpty == false || otherUuid == null ? otherUuid! : uuid);
});

//! fetch work experience
final fetchWorkListProvider = FutureProvider.autoDispose<List<WorkExperienceModel>>((ref) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchWorkList(uuid: uuid);
});
