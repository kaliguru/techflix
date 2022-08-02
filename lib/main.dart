import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';

import 'core/di_service/di_service.dart' as di_service;
import 'core/route/route.dart';
import 'core/theme/dark.dart';
import 'core/utils/my_color.dart';
import 'data/controller/common/theme_controller.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await di_service.init();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: MyColor.colorGrey3,
      statusBarColor: MyColor.secondaryColor2,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:Brightness.light ,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    runApp( const MyApp());

}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (theme){
      return GetMaterialApp(
        title:MyStrings.appName,
        initialRoute: RouteHelper.splashScreen,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 200),
        getPages: RouteHelper.routes,
        navigatorKey: Get.key,
        theme:  dark ,
        debugShowCheckedModeBanner: false,
      );
    });
  }


}


