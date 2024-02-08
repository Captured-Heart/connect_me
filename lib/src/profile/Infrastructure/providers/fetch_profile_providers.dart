import 'package:connect_me/app.dart';

// !fetch profile
final fetchProfileProvider = FutureProvider.autoDispose<AuthUserModel>((ref) async {
  String? uuid = ref.read(authStateChangesProvider).value?.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  if (uuid?.isNotEmpty == true || uuid != null) {
    return await fetchProfileRepoImpl.fetchProfile(uuid: uuid!);
  } else {
    throw 'Users not found';
  }
  // return await fetchProfileRepoImpl.fetchProfile(uuid: uuid);
});

//! fetch profile others
final fetchOthersProfileProvider =
    FutureProvider.family.autoDispose<AuthUserModel, String?>((ref, otherUuid) async {
  String uuid = ref.read(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchProfile(
      uuid: otherUuid?.isEmpty == false || otherUuid == null ? otherUuid! : uuid);
});

//! fetch work experience
final fetchWorkListProvider =
    FutureProvider.autoDispose.family<List<WorkExperienceModel>, String?>((ref, uuid) async {
  String userUuid = ref.read(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchWorkList(
      uuid: uuid?.isEmpty == true || uuid == null ? userUuid : uuid);
});

//! fetch Education experience
final fetchEducationListProvider =
    FutureProvider.autoDispose.family<List<EducationModel>, String?>((ref, uuid) async {
  String userUuid = ref.read(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchEducationList(
      uuid: uuid?.isEmpty == true || uuid == null ? userUuid : uuid);
});
