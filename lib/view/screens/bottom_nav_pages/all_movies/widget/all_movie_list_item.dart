import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/all_movies_controller/all_movies_controller.dart';
import 'package:play_lab/data/repo/all_movies_repo/all_movies_repo.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/grid_shimmer.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../core/route/route.dart';
import '../../../../../core/utils/url_container.dart';

class AllMovieListWidget extends StatefulWidget {
  const AllMovieListWidget({Key? key}) : super(key: key);

  @override
  _AllMovieListWidgetState createState() => _AllMovieListWidgetState();
}

class _AllMovieListWidgetState extends State<AllMovieListWidget> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<AllMoviesController>().fetchNewMovieList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<AllMoviesController>().hasNext()) {
        Get.find<AllMoviesController>().updatePaginationLoading(true);
        fetchData();
      }
    }else{
      Get.find<AllMoviesController>().updatePaginationLoading(false);
    }
  }

  @override
  void initState() {
    Get.put(AllMoviesRepo(apiClient: Get.find()));
    AllMoviesController controller =
        Get.put(AllMoviesController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchInitialMovieList();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<AllMoviesController>().updatePaginationLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllMoviesController>(
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
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
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
