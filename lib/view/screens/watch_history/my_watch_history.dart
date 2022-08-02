import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/my_watch_history_controller/my_watch_history_controller.dart';
import 'package:play_lab/data/repo/mywatch_repo/my_watch_history_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/CustomNoDataFoundClass.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import 'package:play_lab/view/screens/movie_details/widget/rating_and_watch_widget/RatingAndWatchWidget.dart';

import '../../components/header_light_text.dart';
import '../wish_list/widget/wish_list_shimmer.dart';

class MyWatchHistoryScreen extends StatefulWidget {
  const MyWatchHistoryScreen({Key? key}) : super(key: key);

  @override
  _MyWatchHistoryScreenState createState() => _MyWatchHistoryScreenState();
}

class _MyWatchHistoryScreenState extends State<MyWatchHistoryScreen> {



  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<MyWatchHistoryController>().fetchNewList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<MyWatchHistoryController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MyWatchHistoryRepo(apiClient: Get.find()));
   final controller= Get.put(MyWatchHistoryController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchInitialList();
      _controller.addListener(() {_scrollListener();});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWatchHistoryController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.secondaryColor2,
      appBar:const CustomAppBar(title: MyStrings.myHistory,bgColor: Colors.transparent,),
      body:!controller.isLoading && controller.movieList.isEmpty?const NoDataFoundScreen(): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          controller.isLoading? const WishlistShimmer(isShowCircle: false,):  Expanded(
            child: ListView.builder(
                itemCount: controller.movieList.length+1,
                controller: _controller,
                itemBuilder: (context, index) {

                  if(controller.movieList.length==index){
                    return controller.hasNext()? const Center(child: CircularProgressIndicator()):const SizedBox();
                  }
                  return InkWell(
                    onTap: () {
                      controller.gotoDetailsPage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CustomNetworkImage(
                                  imageUrl: controller.getImagePath(index),
                                  height: 140,
                                  width: 110,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    HeaderLightText(
                                        text: controller.movieList[index]
                                            .item != null
                                            ? controller.movieList[index].item
                                            ?.title ?? ''
                                            :
                                        controller.movieList[index].episode
                                            ?.title ?? ''
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        RatingAndWatchWidget(
                                            watch: controller.movieList[index]
                                                .item?.view ?? '0.0',
                                            rating: controller.movieList[index]
                                                .item?.ratings ?? '0.0')
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 10,),
                          const Divider(color: MyColor.bodyTextColor,),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),

    ));
  }


}
