import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import '../../shimmer/portrait_movie_shimmer.dart';

class RecentlyAddedWidget extends StatefulWidget {
  const RecentlyAddedWidget({Key? key}) : super(key: key);

  @override
  _RecentlyAddedWidgetState createState() => _RecentlyAddedWidgetState();
}

class _RecentlyAddedWidgetState extends State<RecentlyAddedWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller)=>
        Padding(
            padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
            child: controller.recentMovieLoading?const SizedBox(height:180,child: PortraitShimmer()):
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.recentlyAddedList.length, (index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.movieDetailsScreen,arguments: [controller.recentlyAddedList[index].id,-1]);
                      },
                      child: Container(
                        width: 130,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CustomNetworkImage(
                                imageUrl: '${UrlContainer.baseUrl}${controller.recentlyAddedImagePath}/${controller.recentlyAddedList[index].image?.portrait}',
                                width: 120,
                                height: 160,
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.spaceBetweenTextAndImage,
                            ),
                           Text('${controller.recentlyAddedList[index].title}',style: mulishSemiBold.copyWith(
                               color: MyColor.colorWhite,
                               fontSize: Dimensions.fontSmall,
                               overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                    )),
                  ),
                )));

  }
}
