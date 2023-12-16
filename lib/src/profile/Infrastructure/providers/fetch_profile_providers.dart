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

final fetchContactsProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  return await fetchProfileRepoImpl.fetchProfile(uuid: uuid).then((value) => value.connects ?? []);
});

//
final fetchListProfileProvider = StreamProvider.autoDispose
    .family<List<AuthUserModel>, List<dynamic>>((ref, connectsList) async* {
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);
  yield* fetchProfileRepoImpl.fetchListOfConnects(connectsList: connectsList);
});

// class FetchContactNotifier extends AsyncNotifier<List<Future<AuthUserModel>>> {
//   @override
//   Future<List<Future<AuthUserModel>>> build() async {
//     final fetchProfileRepoImpl = ref.watch(fetchProfileRepoImplProvider);
//     var dooo = fetchProfileRepoImpl.fetchListOfConnects(connectsList: [
//       'AHRx3LI1W0gFuvpMJILp63PPLm92',
//       '115684057306909864809',
//     ]);
//     return dooo;
//   }
// }
