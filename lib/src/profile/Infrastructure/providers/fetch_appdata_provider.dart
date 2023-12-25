import 'package:connect_me/app.dart';
import 'package:connect_me/src/profile/Domain/entities/entities.dart';

final fetchAppDataProvider = FutureProvider.autoDispose<AppDataModel>((ref) async {
//
  final fetchDataImpl = ref.read(fetchDataImplProvider);
  return await fetchDataImpl.fetchAppData();
});
