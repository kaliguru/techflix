import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/live_tv_details_controller/live_tv_details_controller.dart';
import 'package:play_lab/data/repo/live_tv_repo/live_tv_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/header_light_text.dart';
import 'package:play_lab/view/components/text/header_view_text.dart';
import 'package:play_lab/view/screens/live_tv_details/widget/live_tv_details_shimmer_widget/live_tv_details_shimmer_widget.dart';
import 'package:play_lab/view/screens/live_tv_details/widget/related_item_list.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/dimensions.dart';
import '../../components/CustomSizedBox.dart';
import '../../components/buttons/category_button.dart';
import '../../components/small_text.dart';

class LiveTvDetailsScreen extends StatefulWidget {
  const LiveTvDetailsScreen({Key? key}) : super(key: key);

  @override
  _LiveTvDetailsScreenState createState() => _LiveTvDetailsScreenState();
}

class _LiveTvDetailsScreenState extends State<LiveTvDetailsScreen> {


  @override
  void initState() {

    final argument=Get.arguments;

   Get.put(ApiClient(sharedPreferences: Get.find()));
   Get.put(LiveTvRepo(apiClient: Get.find()));
   final controller= Get.put(LiveTvDetailsController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData(argument);
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveTvDetailsController>(builder: (controller)=>SafeArea(child: Scaffold(
      backgroundColor: MyColor.secondaryColor2,
      body:controller.isLoading? SizedBox(height: MediaQuery.of(context).size.height,child: const LiveTvDetailsShimmerWidget()): SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(0),
                child: Chewie(
                  controller: controller.chewieController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CategoryButton(
                            horizontalPadding: 10,
                            verticalPadding: 5,
                            textSize: 14,
                            color: MyColor.primaryColor,
                            text: MyStrings.live,
                            press: () {

                            }),
                       const SizedBox(width: 10,),

                      ],
                    ),
                   const SizedBox(height: 10,),
                  ],
                ),
              ),
              const CustomSizedBox(height: 15,),
              const Divider(height: 1,color: MyColor.bodyTextColor,),
              const CustomSizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10),child: HeaderLightText(text: MyStrings.channelDescription)),
                  const CustomSizedBox(),
                  Padding(padding:const EdgeInsets.only(left: 10),child:  SmallText(text: controller.tvObject.description??MyStrings.ipsumMovieDetails)),
                  const SizedBox(height: 15,),
                ],
              ),
              const SizedBox(height: 10,),
              const HeaderViewText(header: MyStrings.recommended,isShowMoreVisible: false,),
              const SizedBox(height: Dimensions.spaceBetweenCategory,),
              const RelatedTvList(),
              const SizedBox(height: 5,),
            ],
          ),
          Row(children: [
            Padding(padding:const EdgeInsets.only(left: 15,top: 15,),child: GestureDetector(onTap: (){
              controller.clearAllData();
              Get.back();
              },child: const Icon(Icons.arrow_back,color: MyColor.colorWhite,size: 20,))),
            const SizedBox(width: 10,),

          ],),
        ],
        ),
      ),
    )));
  }


}
