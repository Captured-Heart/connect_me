import 'package:connect_me/app.dart';

class AddWorkExperienceNotifier extends StateNotifier<AsyncValue> {
  AddWorkExperienceNotifier(
    this.workExperienceImpl,
    this.uuid,
  ) : super(const AsyncValue.data(null));

  final WorkExperienceImpl workExperienceImpl;
  final String uuid;
  Future addWorkExperienceMethod({
    required MapDynamicString map,
    required String docId,
  }) async {
    // loading
    state = const AsyncValue.loading();

    //
    var addInfo = await workExperienceImpl.addWorkExperience(
      uuid: uuid,
      map: {FirebaseDocsFieldEnums.workExperience.name: map},
      docId: docId,
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
}

final addWorkExperienceProvider =
    StateNotifierProvider.autoDispose<AddWorkExperienceNotifier, AsyncValue>(
        (ref) {
  final workExperienceImpl = ref.read(workExperienceImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddWorkExperienceNotifier(workExperienceImpl, uuid);
});
