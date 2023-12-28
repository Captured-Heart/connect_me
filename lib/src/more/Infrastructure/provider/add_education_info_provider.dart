import 'package:connect_me/app.dart';

class AddEducationInfoNotifier extends StateNotifier<AsyncValue> {
  AddEducationInfoNotifier(
    this.educationRepositoryImpl,
    this.uuid,
  ) : super(const AsyncValue.data(null));

  final EducationRepositoryImpl educationRepositoryImpl;
  final String uuid;
  Future addEducationInfoMethod({
    required MapDynamicString map,
    required String docId,
  }) async {
    // loading
    state = const AsyncValue.loading();

    //
    var addInfo = await educationRepositoryImpl.addEducationInfo(
      uuid: uuid,
      map: {FirebaseDocsFieldEnums.educationInfo.name: map},
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

final addEducationInfoProvider =
    StateNotifierProvider.autoDispose<AddEducationInfoNotifier, AsyncValue>((ref) {
  final educationImpl = ref.read(educationImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddEducationInfoNotifier(educationImpl, uuid);
});
