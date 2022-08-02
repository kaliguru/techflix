import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/wish_list_controller/wish_list_controller.dart';
import 'package:play_lab/data/repo/wish_list_repo/wish_list_repo.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import 'package:play_lab/view/components/CustomNoDataFoundClass.dart';
import 'package:play_lab/view/screens/movie_details/widget/rating_and_watch_widget/RatingAndWatchWidget.dart';
import 'package:play_lab/view/screens/wish_list/widget/wish_list_shimmer.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../../components/buttons/category_button.dart';


class WishlistWidget extends StatefulWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  _WishlistWidgetState createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<WishListController>().fetchNewWishlist();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<WishListController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(WishListRepo(apiClient: Get.find()));
    WishListController controller= Get.put(WishListController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchInitialWishlist();
      _controller.addListener(_scrollListener);
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(builder: (controller)=>controller.isLoading?  const WishlistShimmer():controller.wishlist.isEmpty?const Flexible(child:NoDataFoundScreen(paddingTop: 150,)):Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        controller: _controller,
          itemCount: controller.wishlist.length+1,
            itemBuilder: (context, index){

            if(controller.wishlist.length==index){
              return controller.hasNext()? const Center(child: CircularProgressIndicator()):const SizedBox();
            }
              return  Wrap(
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed(RouteHelper.movieDetailsScreen,arguments: [int.parse(controller.wishlist[index].itemId??'-1')??0,int.parse(controller.wishlist[index].episodeId.toString()=='0'?'-1':controller.wishlist[index].episodeId.toString())]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment:CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CustomNetworkImage(
                                    imageUrl: '${UrlContainer.baseUrl}${controller.portraitImagePath}${controller.wishlist[index].item?.image?.portrait}',
                                    height: 150,
                                    width: 120,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CategoryButton(
                                        text: controller.wishlist[index].item?.title??'', press: () {}),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(controller.wishlist[index].item?.title??'',style: mulishLight.copyWith(overflow:TextOverflow.ellipsis,color: MyColor.colorWhite,fontSize: Dimensions.fontLarge),),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingAndWatchWidget(watch: controller.wishlist[index].item?.view??'0', rating: controller.wishlist[index].item?.ratings??'0')
                                  ],
                                ),
                              ),
                              SizedBox(width: 5,),
                              InkWell(
                                onTap: (){
                                  controller.removeFromWishlist(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MyColor.textFieldColor
                                  ),
                                  child: controller.removeLoading && index==controller.selectedIndex?const SpinKitFadingCircle(size: 20,color: MyColor.primaryColor,):const Icon(Icons.clear,color: MyColor.colorWhite,size: 20,),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          const Divider(color: MyColor.bodyTextColor,),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  )
                ],
              );}
      ),
    )
    );
  }

}

