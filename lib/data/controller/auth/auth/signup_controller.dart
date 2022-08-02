import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/helper/shared_pref_helper.dart';
import '../../../../core/route/route.dart';

import '../../../model/auth/registration_response_model.dart';
import '../../../model/auth/sign_up_model/sign_up_model.dart';
import '../../../model/general_setting/GeneralSettingMainModel.dart';
import '../../../repo/auth/general_setting_repo.dart';
import '../../../repo/auth/signup_repo.dart';

class SignUpController extends GetxController {
  SignupRepo signupRepo;
  SharedPreferences sharedPreferences;

  //phone drop down


  //PrivacyPolicyMainResponseModel privacyPolicyModel=PrivacyPolicyMainResponseModel();

  SignUpController({required this.signupRepo, required this.sharedPreferences});

  bool isLoading = false;
  bool agreeTC = false;

  //general setting
  GeneralSettingMainModel generalSettingMainModel=GeneralSettingMainModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree=true;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();


  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  String? firstName;
  String? lastName;

  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  signUpUser() async {
    isLoading = true;
    update();
    if (!checkAndAddError()) {
      isLoading = false;
      update();
      return;
    } if(errors.isNotEmpty){
      isLoading = false;
      update();
      return;
    }
    SignUpModel model = getUserData();
    final responseModel = await signupRepo.registerUser(model);
    if (responseModel.status == 'success') {
      checkAndGotoNextStep(responseModel);
      isLoading = false;
      update();
    } else {
      CustomSnackbar.showCustomSnackbar(errorList:[responseModel.message?.error ?? ''],msg: [],isError: true);
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  bool checkAndAddError() {
    bool isValid = true;

    if (userNameController.text.isEmpty) {
      isValid = false;
      addError(error: MyStrings.kUserNameNullError);
    }
    if (mobileController.text.isEmpty) {
      isValid = false;
      addError(error: MyStrings.kPhoneNumberNullError);
    }
    if (emailController.text.isEmpty) {
      isValid = false;
      addError(error: MyStrings.kEmailNullError);
    }

    if (passwordController.text.isEmpty) {
      isValid = false;
      addError(error: MyStrings.kInvalidPassError);
    }
      if (isValidPassword(passwordController.text.toString())) {
        removeError(error: MyStrings.kInvalidPassError);
      }
    if (!(cPasswordController.text.toString() ==
        passwordController.text.toString())) {
      isValid = false;
      addError(error: MyStrings.kMatchPassError);
    }else{
      removeError(error: MyStrings.kMatchPassError);
    }


    return isValid;
  }

  final List<String?> errors = [];

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  bool isValidPassword(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {
    SignUpModel model = SignUpModel(
        mobile: mobileController.text.toString(),
        email: emailController.text.toString(),
        agree: agreeTC ? true : false,
        username: userNameController.text.toString(),
        password: passwordController.text.toString(),
        country: countryName.toString(),
      mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
      countryCode: countryCode??'',
       /* mobile_code:
            mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "", mobileCode: '', confirmPassword: '', countryCode: '')*/);

    return model;
  }


  void checkAndGotoNextStep(RegistrationResponseModel responseModel) async {
    bool needEmailVerification =
        responseModel.data?.user?.ev == 1 ? false : true;
    bool needSmsVerification =
        responseModel.data?.user?.sv == 1 ? false : true;

    await sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.accessTokenType,
        responseModel.data?.tokenType ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userEmailKey,
        responseModel.data?.user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey,
        responseModel.data?.user?.mobile ?? '');

    if (needSmsVerification == false && needEmailVerification == false) {
      Get.offNamed(RouteHelper.loginScreen);
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offNamed(RouteHelper.emailVerificationScreen, arguments: true);
    } else if (needSmsVerification) {
      Get.offNamed(RouteHelper.smsVerificationScreen);
    } else {
      Get.offNamed(RouteHelper.emailVerificationScreen, arguments: false);
      //need only email verification
    }
  }

  void closeAllController() {
    isLoading=false;
    errors.clear();
    emailController.text='';
    passwordController.text='';
    cPasswordController.text='';
    fNameController.text='';
    lNameController.text='';
    mobileController.text='';
    countryController.text='';
    userNameController.text='';
  }

  clearAllData() {
    closeAllController();
  }

}
