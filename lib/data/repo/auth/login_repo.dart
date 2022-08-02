import 'dart:convert';


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:play_lab/constants/method.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/shared_pref_helper.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/auth/verification/email_verification_model.dart';


class LoginRepo extends GetConnect {
  SharedPreferences sharedPreferences;
  ApiClient apiClient;

  LoginRepo({required this.sharedPreferences, required this.apiClient});

  Future<ResponseModel> loginUser(String email,String password) async{

    Map<String, String> map = {'username': email, 'password': password};

    String url =
        '${UrlContainer.baseUrl}${UrlContainer.loginEndPoint}';

    ResponseModel model=await apiClient.request(url, Method.postMethod, map,passHeader: false);

    return model;

  }

  rememberMe() {}

  //forget password all section

  Future<String> forgetPassword(String type, String value) async {
    final map = modelToMap(value, type);
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.forgetPasswordEndPoint}';

    final response=await apiClient.request(url, Method.postMethod,map,isOnlyAcceptType: true,passHeader: true);

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.responseJson));
    if (model.message?.success != null) {
      sharedPreferences.setString(
          SharedPreferenceHelper.userEmailKey, model.data?.email ?? '');
      String token=model.data?.token??'';
      sharedPreferences.setString(SharedPreferenceHelper.resetPassTokenKey, token);

      CustomSnackbar.showCustomSnackbar(
          errorList: [],
          msg:
              ['Password reset email sent to ${model.data?.email ?? 'your email'}'],
          isError: false);
      return model.data?.email??'';
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: model.message!.error ?? ['Something went wrong'], msg: [''], isError: true);
      return '';
    }
  }

  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  Future<EmailVerificationModel> verifyForgetPassCode(String code) async {
    String? email =
        sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';
    Map<String, String> map = {'code': code, 'email': email};

    Uri url = Uri.parse(
        '${UrlContainer.baseUrl}${UrlContainer.passwordVerifyEndPoint}');

    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.message?.success != null) {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  Future<EmailVerificationModel> resetPassword(
      String email, String password) async {
    String token =
        sharedPreferences.getString(SharedPreferenceHelper.resetPassTokenKey) ??
            '';
    Map<String, String> map = {
      'token': token,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };
    Uri url = Uri.parse(
        '${UrlContainer.baseUrl}${UrlContainer.resetPasswordEndPoint}');
    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
    });
    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.body));
    if (model.message?.success != null) {
      CustomSnackbar.showCustomSnackbar(
          errorList: [],
          msg: [model.message?.success.toString() ?? ''],
          isError: false);
      model.setCode(200);
      return model;
    } else {
      CustomSnackbar.showCustomSnackbar(
          errorList: model.message!.error ?? [], msg: [''], isError: true);
      model.setCode(400);
      return model;
    }
  }
}
