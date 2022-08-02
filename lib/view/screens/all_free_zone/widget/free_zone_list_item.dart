import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/all_free_zone_controller/all_free_zone_controller.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/grid_shimmer.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../data/repo/free_zone_repo/free_zone_repo.dart';

class AllFreeZoneListWidget extends StatefulWidget {
  const AllFreeZoneListWidget({Key? key}) : super(key: key);

  @override
  _AllFreeZoneListWidgetState createState() => _AllFreeZoneListWidgetState();
}

class _AllFreeZoneListWidgetState extends State<AllFreeZoneListWidget> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<AllFreeZoneController>().fetchNewMovieList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<AllFreeZoneController>().hasNext()) {
        Get.find<AllFreeZoneController>().updatePaginationLoading(true);
        fetchData();
      }
    }else{
      Get.find<AllFreeZoneController>().updatePaginationLoading(false);
    }
  }

  @override
  void initState() {
    Get.put(FreeZoneRepo(apiClient: Get.find()));
    Get.put(AllFreeZoneController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<AllFreeZoneController>().updatePaginationLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllFreeZoneController>(
        builder: (controller) => controller.isLoading
            ? const Flexible(child: GridShimmer())
            : Flexible(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    itemCount: controller.movieList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 12,
                            crossAxisCount: 3,
                            childAspectRatio: .55),
                    itemBuilder: (context, index) {

                      return Card(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          color: MyColor.colorBlack,
                          shape: const RoundedRectangleBorder(
                              //borderRadius: BorderRadius.circular(8),
                              ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.movieDetailsScreen,
                                  arguments: [
                                    controller.movieList[index].id,
                                    -1
                                  ]);
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CustomNetworkImage(
                                      imageUrl:
                                          '${UrlContainer.baseUrl}${controller.portraitImagePath}${controller.movieList[index].image?.portrait}',
                                      height: 200,
                                    ),
                                  )),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    color: MyColor.colorBlack,
                                    child: Text(
                                        controller.movieList[index].title ?? '',
                                        style: mulishSemiBold.copyWith(
                                            color: MyColor.colorWhite,
                                            overflow: TextOverflow.ellipsis)),
                                  ),
                                ]),
                          ));
                    }),
              ));
  }
}
