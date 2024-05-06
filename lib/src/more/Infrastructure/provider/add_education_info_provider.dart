
import '../../../../app.dart';

class AddEducationInfoNotifier extends StateNotifier<AsyncValue> {
  AddEducationInfoNotifier(
    this.educationRepositoryImpl,
    this.uuid,
  ) : super(const AsyncValue.data(null));

  final EducationRepository educationRepositoryImpl;
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
      map: map,
      // {FirebaseDocsFieldEnums.educationInfo.name: map},
      docId: docId,
    );

    state = addInfo.fold(
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

  Future deleteEducationMethod({
    required String docId,
  }) async {
    state = const AsyncValue.loading();
//
    var deleteInfo = await educationRepositoryImpl.deleteEducationInfo(
      uuid: uuid,
      docId: docId,
    );

    state = deleteInfo.fold(
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

final addEducationInfoProvider =
    StateNotifierProvider.autoDispose<AddEducationInfoNotifier, AsyncValue>((ref) {
  final educationImpl = ref.read(educationImplProvider);
  final uuid = ref.read(currentUUIDProvider);

  return AddEducationInfoNotifier(educationImpl, uuid);
});
