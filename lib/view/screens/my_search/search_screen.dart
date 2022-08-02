import 'package:flutter/material.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/my_search_controller/search_controller.dart';
import 'package:play_lab/data/repo/my_search/my_search_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/CustomNoDataFoundClass.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/screens/sub_category/widget/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen({Key? key,required this.searchText}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MySearchRepo(apiClient: Get.find()));
    Get.put(MySearchController(repo: Get.find(),searchText:widget.searchText));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(builder: (controller)=>
        SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.colorBlack,
        appBar: const CustomAppBar(title: MyStrings.searchResult),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: !controller.isLoading && controller.movieList.isEmpty?const NoDataFoundScreen():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),
             SearchResultListWidget(searchText: widget.searchText,),
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
      ),
    ));
  }

}
