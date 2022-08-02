
import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/data/repo/live_tv_repo/live_tv_repo.dart';

import '../../model/global/response_model/response_model.dart';
import '../../model/live_tv/LiveTvResponseModel.dart';

class LiveTvController extends GetxController implements GetxService{

  LiveTvRepo repo;
  LiveTvController({required this.repo});


  bool isLoading=true;
  List<MainTelevisionModel>televisionList=[];
  String televisionImagePath='';

  void getLiveTv()async{

    updateLoadingStatus(true);

    ResponseModel model=await repo.getLiveTv();
    if(model.statusCode==200){
      LiveTvResponseModel televisionModel=LiveTvResponseModel.fromJson(jsonDecode(model.responseJson));
      if(televisionModel.data!=null) {
        if(televisionModel.data?.televisions?.data!=null && televisionModel.data!.televisions!.data!.isNotEmpty){
          televisionList.clear();
          televisionList.addAll(televisionModel.data!.televisions!.data!);
          televisionImagePath=televisionModel.data?.imagePath??'';
        }
        updateLoadingStatus(false);
      }
    }else{
      updateLoadingStatus(false);
    }
  }

  void updateLoadingStatus(bool status){
    isLoading=status;
    update();
  }

}