import 'package:connect_me/app.dart';

class AddSocialMediaDetailsNotifier extends StateNotifier<AsyncValue> {
  AddSocialMediaDetailsNotifier(
    this.socialMediaImpl,
    this.uuid,
  ) : super(const AsyncValue.data(null));

  final SocialMediaImpl socialMediaImpl;
  final String uuid;
  Future addSocialMediaMethod({required MapDynamicString map}) async {
    state = const AsyncValue.loading();
    var addInfo = await socialMediaImpl
        .addSocialMedia(uuid: uuid, map: {FirebaseDocsFieldEnums.socialMediaHandles.name: map});

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

final addSocialMediaProvider =
    StateNotifierProvider.autoDispose<AddSocialMediaDetailsNotifier, AsyncValue>((ref) {
  final socialMediaImpl = ref.read(socialMediaImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddSocialMediaDetailsNotifier(socialMediaImpl, uuid);
});
