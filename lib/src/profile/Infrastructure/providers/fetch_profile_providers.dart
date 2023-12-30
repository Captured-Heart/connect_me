import 'package:connect_me/app.dart';

final fetchProfileProvider =
    FutureProvider.autoDispose.family<AuthUserModel, String>((ref, uuidOthers) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchProfile(
      uuid: uuidOthers.isNotEmpty == true ? uuidOthers : uuid);
  // return await fetchProfileRepoImpl.fetchProfile(uuid: uuid);
});

final fetchWorkProvider = FutureProvider.autoDispose<MapDynamicString>((ref) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchWork(uuid: uuid);
  // return await fetchProfileRepoImpl.fetchProfile(uuid: uuid);
});
