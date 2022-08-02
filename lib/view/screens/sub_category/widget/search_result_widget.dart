import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/my_search_controller/search_controller.dart';
import 'package:play_lab/data/repo/my_search/my_search_repo.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/grid_shimmer.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import 'package:play_lab/view/screens/movie_details/widget/rating_and_watch_widget/RatingAndWatchWidget.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';

class SearchResultListWidget extends StatefulWidget {
  final String searchText;
  final int categoryId;
  final int subCategoryId;
  const SearchResultListWidget({Key? key,this.searchText='',this.categoryId=-1,this.subCategoryId=-1}) : super(key: key);

  @override
  _SearchResultListWidgetState createState() => _SearchResultListWidgetState();
}

class _SearchResultListWidgetState extends State<SearchResultListWidget> {

  final ScrollController _controller = ScrollController();


  fetchData() {
    Get.find<MySearchController>().fetchSubCategoryData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<MySearchController>().hasNext()) {
        Get.find<MySearchController>().updatePaginationLoading(true);
        fetchData();
      }
    }else{
      Get.find<MySearchController>().updatePaginationLoading(false);
    }
  }

  @override
  void initState() {
    Get.put(MySearchRepo(apiClient: Get.find()));
    MySearchController controller= Get.put(MySearchController(repo: Get.find(),searchText: widget.searchText,subCategoryId: widget.subCategoryId,categoryId: widget.categoryId));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchText=widget.searchText;
      controller.fetchInitialSubCategoryData();
      _controller.addListener(_scrollListener);
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<MySearchController>().updatePaginationLoading(false);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Get.find<MySearchController>().changeSubCategoryId(widget.subCategoryId);
    return GetBuilder<MySearchController>(builder: (controller)=>controller.isLoading?const Flexible(child: GridShimmer()):
        Flexible(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            controller: _controller,
              itemCount: controller.movieList.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                mainAxisSpacing: 12,
                crossAxisCount: 3,
                childAspectRatio: .55),
                itemBuilder: (context, index){
                  return  SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.movieDetailsScreen,arguments:[controller.movieList[index].id,-1] );
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomNetworkImage(imageUrl:  '${UrlContainer.baseUrl}${controller.portraitImagePath}${controller.movieList[index].image?.portrait}',height: 160,),
                                )
                              ),
                              const SizedBox(height: 7,),
                              Text(controller.movieList[index].title??'',style: mulishSemiBold.copyWith(color: MyColor.colorWhite,overflow: TextOverflow.ellipsis)),
                              SingleChildScrollView(scrollDirection: Axis.horizontal,child: RatingAndWatchWidget(rating:CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.movieList[index].ratings??'0'), watch:CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(controller.movieList[index].view??'0',precision: 0)))
                            ]),
                      ));}
          ),
        ),

    );
  }

}

