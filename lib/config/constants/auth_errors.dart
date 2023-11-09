enum AuthErrors {
  requiredValue('this is a required field'),
  phoneValidation('Please provide a valid phone number'),
  passwordIsNotStrong('password is not strong enough'),
  passwordMustBeAtleast('password must be at least 8 digits long'),
  passwordMustHaveaSymbol('passwords must have at least one special character'),
  passwordIsRequired('password is required'),
  otpisInvalid('otp code is invalid'),
  passwordDoesNotMatch('passwords do not match');

  const AuthErrors(this.errorMessage);
  final String errorMessage;
}