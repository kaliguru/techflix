import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/live_tv_controller/live_tv_controller.dart';
import 'package:play_lab/data/repo/live_tv_repo/live_tv_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/all_live_tv/widget/all_live_tv_shimmer/all_live_tv_shimmer.dart';
import 'package:play_lab/view/screens/all_live_tv/widget/live_tv_grid_item/live_tv_grid_item.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/url_container.dart';


class AllLiveTvScreen extends StatefulWidget {
  const AllLiveTvScreen({Key? key}) : super(key: key);

  @override
  _AllLiveTvScreenState createState() => _AllLiveTvScreenState();
}

class _AllLiveTvScreenState extends State<AllLiveTvScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LiveTvRepo(apiClient: Get.find()));
    final liveTvController=Get.put(LiveTvController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      liveTvController.getLiveTv();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveTvController>(
        builder: (controller) => Scaffold(
              backgroundColor: MyColor.secondaryColor2,
              appBar: const CustomAppBar(title:  MyStrings.allTV,),
              body: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    controller.isLoading?const Flexible(child: AllLiveTvShimmer()):Expanded(
                        child: GridView.builder(
                            itemCount: controller.televisionList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                    crossAxisCount: 4,childAspectRatio: 1),
                            itemBuilder: (context, index) => LiveTvGridItem(
                                liveTvName: controller.televisionList[index].title??'',
                                imageUrl: '${UrlContainer.baseUrl}${controller.televisionImagePath}/${controller.televisionList[index].image}',
                                press: () {
                                  Get.toNamed(RouteHelper.liveTvDetailsScreen,arguments: controller.televisionList[index].id);
                                })))
                  ],
                ),
              ),
            ));
  }
}
