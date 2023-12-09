import 'package:connect_me/app.dart';

abstract class AuthFirestoreRepo {
  Future<void> createUserDb(User user, MapDynamicString map);
}
