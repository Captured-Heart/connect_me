import 'package:connect_me/app.dart';

class AddUsersToContactNotifier extends StateNotifier<AsyncValue> {
  AddUsersToContactNotifier(this.uuid, this._contactRepositoryImpl)
      : super(const AsyncValue.data(null));

  final String uuid;
  final ContactRepositoryImpl _contactRepositoryImpl;

  Future addUsersToContactsMethod({
    required MapDynamicString map,
    required String docId,
  }) async {
    state = const AsyncValue.loading();
    var addToContact = await _contactRepositoryImpl.addUsersToContact(map: map, docId: docId);

    state = addToContact.fold(
      (failure) {
        return AsyncValue.error(failure, StackTrace.current);
      },
      (success) {
        return const AsyncValue.data(
          TextConstant.successful,
        );
      },
    );
  }
}

final addUsersToContactNotifierProvider =
    StateNotifierProvider<AddUsersToContactNotifier, AsyncValue>((ref) {
  final contactRepositoryImpl = ref.read(contactRepositoryImplProvider);
  final uuid = ref.read(currentUUIDProvider);
  return AddUsersToContactNotifier(uuid, contactRepositoryImpl);
});
