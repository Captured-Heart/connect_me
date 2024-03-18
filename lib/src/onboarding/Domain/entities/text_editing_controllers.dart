import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';

final textEditingControllerProvider = Provider<TextEditingControllerClass>((ref) {
  return TextEditingControllerClass();
});

class TextEditingControllerClass {
  final String? fnameText, lnameText, phoneText, webText, bioText;
  TextEditingControllerClass({
    this.fnameText,
    this.lnameText,
    this.phoneText,
    this.webText,
    this.bioText,
  });

  final GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPassformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInformKey = GlobalKey<FormState>();

  TextEditingController passWordController = TextEditingController();
  TextEditingController oldPasWordController = TextEditingController();
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  //WORK EXPERIENCE
  TextEditingController titleController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

//EDUCATION EXPERIENCE
  TextEditingController schoolController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController awardsController = TextEditingController();
  TextEditingController activitiesController = TextEditingController();

// ADDITIONAL DETAILS
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController driverLicencesController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  FocusNode ordersFocusNode = FocusNode();
  FocusNode phoneNoFocusMode = FocusNode();
  FocusNode passwordFocusMode = FocusNode();
  FocusNode emailFocusMode = FocusNode();
  FocusNode userNameFocusMode = FocusNode();

  fieldFocusChange(
    BuildContext context, {
    required FocusNode currentFocus,
    required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // TextEditingController otpCode = TextEditingController();

  void disposeControllers() {
    passWordController.clear();
    emailController.clear();
    usernameController.clear();
  }
}

class TextFieldFormattersHelper {
  static lowerCaseTextFormatter() => LowerCaseTextFormatter();
  static websiteValidator() => websiteValidatorMethod();
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

String? Function(String?)? websiteValidatorMethod() {
  return (p0) {
    RegExp validURL = RegExp(
        r'^((http(s)||http):\/\/.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$');
    if (p0 == null || p0.isEmpty) {
      return TextConstant.required;
    }
    if (p0.startsWith('http') == false) {
      return TextConstant.linkMustStartWithHttps;
    }
    if (!validURL.hasMatch(p0)) {
      return TextConstant.provideAValidUrl;
    }

    return null;
  };
}
