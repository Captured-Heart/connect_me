import 'package:connect_me/app.dart';

final textEditingControllerProvider = Provider<TextEditingControllerClass>((ref) {
  return TextEditingControllerClass();
});

class TextEditingControllerClass {
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
  TextEditingController otpCode = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController apartmentNoController = TextEditingController();
  TextEditingController addressPostalController = TextEditingController();
  TextEditingController searchProductController = TextEditingController();
  TextEditingController searchFruitsController = TextEditingController();

  TextEditingController voucherController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

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
    // phoneNoController.dispose();
    // otpCode.dispose();
  }
}
