import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/view/screens/movie_details/widget/video_player_widget/player_pre_loader_image.dart';
import 'package:play_lab/view/screens/sub_category/widget/player_shimmer_effect/player_shimmer_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MovieDetailsController>(builder: (controller)=>controller.playVideoLoading ? Center(child:  PlayerShimmerWidget(
      press: (){
        controller.clearData(true);
      },
    ))
        :controller.lockVideo && !controller.playVideoLoading?PlayerPreLoaderImage(image: '${UrlContainer.baseUrl}${controller.playerAssetPath}${controller.playerImage}'): controller.videoUrl.isEmpty? Center(child:  PlayerShimmerWidget(
      press: (){
        controller.clearData(true);
      },
    )):
    controller.chewieController.videoPlayerController.value.isInitialized?Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(0),
          child: Chewie(
            controller:controller.chewieController,
          ),
        ),
        Positioned(child:
        IconButton(
            onPressed: (){
              controller.clearData(true);
            },
            icon: const Icon(Icons.arrow_back,color: MyColor.colorWhite,))),
      ],
    ):
     Center(child:  PlayerShimmerWidget( press: (){
      controller.clearData(true);
    },)),);
  }
}
