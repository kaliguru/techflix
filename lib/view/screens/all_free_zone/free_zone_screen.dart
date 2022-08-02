import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/util.dart';
import 'package:play_lab/data/controller/all_free_zone_controller/all_free_zone_controller.dart';
import 'package:play_lab/view/components/CustomNoDataFoundClass.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/all_free_zone/widget/free_zone_list_item.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/my_color.dart';
import '../../../data/repo/free_zone_repo/free_zone_repo.dart';
import '../../../data/services/api_service.dart';


class AllFreeZoneScreen extends StatefulWidget {
  const AllFreeZoneScreen({Key? key}) : super(key: key);

  @override
  _AllFreeZoneScreenState createState() => _AllFreeZoneScreenState();
}

class _AllFreeZoneScreenState extends State<AllFreeZoneScreen> {

  @override
  void initState() {
  MyUtil.changeTheme();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FreeZoneRepo(apiClient: Get.find()));
    final controller=Get.put(AllFreeZoneController(repo: Get.find()));

    super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.fetchInitialMovieList();
  });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllFreeZoneController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.colorBlack,
      appBar:const CustomAppBar(bgColor:Colors.transparent,title: MyStrings.freeZone,isShowBackBtn: true,),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child: !controller.isLoading && controller.movieList.isEmpty?const NoDataFoundScreen():Column(
          children:  [
            const AllFreeZoneListWidget(),
            Center(child:
            controller.paginationLoading?Column(
              children: const [
                SizedBox(height: 10,),
                SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(color: MyColor.primaryColor,)),
              ],
            ):const SizedBox(),)
          ],
        ),
      ),
    ));
  }
}
