import 'package:connect_me/app.dart';

class AddAdditionalDetailsNotifier extends StateNotifier<AsyncValue> {
  AddAdditionalDetailsNotifier(
    this.additionalDetailsImpl,
    this.uuid,
  ) : super(const AsyncValue.data(null));

  final AdditionalDetailsImpl additionalDetailsImpl;
  final String uuid;
  Future addAdditionalDetails({required MapDynamicString map}) async {
    state = const AsyncValue.loading();
    var addInfo = await additionalDetailsImpl.addAdditionalDetailsInfo(
        uuid: uuid, map: {FirebaseDocsFieldEnums.additionalDetails.name: map});

    state = addInfo.fold(
      (failure) {
        log('i am at the failure fold: $failure');
        return AsyncValue.error(failure, StackTrace.current);
      },
      (success) {
        log('It is a success');

        return const AsyncValue.data(
          TextConstant.successful,
        );
      },
    );
  }
}

final addAdditionalDetailsProvider =
    StateNotifierProvider.autoDispose<AddAdditionalDetailsNotifier, AsyncValue>(
        (ref) {
  final additionalImpl = ref.read(additionalImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddAdditionalDetailsNotifier(additionalImpl, uuid);
});
