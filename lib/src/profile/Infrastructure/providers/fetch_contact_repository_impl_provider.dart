import 'package:connect_me/app.dart';

final fetchContactRepoImplProvider = Provider<ContactRepositoryImpl>((ref) {
  final firebaseFirestore = ref.read(cloudFirestoreProvider);
  return ContactRepositoryImpl(firebaseFirestore);
});

//! FETCH CONTACT
final fetchContactsProvider =
    FutureProvider.autoDispose<List<AuthUserModel>>((ref) async {
  //user uuid
  String uuid = ref.watch(authStateChangesProvider).value!.uid;
//fetch profile implementation
  final fetchContactRepoImpl = ref.read(fetchContactRepoImplProvider);

  return fetchContactRepoImpl.fetchContactsProfile(uuid: uuid);
});
