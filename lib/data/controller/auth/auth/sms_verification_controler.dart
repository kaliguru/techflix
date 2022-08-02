
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/route/route.dart';

import '../../../../view/components/show_custom_snackbar.dart';
import '../../../model/auth/verification/email_verification_model.dart';
import '../../../repo/auth/sms_email_verification_repo.dart';

class SmsVerificationController extends GetxController implements GetxService{

      SmsEmailVerificationRepo repo;
      SmsVerificationController({required this.repo});


      StreamController<ErrorAnimationType>? errorController= StreamController<ErrorAnimationType>();
      bool hasError = false;
      String currentText = "";



      bool isLoading=false;
      TextEditingController smsController=TextEditingController();


      bool needSmsVerification=false;


      verifySms()async{

      }

     Future<bool> loadBefore()async{
       errorController = StreamController<ErrorAnimationType>();
       smsController=TextEditingController();
        await repo.sendAuthorizationRequest();
        return true;
      }


      @override
      void dispose() {
        errorController!.close();
        super.dispose();
      }

    verifyYourSms()async{

       if(currentText.isEmpty){
         return;
       }
       isLoading=true;
       update();

         bool  isSuccess= await repo.verify(currentText.toString(),isEmail: false,isTFA: false);

       if(isSuccess){
           CustomSnackbar.showCustomSnackbar(errorList: [], msg: [], isError: false);
           Get.offAllNamed(RouteHelper.homeScreen);
       }
       isLoading=false;
       update();
      }

      Future<void> sendCodeAgain() async {
        //.await category_repo.resendVerifyCode('phone');
      }

      clearData(){
        isLoading=false;
        //errorController = StreamController<ErrorAnimationType>();
        errorController?.close();
        smsController.dispose();
        /*textEditingController.text='';
        smsController.text='';*/
      }

}