import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/model/auth/login_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/route/route.dart';
import '../../repo/auth/login_repo.dart';


class LoginController extends GetxController{

  
  LoginRepo loginRepo;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

   TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  List<String>errors=[];
  String? email;
  String? password;
  bool isLoading=false;
  bool remember = false;

  LoginController({required this.loginRepo});


  void forgetPassword() {
        Get.toNamed(RouteHelper.forgetPasswordScreen);
  }



  void checkAndGotoNextStep(LoginResponseModel responseModel) async{

    bool needEmailVerification=responseModel.data?.user?.ev=="1"?false:true;
    bool needSmsVerification=responseModel.data?.user?.sv=='1'?false:true;


    if(remember){
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    }else{
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey,false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${responseModel.data?.user?.firstname??''} ${responseModel.data?.user?.lastname??''}');



    if( needSmsVerification==false && needEmailVerification==false ) {
       if(responseModel.data?.user?.regStep=='0'){
         Get.offAndToNamed(RouteHelper.profileComplete);
       }else{
         Get.offAndToNamed(RouteHelper.homeScreen);
       }


    }else if(needSmsVerification==true&&needEmailVerification==true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,arguments: true);
    }else if(needSmsVerification){
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    }else if(needEmailVerification){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,arguments: false);
    }


    changeIsLoading();
    if(remember){
      changeRememberMe();
    }



  }

  void loginUser(String email, String password) async {

   ResponseModel model= await loginRepo.loginUser(email, password);

   if(model.statusCode==200){
     LoginResponseModel loginModel=LoginResponseModel.fromJson(jsonDecode(model.responseJson));
     if(loginModel.status=='error'){
       CustomSnackbar.showCustomSnackbar(errorList: [loginModel.message?.error?.toString()??'user login failed , pls try again'], msg: [], isError: true);
       changeIsLoading();
       return;
     }else{
      checkAndGotoNextStep(loginModel);
     }
   }
   else{
         CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: false);
         changeIsLoading();
   }
  }


  void changeIsLoading(){
    isLoading=!isLoading;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  rememberMe() async {
    await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
  }

  void clearAllSharedData(){
    loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    return;
  }
}