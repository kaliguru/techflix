import 'package:flutter/material.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import 'package:get/get.dart';
import '../../shimmer/portrait_movie_shimmer.dart';

class FeaturedMovieWidget extends StatefulWidget {
  const FeaturedMovieWidget({Key? key}) : super(key: key);

  @override
  _FeaturedMovieWidgetState createState() => _FeaturedMovieWidgetState();
}

class _FeaturedMovieWidgetState extends State<FeaturedMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => controller.featuredMovieLoading
            ? const SizedBox(height: 180, child: PortraitShimmer())
            : Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.featuredMovieList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 12,
                            crossAxisCount: 3,
                            childAspectRatio: .55),
                    itemBuilder: (context, index) {
                      return SizedBox(
                          child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.movieDetailsScreen,
                              arguments: [
                                controller.featuredMovieList[index].id,
                                -1
                              ]);
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                  child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8)),
                                child: CustomNetworkImage(
                                  imageUrl:
                                      '${UrlContainer.baseUrl}${controller.featuredMovieImagePath}${controller.featuredMovieList[index].image?.portrait}',
                                  height: 200,
                                ),
                              )),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 8.0, bottom: 8.0, right: 0),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                ),
                                child: Text(
                                    '${controller.featuredMovieList[index].title}',
                                    style: mulishSemiBold.copyWith(
                                        color: MyColor.colorWhite,
                                        fontSize: Dimensions.fontSmall,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                            ]),
                      ));
                    }),
              ));
  }
}
