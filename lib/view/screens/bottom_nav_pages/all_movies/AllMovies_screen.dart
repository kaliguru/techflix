
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/controller/all_movies_controller/all_movies_controller.dart';
import 'package:play_lab/data/repo/all_movies_repo/all_movies_repo.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/all_movies/widget/all_movie_list_item.dart';
import 'package:play_lab/view/components/CustomNoDataFoundClass.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/nav_drawer/custom_nav_drawer.dart';

import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/services/api_service.dart';


class AllMovieScreen extends StatefulWidget {
  const AllMovieScreen({Key? key}) : super(key: key);

  @override
  _AllMovieScreenState createState() => _AllMovieScreenState();
}

class _AllMovieScreenState extends State<AllMovieScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllMoviesRepo(apiClient: Get.find()));
    Get.put(AllMoviesController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: MyColor.colorBlack2,
          statusBarColor: MyColor.colorBlack2,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light));
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllMoviesController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.colorBlack,
      drawer: const NavigationDrawerWidget(),
      appBar:const CustomAppBar(title: MyStrings.allMovies,isShowBackBtn: false,),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child: !controller.isLoading && controller.movieList.isEmpty?const NoDataFoundScreen():Column(
          children:  [
            const AllMovieListWidget(),
            Center(child:
            controller.paginationLoading?Column(
              children: const [
                SizedBox(height: 10,),
                SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(color: MyColor.primaryColor,)),
              ],
            ):const SizedBox(),)
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 1,
      ),
    ));
  }
}
