enum AuthErrors {
  requiredValue('this is a required field'),
  allFieldsAreRequired('*All fields are required'),

  phoneValidation('Please provide a valid phone number'),
  passwordIsNotStrong('password is not strong enough'),
  passwordMustBeAtleast('password must be at least 8 digits long'),
  passwordMustHaveaSymbol('passwords must have at least one special character'),
  passwordIsRequired('password is required'),
  serverFailure('Oops! Something went wrong.'),
  networkFailure('Check your network, and try again!'),

  otpisInvalid('otp code is invalid'),

  invalidEmail('This email is invalid!'),
  userDisabled('This account is disabled!'),
  userNotFound('This account cannot be found'),
  tooManyRequests('try again later, too many requests'),
  networkRequestFailed('Network error, try again'),
  wrongPassword('The password is incorrect'),
  requiresRecentLogin('requires recrent login'),
  invalidLoginCredentials('invalid login credentials'),

  passwordDoesNotMatch('passwords do not match');

  const AuthErrors(this.errorMessage);
  final String errorMessage;
}
