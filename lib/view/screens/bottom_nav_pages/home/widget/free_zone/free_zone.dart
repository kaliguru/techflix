import 'package:flutter/material.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import 'package:get/get.dart';

import '../../shimmer/portrait_movie_shimmer.dart';

class FreeZoneWidget extends StatefulWidget {
  const FreeZoneWidget({Key? key}) : super(key: key);

  @override
  _FreeZoneWidgetState createState() => _FreeZoneWidgetState();
}

class _FreeZoneWidgetState extends State<FreeZoneWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => controller.freeZoneMovieLoading
            ? const SizedBox(height: 180, child: PortraitShimmer())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
                child: Row(
                  children: List.generate(
                    controller.freeZoneList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.movieDetailsScreen,
                            arguments: [controller.freeZoneList[index].id, -1]);
                      },
                      child: Container(
                        width: 115,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomNetworkImage(
                                imageUrl:
                                    '${UrlContainer.baseUrl}${controller.freeZoneImagePath}${controller.freeZoneList[index].image?.portrait}',
                                width: 105,
                                height: 150,
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.spaceBetweenTextAndImage,
                            ),
                            /*CategoryButton(text:' ${controller.recentlyAddedList[index].title}', press: () {}),*/

                            Text(
                              '${controller.freeZoneList[index].title}',
                              style: mulishSemiBold.copyWith(
                                  color: MyColor.colorWhite,
                                  fontSize: Dimensions.fontSmall,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
