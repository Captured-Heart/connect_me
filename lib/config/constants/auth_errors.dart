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

  passwordDoesNotMatch('passwords do not match');

  const AuthErrors(this.errorMessage);
  final String errorMessage;
}
