import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/data/model/subscribe_plan/buy_subscribe_plan_response_model/BuySubscribePlanResponseModel.dart';
import 'package:play_lab/data/model/subscribe_plan/subscribe_plan_response_model/SubscribePlanResponseModel.dart';
import 'package:play_lab/data/repo/subscribe_plan_repo/subscribe_plan_repo.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class SubscribePlanController extends GetxController {
  SubscribePlanRepo repo;

  SubscribePlanController({required this.repo});

  String? nextPageUrl;
  bool isLoading = true;
  bool isBuyPlanClick = false;
  List<Data> planList = [];
  int selectedIndex = -1;
  String portraitImagePath = '';

  String currency='\$';

  int page = 0;

  void fetchInitialPlan() async {

    updateStatus(true);
    page = 1; //page+1;

    currency=repo.apiClient.getGSData().data?.generalSetting?.curText??'USD';
    ResponseModel model = await repo.getPlan(page: page);
    if (model.statusCode == 200) {
      SubscribePlanResponseModel responseModel =
          SubscribePlanResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>? tempPlanList = responseModel.data?.plans?.data;
      nextPageUrl = responseModel.data?.plans?.nextPageUrl;
      portraitImagePath = responseModel.data?.image ?? '';

      if (tempPlanList != null && !(tempPlanList == [])) {
        if (page == 1) {
          planList.clear();
        }
        planList.addAll(tempPlanList);
      }

      updateStatus(false);
    } else {
      updateStatus(false);
    }
  }

  void fetchNewPlanList() async {
    page = page + 1;
    ResponseModel model = await repo.getPlan(page: page);

    if (model.statusCode == 200) {
      SubscribePlanResponseModel responseModel =
          SubscribePlanResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>? tempPlanList = responseModel.data?.plans?.data;
      nextPageUrl = responseModel.data?.plans?.nextPageUrl;

      if (tempPlanList != null && !(tempPlanList == [])) {
        planList.addAll(tempPlanList);
      }
      update();
    }
  }

  updateStatus(bool status) {
    isLoading = status;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null ? true : false;
  }

  void clearAllData() {
    page = 0;
    isLoading = true;
    nextPageUrl = null;
    planList.clear();
  }

  int sIndex=-1;

  void buyPlan(int index) async {
    isBuyPlanClick = true;
    sIndex=index;
    update();
    try{

      ResponseModel response = await repo.buyPlan(planList[index].id?.toInt() ?? 0);

      if (response.statusCode == 200) {
        BuySubscribePlanResponseModel bModel=BuySubscribePlanResponseModel.fromJson(jsonDecode(response.responseJson));
        if(bModel.status=='success'){
          isBuyPlanClick=false;
          update();
         final res= Get.toNamed(RouteHelper.depositScreen,arguments: [planList[index].pricing,planList[index].name,planList[index].id.toString()]);
        }else{
          CustomSnackbar.showCustomSnackbar(errorList: [bModel.message?.error?.toString()??'Failed to buy subscribe plan'], msg:[''], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(
            errorList: [response.message], msg: [], isError: true);
      }
    }finally{

    }

    isBuyPlanClick = false;
    update();
  }
}
