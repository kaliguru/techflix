
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';

import '../../../core/helper/string_format_helper.dart';
import '../../../core/route/route.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/deposit/InsertDepositResponseModel.dart';
import '../../model/deposit/MainDepositMethodResponseModel.dart';
import '../../model/general_setting/GeneralSettingsResponseModel.dart';
import '../../repo/deposit_repo/deposit_repo.dart';

class AddNewDepositController extends GetxController implements GetxService{
  DepositRepo depositRepo;
  TextEditingController amountController=TextEditingController();
  bool isLoading=false;
  AddNewDepositController({required this.depositRepo});

  //gs
  GeneralSettingsResponseModel model=GeneralSettingsResponseModel();
  String currency='USD';

  Methods? paymentMethod=Methods();
  String depositLimit='';
   String charge='';


  MainDepositMethodResponseModel depositMethodResponseModel=MainDepositMethodResponseModel();
  List<Methods>paymentMethodList=[];

  setPaymentMethod(Methods?method){
    paymentMethod=method;
    depositLimit='Deposit Limit: ${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(method?.minAmount?.toString()??'-1')} - ${CustomValueConverter.roundDoubleAndRemoveTrailingZero(method?.maxAmount?.toString()??'-1')} $currency';
    charge='Charge: ${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(method?.fixedCharge?.toString()??'0')} + ${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(method?.percentCharge?.toString()??'0')} %';
    update();
  }

  beforeInitLoadData()async{
    setStatusTrue();
    model=depositRepo.apiClient.getGSData();
    currency=model.data?.generalSetting?.curText??'USD';
    depositMethodResponseModel=await depositRepo.getDepositMethod();
    paymentMethodList.clear();

    if(depositMethodResponseModel.code==200){

      List<Methods>?l=depositMethodResponseModel.data?.methods;
      if(l!=null || !(l==[])){
        paymentMethodList.addAll(l!);
      }
      if(paymentMethodList.isNotEmpty){
        try{
          paymentMethod=paymentMethodList[0];
          setPaymentMethod(paymentMethod);
        }finally{

        }

      }
      setStatusFalse();
    }else{
      //fail
      setStatusFalse();
    }


  }

  void submitDeposit(String price,String subscriptionId)async{
    String amount=price;
    if(amount.isEmpty){
      return;
    }
    double amount1=0;
    double maxAmount=0;
   try{
     amount1=double.parse(amount);
     maxAmount=double.parse(paymentMethod?.maxAmount??'0');
   }catch(e){
     return;
   }

   if(maxAmount==0||amount1==0){
     List<String>errorList=['invalid amount'];
     CustomSnackbar.showCustomSnackbar(errorList: errorList, msg: [''], isError: true);
     return;
   }

   setStatusTrue();

  InsertDepositResponseModel mo=await depositRepo.insertDeposit(amount1,paymentMethod?.methodCode,paymentMethod?.currency,subscriptionId);

  if(mo.status!=MyStrings.success){
    List<String>error=[];
    if(mo.status!='success'){
      List<String>?list=[mo.message?.error??'Unknown Error'];
      error.addAll(list);
    }else{
      error.add('undefined error');
    }
    CustomSnackbar.showCustomSnackbar(errorList:error, msg: [''], isError: true);
    setStatusFalse();
  }else{
    String redirectUrl=mo.data?.redirectUrl??'';
    if(redirectUrl.isEmpty){
      List<String>error=['invalid payment url'];
      CustomSnackbar.showCustomSnackbar(errorList:error, msg: [''], isError: false);
    }else{
      amountController.text='';
      showWebView(redirectUrl);
    }
    setStatusFalse();
  }

  }

  setStatusTrue(){
    isLoading = true;
    update();
  }

  setStatusFalse(){
    isLoading=false;
    update();
  }


  void clearData() {
    depositLimit='';
    charge='';
    paymentMethodList.clear();
    amountController.text='';
    setStatusFalse();
  }

  void showWebView(String redirectUrl) {
       Get.toNamed(RouteHelper.customWebviewScreen,arguments: redirectUrl);
  }

}