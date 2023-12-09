// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/people/v1.dart' as people;
import 'package:googleapis/oauth2/v2.dart' as oauth;

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._firebaseAuth,
    this._googleSignIn,
    this._firebaseFirestore,
  );
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebaseFirestore;

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
    } on FirebaseAuthException catch (e) {
      return Left(AppException(e.message ?? ''));
    }
  }

//! SIGN UP FUNCTION
  @override
  Future<Either<AppException, User?>> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    // try {
    try {
      UserCredential user =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      // await user.user!.sendEmailVerification();
      if (user.user?.uid != null) {
        await _firebaseFirestore
            .collection(FirebaseCollectionEnums.users.value)
            .doc(user.user?.uid)
            .set(AuthUserModel(email: email, docId: user.user?.uid).toJson())
            .onError((error, stackTrace) => throw Left(
                  AppException(
                    error.toString(),
                  ),
                ));
      }

      return Right(user.user);
    } on FirebaseAuthException catch (e) {
      return Left(AppException(e.message ?? ''));
    }
  }

//!SIGN OUT FUNCTION
  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
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

  @override
  Future<Either<AppException, User>> signInWithGoogle() async {
    try {
      GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
      currentUser ??= await _googleSignIn.signInSilently();
      currentUser ??= await _googleSignIn.signIn();

      inspect(currentUser);
      if (currentUser != null) {
        final GoogleSignInAuthentication auth = await currentUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );
        inspect(currentUser);

        final UserCredential response = await _firebaseAuth.signInWithCredential(credential);

        //TODO: CHECK IF THE USER HAS ALREADY BEEN SAVED TO DB
        await _firebaseFirestore
            .collection(FirebaseCollectionEnums.users.value)
            .doc(currentUser.id)
            .set(AuthUserModel(
              email: currentUser.email,
              docId: currentUser.id,
              imgUrl: currentUser.photoUrl ?? '',
              name: currentUser.displayName,
            ).toJson())
            .onError(
              (error, stackTrace) => throw Left(
                AppException(
                  error.toString(),
                ),
              ),
            );
        return Right(response.user!);
      } else {
        return Left(AppException('failed'));
      }
    } on FirebaseAuthException catch (e, stackTrace) {
      switch (e.code) {
        case 'invalid-email':
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
        case 'user-disabled':
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
        case 'user-not-found':
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
        case 'too-many-requests':
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
      }
      Error.throwWithStackTrace(Exception(e.toString()), stackTrace);
    } on PlatformException catch (e, stackTrace) {
      switch (e.code) {
        case GoogleSignIn.kSignInCanceledError:
          Left(
            AppException(e.message ?? ''),
          );
        case GoogleSignIn.kSignInFailedError:
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
        case GoogleSignIn.kNetworkError:
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
        case 'popup_blocked_by_browser':
          Left(Error.throwWithStackTrace(
            AppException(e.message ?? ''),
            stackTrace,
          ));
      }
      Left(Error.throwWithStackTrace(Exception(e.toString()), stackTrace));
    }
  }
}
