//
import 'package:connect_me/app.dart';

final fetchContactsProvider = FutureProvider.autoDispose<List<AuthUserModel>>((ref) async {
  //user uuid
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//fetch profile implementation
  final fetchProfileRepoImpl = ref.read(fetchProfileRepoImplProvider);

// list of the uuid strings
  var uuidList = await fetchProfileRepoImpl.fetchListOfConnects(uuid: uuid);

  return fetchProfileRepoImpl.fetchContactsProfile(uuid: uuidList);
});
