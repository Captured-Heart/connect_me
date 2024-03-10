// ignore_for_file: prefer_const_constructors

import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';

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
  // var status = Connectivity.instance.isConnected();
//!SIGN IN FUNCTION
  @override
  Future<Either<AppException, User?>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    // var isConnected = await status;
    // if (!isConnected) {
    //   return Left(AppException(AuthErrors.networkFailure.errorMessage));
    // } else {

    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user?.uid != null && result.user?.uid.isNotEmpty == true) {
        SharedPreferencesHelper.setStringPref(SharedKeys.userUID.name, result.user!.uid);
      }
      return Right(result.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return Left(AppException(AuthErrors.invalidEmail.errorMessage));
        case 'user-disabled':
          return Left(AppException(AuthErrors.userDisabled.errorMessage));
        case 'user-not-found':
          return Left(AppException(AuthErrors.userNotFound.errorMessage));
        case 'too-many-requests':
          return Left(AppException(AuthErrors.tooManyRequests.errorMessage));
        case 'wrong-password':
          return Left(AppException(AuthErrors.wrongPassword.errorMessage));
        case 'network-request-failed':
          return Left(AppException(AuthErrors.networkRequestFailed.errorMessage));
        case 'requires-recent-login':
          return Left(AppException(AuthErrors.requiresRecentLogin.errorMessage));
        //
        case 'INVALID_LOGIN_CREDENTIALS':
          return Left(AppException(AuthErrors.invalidLoginCredentials.errorMessage));
        default:
          return Left(AppException(AuthErrors.networkFailure.errorMessage));
      }
    }
    // }
  }

//! SIGN UP FUNCTION
  @override
  Future<Either<AppException, User?>> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    // var isConnected = await status;
    // if (!isConnected) {
    //   return Left(AppException(AuthErrors.networkFailure.errorMessage));
    // } else {
    //   // try {
    try {
      UserCredential user =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      // await user.user!.sendEmailVerification();

      if (user.user?.uid != null) {
        SharedPreferencesHelper.setStringPref(SharedKeys.userUID.name, user.user!.uid);

        await _firebaseFirestore
            .collection(FirebaseCollectionEnums.users.value)
            .doc(user.user?.uid)
            .set(
              AuthUserModel(
                email: email,
                docId: user.user?.uid,
                username: username,
                isGoogleSigned: false,
                completedSignUp: false,
              ).toJson(),
            )
            .onError(
              (error, stackTrace) => throw Left(
                AppException(
                  error.toString(),
                ),
              ),
            );
      }
      return Right(user.user);
    } on FirebaseAuthException catch (e) {
      return firebaseAuthExceptionSwitch(e);
    }
    // }
  }

//!SIGN OUT FUNCTION
  @override
  Future<void> signOut() async {
    // var isConnected = await status;

    // if (!isConnected) {
    //   showScaffoldSnackBarMessage(AuthErrors.networkFailure.errorMessage, isError: true);
    // }

    // else {
    try {
      await _googleSignIn.signOut();
      return await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
    // }
  }

  //! RESET PASSWORD
  @override
  Future resetPassWord({required String email}) async {
    // var isConnected = await status;
    // if (!isConnected) {
    //   showScaffoldSnackBarMessage(AuthErrors.networkFailure.errorMessage, isError: true);
    // } else {

    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      SharedPreferencesHelper.deletePref(SharedKeys.userUID.name);
      SharedPreferencesHelper.deletePref(SharedKeys.token.name);
    } catch (e) {
      return e;
    }
    // }
  }

  @override
  Future<Either<AppException, User>> signInWithGoogle({required bool isSignUp}) async {
    Future<bool> isUserExists(String uid) async {
      var userDoc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      return userDoc.exists;
    }

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
//

        //
        SharedPreferencesHelper.setStringPref(
            SharedKeys.accessToken.name, auth.accessToken ?? 'df');

        final UserCredential response = await _firebaseAuth.signInWithCredential(credential);

        var docId = response.user?.uid;

        final bool doesUserExists = await isUserExists(docId ?? 'e');
        final bool isDocIdNull = docId != null && docId.isNotEmpty == true;
        log('the user exists: $doesUserExists, do is null : $isDocIdNull');
        if (isDocIdNull && !doesUserExists) {
          SharedPreferencesHelper.setStringPref(SharedKeys.userUID.name, docId);

          await _firebaseFirestore
              .collection(FirebaseCollectionEnums.users.value)
              .doc(docId)
              .set(
                AuthUserModel(
                  email: currentUser.email,
                  docId: docId,
                  imgUrl: currentUser.photoUrl ?? '',
                  username: currentUser.displayName,
                  fname: currentUser.displayName,
                  isGoogleSigned: true,
                  completedSignUp: false,
                ).toJson(),
              )
              .onError(
                (error, stackTrace) => throw Left(
                  AppException(
                    error.toString(),
                  ),
                ),
              );
        }

        return Right(response.user!);
      } else {
        return Left(AppException('failed'));
      }
    } on FirebaseAuthException catch (e) {
      return firebaseAuthExceptionSwitch(e);
    } on PlatformException catch (e) {
      switch (e.code) {
        case GoogleSignIn.kSignInCanceledError:
          return Left(
            AppException(e.message ?? ''),
          );
        case GoogleSignIn.kSignInFailedError:
          return Left(
            AppException(e.message ?? ''),
          );
        case GoogleSignIn.kNetworkError:
          return Left(
            AppException(e.message ?? ''),
          );
        case 'account-exists-with-different-credential':
          return Left(AppException(e.message ?? ''));
        case 'popup_blocked_by_browser':
          return Left(
            AppException(e.message ?? ''),
          );
        default:
          return Left(
            AppException(e.message ?? ''),
          );
      }
    }
  }
  // }
}
