
import 'dart:convert';

import '../../../constants/method.dart' as m;
import '../../../core/utils/url_container.dart';
import '../../model/deposit/DepositHistoryMainResponseModel.dart';
import '../../model/deposit/InsertDepositResponseModel.dart';
import '../../model/deposit/MainDepositMethodResponseModel.dart';
import '../../services/api_service.dart';



class DepositRepo{

  DepositRepo({required this.apiClient});

  ApiClient apiClient;

  Future<DepositHistoryMainResponseModel> loadAllDepositHistory(int page) async{


    String url ='${UrlContainer.baseUrl}${UrlContainer.depositHistoryEndPoint}$page';


    final response =await apiClient.request(url,m.Method.getMethod, null,passHeader: true);
    DepositHistoryMainResponseModel model= DepositHistoryMainResponseModel.fromJson(jsonDecode(response.responseJson));
    return model;
  }




  Future<MainDepositMethodResponseModel>getDepositMethod()async{


    String url ='${UrlContainer.baseUrl}${UrlContainer.depositMethodEndPoint}';

    final response = await apiClient.request(url, m.Method.getMethod, null,passHeader: true);


    MainDepositMethodResponseModel model= MainDepositMethodResponseModel.fromJson(jsonDecode(response.responseJson));

    if(model.data!=null && !(model.data?.methods==[])){
      model.setCode(200);
      return model;
    }else{
      model.setCode(400);
      return model;
    }

  }

  Future<InsertDepositResponseModel>insertDeposit(double amount, String? methodCode, String? currency,String?subscriptionId) async {
    Map<String,dynamic> mapData=getInsertDepositMap(amount.toString(), methodCode, currency,subscriptionId);


   String url = '${UrlContainer.baseUrl}${UrlContainer.depositInsertEndPoint}';

    final response = await apiClient.request(url, m.Method.postMethod, mapData,passHeader: true);


    InsertDepositResponseModel model= InsertDepositResponseModel.fromJson(jsonDecode(response.responseJson));


      return model;


  }

  Map<String,dynamic> getInsertDepositMap(String? amount,String? methodCode,String? currency,String?subscriptionId){

    Map<String,dynamic>map={
      'amount':amount,
      'method_code':methodCode,
      'currency':currency??'00',
      'subscription_id':subscriptionId??'-1'
    };
    return map;
  }






}