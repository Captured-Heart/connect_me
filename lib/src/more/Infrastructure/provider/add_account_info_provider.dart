
import '../../../../app.dart';

class AddAccountInfoNotifier extends StateNotifier<AsyncValue> {
  AddAccountInfoNotifier(
    this.accountInfoImpl,
    this.uuid,
  ) : super(const AsyncValue.data(null));

  final AccountInfoImpl accountInfoImpl;
  final String uuid;

  Future addAccountInfo({required MapDynamicString map, required String imgUrl}) async {
    state = const AsyncValue.loading();
    var addInfo = await accountInfoImpl.addAccountInfo(
      uuid: uuid,
      map: map,
      imgUrl: imgUrl,
    );

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

  Future deleteAccountPermanently({required String email, required String uuid}) async {
    state = const AsyncValue.loading();
    var addInfo = await accountInfoImpl.deleteAccount(
      uuid: uuid,
      email: email,
    );

    state = addInfo.fold(
      (failure) {
        log('i am at the failure fold: $failure');
        return AsyncValue.error(failure, StackTrace.current);
      },
      (success) {
        log('It is a success');

        return const AsyncValue.data(
          TextConstant.theUserAccountHasBeenDeleted,
        );
      },
    );
  }

  Future updateScanCount() async {
    state = const AsyncValue.loading();
    var addCount = await accountInfoImpl.updateScanCount(uuid: uuid);

    state = addCount.fold(
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

final addAccountInfoProvider = StateNotifierProvider<AddAccountInfoNotifier, AsyncValue>((ref) {
  final accountInfoImpl = ref.read(accountInfoImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddAccountInfoNotifier(accountInfoImpl, uuid);
});

final deleteAccountInfoProvider = StateNotifierProvider<AddAccountInfoNotifier, AsyncValue>((ref) {
  final accountInfoImpl = ref.read(accountInfoImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddAccountInfoNotifier(accountInfoImpl, uuid);
});
