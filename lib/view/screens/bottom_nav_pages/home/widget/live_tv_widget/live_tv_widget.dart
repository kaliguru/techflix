import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/controller/home/home_controller.dart';

import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../all_live_tv/widget/live_tv_grid_item/live_tv_grid_item.dart';
import '../../shimmer/live_tv_shimmer.dart';

class LiveTvWidget extends StatefulWidget {
  const LiveTvWidget({Key? key}) : super(key: key);

  @override
  _LiveTvWidgetState createState() => _LiveTvWidgetState();
}

class _LiveTvWidgetState extends State<LiveTvWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Padding(
            padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
            child: controller.liveTvLoading
                ? SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: const LiveTvShimmer())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            controller.televisionList.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.liveTvDetailsScreen,
                                        arguments: controller
                                            .televisionList[index].id);
                                  },
                                  child: LiveTvGridItem(
                                      liveTvName: controller
                                              .televisionList[index].title ??
                                          '',
                                      imageUrl:
                                          '${UrlContainer.baseUrl}${controller.televisionImagePath}/${controller.televisionList[index].image}',
                                      press: () {
                                        Get.toNamed(
                                            RouteHelper.liveTvDetailsScreen,
                                            arguments: controller
                                                .televisionList[index].id);
                                      }),
                                ))),
                  )));
  }
}
