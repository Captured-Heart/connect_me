import 'package:connect_me/app.dart';

enum AuthErrors {
  requiredValue('this is a required field'),
  allFieldsAreRequired('*All fields are required'),

  phoneValidation('Please provide a valid phone number'),
  passwordIsNotStrong('password is not strong enough'),
  passwordMustBeAtleast('password must be at least 8 digits long'),
  passwordMustHaveaSymbol('passwords must have at least one special character'),
  passwordIsRequired('password is required'),
  serverFailure('Oops! Something went wrong.'),
  networkFailure('Unhealthy network, check and try again!'),
  accountAlreadyExist(
      'An account already exists with the same email address but different sign-in credentials'),
  otpisInvalid('otp code is invalid'),
  requiresRecentLogin('You may need to sign in again before retrying this operation'),
  emailAlreadyInUse('Email exists already'),
  invalidEmail('This email is invalid!'),
  userDisabled('This account is disabled!'),
  userNotFound('This account cannot be found'),
  userIsLoggedOut('User is logged out'),
  tooManyRequests('try again later, too many requests'),
  networkRequestFailed('Network error, try again'),
  wrongPassword('The password is incorrect'),
  credentialsAlreadyInUse('login details is already associated with another user account'),
  invalidLoginCredentials('invalid login credentials'),

  passwordDoesNotMatch('passwords do not match');

  const AuthErrors(this.errorMessage);
  final String errorMessage;
}

Left<AppException, User> firebaseAuthExceptionSwitch(FirebaseAuthException e) {
  return switch (e.code) {
    'invalid-email' => Left(AppException(AuthErrors.invalidEmail.errorMessage)),
    'user-disabled' => Left(AppException(AuthErrors.userDisabled.errorMessage)),
    'user-not-found' => Left(AppException(AuthErrors.userNotFound.errorMessage)),
    'too-many-requests' => Left(AppException(AuthErrors.tooManyRequests.errorMessage)),
    'email-already-in-use' => Left(AppException(AuthErrors.emailAlreadyInUse.errorMessage)),
    'account-exists-with-different-credential' =>
      Left(AppException(AuthErrors.accountAlreadyExist.errorMessage)),
    'requires-recent-login' => Left(AppException(AuthErrors.requiresRecentLogin.errorMessage)),
    'credential-already-in-use' =>
      Left(AppException(AuthErrors.credentialsAlreadyInUse.errorMessage)),
    'network-request-failed' => Left(AppException(AuthErrors.networkFailure.errorMessage)),
    _ => Left(AppException(AuthErrors.serverFailure.errorMessage))
  };
}
