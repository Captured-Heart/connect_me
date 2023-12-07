// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:connect_me/app.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  String? get currentUUIDProvider => _firebaseAuth.currentUser?.uid;
//!SIGN IN FUNCTION

  @override
  Future<Either<AppException, User?>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result.user);

      // return 'Login Succesfully';
    } on FirebaseAuthException catch (e) {
      showScaffoldSnackBarMessage(e.toString());

      return Left(AppException(e.message ?? ''));
    }
  }

//! SIGN UP FUNCTION
  @override
  Future<Either<AppException, User?>> signUpWithEmail(
      {required String email, required String password}) async {
    // try {
    try {
      UserCredential user =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await user.user!.sendEmailVerification();
      return Right(user.user);
    } on FirebaseAuthException catch (e) {
      showScaffoldSnackBarMessage(
        e.message ?? AuthErrors.serverFailure.errorMessage,
        isError: true,
      );
     return Left(AppException(e.message ?? ''));
    }
  }

//!SIGN OUT FUNCTION
  @override
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  //! RESET PASSWORD
  @override
  Future resetPassWord({required String email}) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return e;
    }
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      log('i am clicking google sign in method');
      var user = await googleSignIn.signIn();
      return user;
    } catch (e) {
      showScaffoldSnackBarMessage(e.toString());
      throw Exception(e);
    }
  }
}
