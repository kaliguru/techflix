
import 'package:play_lab/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';


class SplashRepo{

  ApiClient apiClient;

  SplashRepo({required this.apiClient});


  Future<dynamic> getOnboardingData() async {
    ResponseModel model = await apiClient.request(
        '${UrlContainer.baseUrl}${UrlContainer.onboardingEndPoint}',
        Method.getMethod,
        null);
    return model;
  }




}