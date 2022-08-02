import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/repo/auth/general_setting_repo.dart';
import 'package:play_lab/data/repo/splash/splash_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

import '../../../data/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SplashRepo(apiClient: Get.find()));
    Get.put(GeneralSettingRepo(
        sharedPreferences: Get.find(), apiClient: Get.find()));
    final controller =
        Get.put(SplashController(splashRepo: Get.find(), repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: MyColor.primaryColor,
          statusBarColor: MyColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light));
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // MyColor.primaryColor,
      body: GetBuilder<SplashController>(builder: (controller) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              PlayAnimation<double>(
                tween: Tween(begin: 0.0, end: 310.0),
                duration: const Duration(seconds: 4),
                curve: Curves.easeOut,
                builder: (context, child, value) {
                  return Image.asset(
                    MyImages.logo,
                    height: value,
                    width: value,
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
