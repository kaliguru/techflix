import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/home/home_controller.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/latest_series_shimmer.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../core/route/route.dart';
import '../.././../../../core/utils/dimensions.dart';

class LatestSeries extends StatelessWidget {
  const LatestSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => controller.latestSeriesMovieLoading
            ? const LatestSeriesShimmer()
            : Container(
                height: 185,
                padding:
                    const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.latestSeriesList.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.movieDetailsScreen,
                                arguments: [
                                  controller.latestSeriesList[index].id,
                                  -1
                                ]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomNetworkImage(
                                    imageUrl:
                                        '${UrlContainer.baseUrl}${controller.latestSeriesImagePath}/${controller.latestSeriesList[index].image?.landscape}',
                                    width: MediaQuery.of(context).size.width,
                                    height: 170,
                                    boxFit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.spaceBetweenTextAndImage,
                                ),
                              ],
                            ),
                          ),
                        ))));
  }
}
