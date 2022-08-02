import 'dart:convert';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/account/ProfileResponseModel.dart';
import '../../model/account/user_post_model/UserPostModel.dart';
import '../../model/global/CommonApiResponseModel.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<bool> updateProfile(UserPostModel m,String callFrom) async {
    Map<String, dynamic> map = {
      'firstname': m.firstname,
      'lastname': m.lastName,
      'address': m.address,
      'zip': m.zip,
      'state': m.state,
     'city': m.city,
    };

    String url = '${UrlContainer.baseUrl}${callFrom=='profile'?UrlContainer.updateProfileEndPoint:UrlContainer.profileCompleteEndPoint}';


    ResponseModel responseModel =
        await apiClient.request(url, Method.postMethod, map, passHeader: true);

    if (responseModel.statusCode == 200)
    {
      CommonApiResponseModel model = CommonApiResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      if (model.status == 'success')
      {
        CustomSnackbar.showCustomSnackbar(
            errorList: [],
            msg: [model.message?.success ?? 'Profile Updated Successfully'],
            isError: false);
        return true;
      }

      else
      {
        CustomSnackbar.showCustomSnackbar(
            errorList: [model.message?.success ?? 'Fail to update profile'],
            msg: [],
            isError: true);
        return true;
      }

    }
    else {
      CustomSnackbar.showCustomSnackbar(
          errorList: [responseModel.message], msg: [], isError: true);
          return false;
    }
  }

  Future<ProfileResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';

    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      ProfileResponseModel model =
          ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        return model;
      } else {
        return ProfileResponseModel();
      }
    } else {
      return ProfileResponseModel();
    }
  }

}
