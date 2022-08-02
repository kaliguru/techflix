import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/live_tv_details_controller/live_tv_details_controller.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/live_tv_shimmer.dart';

import '../../all_live_tv/widget/live_tv_grid_item/live_tv_grid_item.dart';

class RelatedTvList extends StatefulWidget {
  const RelatedTvList({Key? key}) : super(key: key);

  @override
  _RelatedTvListState createState() => _RelatedTvListState();
}

class _RelatedTvListState extends State<RelatedTvList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveTvDetailsController>(builder: (controller)=>controller.isLoading?const SizedBox(height:100,child: LiveTvShimmer()):
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(controller.relatedTvList.length, (index) =>
            LiveTvGridItem(
                liveTvName: controller.relatedTvList[index].title??'',
                imageUrl: '${UrlContainer.baseUrl}${controller.imagePath}/${controller.relatedTvList[index].image}',
                press: (){
                  controller.clearAllData();
                  Get.offAndToNamed(RouteHelper.liveTvDetailsScreen,arguments: controller.relatedTvList[index].id);
                })),
      ),
    )
    );
  }
}
