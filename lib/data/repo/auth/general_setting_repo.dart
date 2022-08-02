import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:play_lab/data/services/api_service.dart';
import '../../../constants/method.dart';
import '../../model/general_setting/GeneralSettingsResponseModel.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/general_setting/GeneralSettingMainModel.dart';


class GeneralSettingRepo {
  SharedPreferences sharedPreferences;
  ApiClient apiClient;

  GeneralSettingRepo({required this.sharedPreferences,required this.apiClient});


  Future<GeneralSettingsResponseModel> getGeneralSetting() async {
    String url='${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);


    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status=='success') {
        apiClient.storeGeneralSetting(model);
        return model;
      } else {
        List<String>message=['Something Wrong'];
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??message, msg:[], isError: true);
        return model;
      }
    }else{
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg:[], isError: true);
      return GeneralSettingsResponseModel();
    }
  }

  GeneralSettingMainModel getGeneralSettingFromSharedPreferences(){
    GeneralSettingMainModel model;
    if (sharedPreferences.containsKey(SharedPreferenceHelper.generalSettingKey)) {
      String? obj =
      sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey);
      if(obj!=null){
        model=GeneralSettingMainModel.fromJson(jsonDecode(obj));
      }
      model=GeneralSettingMainModel();
      return model;
    } else {
      model=GeneralSettingMainModel();
      return model;
    }
  }

  storeGeneralSetting(GeneralSettingMainModel model){
    String json=jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingMainModel getGSData(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingMainModel model=GeneralSettingMainModel.fromJson(jsonDecode(pre));
    return model;
  }


}
