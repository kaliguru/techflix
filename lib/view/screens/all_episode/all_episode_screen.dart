import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/controller/all_episode_controller/all_episode_controller.dart';
import 'package:play_lab/data/repo/all_episode_repo/all_episode_repo.dart';
import 'package:play_lab/view/components/CustomNoDataFoundClass.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';
import 'package:play_lab/view/screens/all_episode/widget/all_episode_list_item.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/my_color.dart';
import '../../../data/services/api_service.dart';


class AllEpisodeScreen extends StatefulWidget {
  const AllEpisodeScreen({Key? key}) : super(key: key);

  @override
  _AllEpisodeScreenState createState() => _AllEpisodeScreenState();
}

class _AllEpisodeScreenState extends State<AllEpisodeScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllEpisodeRepo(apiClient: Get.find()));
    Get.put(AllEpisodeController(repo: Get.find()));

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllEpisodeController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.colorBlack,
      drawer: const NavigationDrawerWidget(),
      appBar:const CustomAppBar(bgColor:Colors.transparent,title: MyStrings.allEpisodes,isShowBackBtn: false,),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child: !controller.isLoading && controller.episodeList.isEmpty?const NoDataFoundScreen():Column(
          children:  [
            const AllEpisodeListWidget(),
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
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 2,
      ),
    ));
  }
}
