// import 'package:connect_me/app.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../mocks.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform,
//   // );
//   late LoginWithEmailNotifier loginProvider;
//   final List<AuthUseCaseState> logAuthStates = [];
//   setUp(() {
//     loginProvider = MockLoginProvider();
//   });
//   group('Auth Tests', () {
//     final container = ProviderContainer();
//     final authProvider = container.read(loginWithEmailNotifierProvider.notifier);
//     test('Signing up with wrong details', () async {
//       when(
//         () => authProvider.loggingUser(
//           email: any(),
//           password: any(),
//         ),
//       ).thenAnswer((_) async => Left(AppException(AuthErrors.wrongPassword.errorMessage)));

//       var result = await authProvider.loggingUser(
//         email: 'jayhost001@gmail.com',
//         password: 'Asdf1234',
//       );
//       // var fold = result.fold((l) => Left(l), (r) => Right(r?.uid));

//       expect(result, true);
//     });
//   });
// }
