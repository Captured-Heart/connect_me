import 'package:connect_me/app.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepositoryImpl {}

class MockLoginProvider extends Mock implements LoginWithEmailNotifier{}

class MockAppException extends Mock implements AppException {}
