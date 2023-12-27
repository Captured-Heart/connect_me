import 'package:connect_me/app.dart';

final fetchAppDataProvider =
    FutureProvider.autoDispose<AppDataModel>((ref) async {
//
  final fetchDataImpl = ref.read(fetchDataImplProvider);
  return await fetchDataImpl.fetchAppData();
});
