

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:play_lab/constants/method.dart';
import 'package:play_lab/data/services/api_service.dart';

import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/auth/registration_response_model.dart';
import '../../model/auth/sign_up_model/sign_up_model.dart';


class SignupRepo {
  ApiClient apiClient;

  SignupRepo({required this.apiClient});

  Future<RegistrationResponseModel> registerUser(SignUpModel model) async {
    final map = modelToMap(model);

    String url ='${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';


    final res=await apiClient.request(url, Method.postMethod, map,passHeader: true,isOnlyAcceptType: true);



    final json = jsonDecode(res.responseJson);


    RegistrationResponseModel responseModel = RegistrationResponseModel
        .fromJson(json);

   return responseModel;
  }

  Map<String, dynamic> modelToMap(SignUpModel model) {

    Map<String, dynamic> bodyFields = {
      'mobile':model.mobile,
      'email': model.email,
      'agree': model.agree.toString(),
      'username': model.username,
      'password': model.password,
      'password_confirmation':model.password,//password and confirm password check from front end panel
      'country_code': model.countryCode, //model.country_code,
      'country': model.country, //model.country,
      "mobile_code": model.mobileCode,
    };

    return bodyFields;
  }

}