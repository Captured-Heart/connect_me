import '../../../../app.dart';

abstract class FetchAppDataRepository {
  Future<AppDataModel> fetchAppData();
}
