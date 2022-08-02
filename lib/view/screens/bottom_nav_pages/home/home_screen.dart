import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/category/category_controller/category_controller.dart';
import 'package:play_lab/data/controller/home/home_controller.dart';
import 'package:play_lab/data/controller/nav_controller/NavDrawerController.dart';
import 'package:play_lab/data/repo/category_repo/category_repo/category_repo.dart';
import 'package:play_lab/data/repo/home_repo/home_repo.dart';
import 'package:play_lab/data/repo/nav_drawer_repo/nav_drawer_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/category_widget/category_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/divider_section/divider_section.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/featured_movie_widget/featured_movie_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/free_zone/free_zone.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/latest_series.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/latest_trailer_widget/latest_trailer_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/live_tv_widget/live_tv_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/recently_added_widget/recently_added_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/show_more_row/show_more_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/single_banner_widget/single_banner_widget.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/single_banner_widget/single_banner_widget_two.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/slider_widget/slider_widget.dart';
import 'package:play_lab/view/components/bottom_Nav/bottom_nav.dart';
import 'package:play_lab/view/components/custom_text_field.dart';
import 'package:play_lab/view/components/show_more_row/show_more_row.dart';

import '../../../../constants/my_strings.dart';
import '../../../components/nav_drawer/custom_nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {


    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    Get.put(CategoryRepo(apiClient: Get.find()));
    Get.put(CategoryController(repo: Get.find()));
    Get.put(NavDrawerRepo(apiClient: Get.find()));
    Get.put(NavDrawerController(sharedPreferences: Get.find()));
    Get.put(HomeController(homeRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: MyColor.colorBlack,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: MyColor.colorBlack,
          systemNavigationBarIconBrightness: Brightness.light));
      Get.find<HomeController>().getAllData();
      Get.find<CategoryController>().fetchInitialCategoryData();
    });
  }

  changeCurrentPageIndex(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          TextEditingController().clear();
        },
        child: SafeArea(
          child: Scaffold(
            onDrawerChanged: (isOpened) {

                if (!isOpened) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  TextEditingController().clear();
                }

            },
            onEndDrawerChanged: (isOpened) {},
            key: scaffoldKey,
            backgroundColor: MyColor.secondaryColor2,
            drawer: const NavigationDrawerWidget(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  searchBarWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  const SliderWidget(),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  ShowMoreText(
                      headerText: MyStrings.liveTV,
                      press: () {
                        Get.toNamed(RouteHelper.allLiveTVScreen);
                      }),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const LiveTvWidget(),
                   const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  ShowMoreText(
                      headerText: MyStrings.category,
                      isShowMoreVisible: false,
                      press: () {}),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const CategoryWidget(),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  ShowMoreText(
                      headerText: MyStrings.recentlyAdded,
                      isShowMoreVisible: false,
                      press: () {}),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const RecentlyAddedWidget(),
                  const DividerSection(),
                  const SingleBannerWidget(),
                  const DividerSection(),
                  ShowMoreText(
                      isShowMoreVisible: false,
                      headerText: MyStrings.featuredItem,
                      press: () {}),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const FeaturedMovieWidget(),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const DividerSection(
                    topSpace: 10,
                  ),
                  ShowMoreRowWidget(
                    value: MyStrings.ourFreeZone,
                    isShowMoreVisible: true,
                    press: () {
                      Get.toNamed(RouteHelper.allFreeZoneScreen);
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const FreeZoneWidget(),
                  const DividerSection(),
                  const SecondSingleBannerWidget(),
                  const DividerSection(),
                  ShowMoreRowWidget(
                    value: MyStrings.latestTrailer,
                    isShowMoreVisible: false,
                    press: () {},
                  ),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const LatestTrailerWidget(),
                  const DividerSection(),
                  ShowMoreText(
                      isShowMoreVisible: false,
                      headerText: MyStrings.latestSeries,
                      press: () {
                        //Get.toNamed(RouteHelper.allLiveTVScreen);
                      }),
                  const SizedBox(
                    height: Dimensions.spaceBetweenCategory,
                  ),
                  const LatestSeries(),

                  // const Divider(color: ColorResources.bodyTextColor,),
                  //const SizedBox(height: 10,),
                ],
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(0),
          ),
        ),
      );
    });
  }

  Widget bottomNavigationBar(int index) {
    return CustomBottomNav(currentIndex: index);
  }

  Widget searchBarWidget() {
    return GetBuilder<HomeController>(
        builder: (controller) => Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                        fillColor: MyColor.textFieldColor,
                        isShowSuffixIcon: true,
                        isSearch: true,
                        borderRadius: 8,
                        isIcon: true,
                        controller: controller.searchController,
                        suffixIconUrl: "",
                        onSuffixTap: () {
                          FocusScope.of(context).unfocus();
                          String searchText = controller.searchController.text;
                          Get.toNamed(RouteHelper.searchScreen,
                              arguments: searchText);
                          controller.searchController.clear();
                        },
                        hintText: MyStrings.search,
                        onChanged: (value) {}),
                  ),
                ],
              ),
            ));
  }
}
