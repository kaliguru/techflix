
import 'dart:async';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/helper/shared_pref_helper.dart';
import '../../../../core/route/route.dart';

import '../../../../view/components/show_custom_snackbar.dart';
import '../../../repo/auth/sms_email_verification_repo.dart';


class EmailVerificationController extends GetxController implements GetxService{

  bool dataLoading=true;
  bool isLoading=false;
  SmsEmailVerificationRepo repo;
  SharedPreferences sharedPreferences;
 EmailVerificationController({required this.repo,required this.sharedPreferences});

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController = StreamController<ErrorAnimationType>();
  bool hasError = false;
  String currentText = "";



 /*
  final emailCodeController=TextEditingController();*/

  bool needSmsVerification=false;

 String get getUserEmailAddress=>sharedPreferences.getString(SharedPreferenceHelper.userEmailKey)??'';

  verifySms()async{

  }

 loadData()async{
    errorController = StreamController<ErrorAnimationType>();
    dataLoading=true;
   await repo.sendAuthorizationRequest();
   dataLoading=false;
   update();
 }

  /*@override
  void dispose() {
    //textEditingController.clear();
    super.dispose();
  }*/

verifyEmail(String text)async{
    changeIsLoadingStatus(true);
   if(text.isEmpty){
     //show snackbar
     return;
   }

   final bool isSuccess=await repo.verify(text,isEmail: true);



   if(isSuccess){
     if(needSmsVerification==true){
       CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.emailOtpSuccessMessage], isError: false);
       Get.offAndToNamed(RouteHelper.smsVerificationScreen);
       changeIsLoadingStatus(false);
     }else{
       Get.offAllNamed(RouteHelper.homeScreen);
       changeIsLoadingStatus(false);
     }
   }else{
     changeIsLoadingStatus(false);
   }

  }

  changeIsLoadingStatus(bool b){
    isLoading=b;
    update();
  }

  Future<void> sendCodeAgain() async {
    await repo.resendVerifyCode(/*'email',*/ isEmail: true);
  }

  void clearData() {
  isLoading=false;
  dataLoading=true;
  /*update();*/
  }

}