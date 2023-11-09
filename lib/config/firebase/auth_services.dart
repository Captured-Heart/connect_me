
// class AuthenticationServices {
//   AuthenticationServices(this._firebaseAuth);
//   final FirebaseAuth _firebaseAuth;

//   Stream<User?> get userChanges => _firebaseAuth.userChanges();

//   User? get userCurrentUUID => _firebaseAuth.currentUser;

// //!SIGN IN FUNCTION
//   Future<UserCredential?> signIn(
//       {required String email, required String password}) async {
//     try {
//       var user = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       return user;
//     } on FirebaseAuthException catch (e) {
//       // return e.message!;
//       throw Exception(e.toString());
//     }
//   }

// //! SIGN UP FUNCTION
//   Future<UserCredential> signUpWithEmail(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       var signUp = await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return signUp;
//       // return 'Successfully Registered, please check your email for verification before you can login';
//     } on FirebaseAuthException catch (e) {
//       // return e.message!;
//       throw Exception(e.toString());
//     }
//   }

// //!SIGN OUT FUNCTION
//   Future<void> signOut() async {
//     try {
//       SharedPreferencesHelper.setBoolPref(SharedPrefKeys.loggedIn.name,
//           value: false);
//       return _firebaseAuth.signOut();
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   //! RESET PASSWORD
//   Future<void> resetPassWord(String email) async {
//     try {
//       return _firebaseAuth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
