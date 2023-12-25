import 'package:connect_me/app.dart';
import 'package:connect_me/src/profile/Domain/entities/entities.dart';

abstract class FetchAppDataRepository {
  Future<AppDataModel> fetchAppData();
}
