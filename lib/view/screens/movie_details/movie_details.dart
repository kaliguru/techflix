import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/data/repo/movie_details_repo/movie_details_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/CustomSizedBox.dart';
import 'package:play_lab/view/screens/movie_details/widget/body_widget/movie_details_widget.dart';
import 'package:play_lab/view/screens/movie_details/widget/episode_widget/episode_widget.dart';
import 'package:play_lab/view/screens/movie_details/widget/recommended_section/recommended_list_widget.dart';
import 'package:play_lab/view/screens/movie_details/widget/video_player_widget/video_player_widget.dart';

import '../../../core/utils/dimensions.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int itemId;
  final int episodeId;
  const MovieDetailsScreen({Key? key,required this.itemId,required this.episodeId}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {



  @override
  void initState() {

print('item id: ${widget.itemId}');
print('item episode id: ${widget.episodeId}');
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MovieDetailsRepo(apiClient: Get.find()));

    MovieDetailsController movieDetailsController=  Get.put(MovieDetailsController(movieDetailsRepo: Get.find(),itemId: widget.itemId,episodeId: widget.episodeId));

   movieDetailsController.isDescriptionShow=true;
   movieDetailsController.isTeamShow=false;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      movieDetailsController.getVideoDetails(widget.itemId,widget.episodeId);
    });


  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(
        builder: (controller) => SafeArea(
                child: Scaffold(
              backgroundColor: MyColor.secondaryColor2,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                     VideoPlayerWidget(),
                     CustomSizedBox(),
                     EpisodeWidget(),
                     MovieDetailsBodyWidget(),
                     CustomSizedBox(),
                     SizedBox(height: Dimensions.spaceBetweenCategory,),
                     RecommendedListWidget(),
                     SizedBox(height: 10,),
                  ],
                ),
              ),
            )));
  }




}
