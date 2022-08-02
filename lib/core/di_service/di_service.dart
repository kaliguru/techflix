
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/controller/common/theme_controller.dart';
import '../../data/controller/nav_controller/NavDrawerController.dart';
import '../../data/controller/splash_controller.dart';
import '../../data/repo/auth/general_setting_repo.dart';
import '../../data/repo/splash/splash_repo.dart';
import '../../data/services/api_service.dart';

Future<void>init()async{


  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  Get.lazyPut(()=>ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(()=>GeneralSettingRepo(sharedPreferences: Get.find(),apiClient: Get.find()));
  Get.lazyPut(() =>SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo:Get.find(),repo:Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => NavDrawerController(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

}