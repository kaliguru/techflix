
import 'package:play_lab/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';

class LiveTvRepo{

  ApiClient apiClient;
  LiveTvRepo({required this.apiClient});

  Future<dynamic>getLiveTv()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.liveTelevisionEndPoint}';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;
  }

  Future<dynamic>getLiveTvDetails(int tvId)async{

    String url='${UrlContainer.baseUrl}${UrlContainer.liveTvDetailsEndPoint}$tvId';
    final response=await apiClient.request(url, Method.getMethod, null);
    return response;

  }

}