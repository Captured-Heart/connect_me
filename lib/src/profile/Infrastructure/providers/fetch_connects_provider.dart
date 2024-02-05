//
import 'package:connect_me/app.dart';

final fetchContactsProvider = FutureProvider.autoDispose<List<AuthUserModel>>((ref) async {
  //user uuid
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//fetch profile implementation
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);

// list of the uuid strings
  var uuidList = await fetchProfileRepoImpl.fetchListOfConnectsUuid(uuid: uuid);

  return fetchProfileRepoImpl.fetchContactsProfile(uuid: uuidList);
});



// final fetchContactsProvider = FutureProvider.autoDispose<List<AuthUserModel>>((ref) async {
//   //user uuid
//   String uuid = ref.watch(authStateChangesProvider).value!.uid;
// //fetch profile implementation
//   final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);

// // list of the uuid strings
//   var uuidList = await fetchProfileRepoImpl.fetchListOfConnectsUuid(uuid: uuid);
//   if (uuidList.isRight()) {
//     var contacts = await fetchProfileRepoImpl.fetchContactsProfile(
//         uuid: uuidList.foldRight([], (r, previous) => r));
//     return contacts.fold((l) {
//       throw l;
//     }, (r) {
//       return r;
//     });
//   } else {
//     throw AsyncValue.error(uuidList.leftMap((l) => l), StackTrace.empty);
//   }

//   // return fetchProfileRepoImpl.fetchContactsProfile(uuid: uuidList);
// });
