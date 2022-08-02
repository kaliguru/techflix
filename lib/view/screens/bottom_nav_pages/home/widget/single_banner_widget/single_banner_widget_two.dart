
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/controller/home/home_controller.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../../core/utils/url_container.dart';

class SecondSingleBannerWidget extends StatefulWidget {
  const SecondSingleBannerWidget({Key? key}) : super(key: key);

  @override
  _SecondSingleBannerWidgetState createState() => _SecondSingleBannerWidgetState();
}

class _SecondSingleBannerWidgetState extends State<SecondSingleBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller)=>controller.singleBannerImageLoading || controller.singleBannerList.isEmpty || controller.singleBannerList.length<2?
    Container(
      width: double.infinity,
      height: 160,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        image: const DecorationImage(
          image: AssetImage(MyImages.errorImage),
          fit: BoxFit.cover
        )
      ),
      child: controller.singleBannerImageLoading?const Icon(Icons.error_outline_outlined,color: Colors.grey,):Image.asset(MyImages.placeHolderImage),

    ) : GestureDetector(
      onTap: () {
           Get.toNamed(RouteHelper.movieDetailsScreen,arguments:[ controller.singleBannerList[1].id,-1]);
      },
      child: Container(
        width: double.infinity,
        height: 160,
        //margin: const EdgeInsets.only(left: 8, right: 8),
        decoration:  const BoxDecoration(
          gradient:  LinearGradient(colors: [
            Colors.black,
            Colors.black
          ]
          ),
        ),
        child: CustomNetworkImage(
          boxFit: BoxFit.cover,
          imageUrl: '${UrlContainer.baseUrl}${controller.singleBannerImagePath}${controller.singleBannerList[1].image?.landscape}',
         ),
      ),
    ));
  }
}
