import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/category/sub_category/sub_category_controller.dart';
import 'package:play_lab/data/repo/category_repo/sub_category_repo/sub_category_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/shimmer/category_shimmer.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/sub_category/widget/search_result_widget.dart';

class SubCategoryScreen extends StatefulWidget {
  final int subCategoryId;
  const SubCategoryScreen({Key? key,required this.subCategoryId}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SubcategoryRepo(apiClient: Get.find()));
    SubCategoryController controller= Get.put(SubCategoryController(repo: Get.find(),categoryId: widget.subCategoryId));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchSubCategoryData();
    });
  }

  @override
  void dispose() {
    Get.find<SubCategoryController>().clearAllData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.colorBlack,
      appBar: const CustomAppBar(
        title: MyStrings.category,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.isLoading? SizedBox(height:45,width:MediaQuery.of(context).size.width,child:  const CategoryShimmer()):SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(controller.subCategoryList.length, (index) => ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100),
                  child: InkWell(
                    onTap: (){
                        controller.changeSelectedSubCategoryIndex(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white30,width: 1),
                        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                        color: controller.selectedSubCategoryIndex==index?MyColor.primaryColor:MyColor.textFieldColor,
                      ),
                      child: Text(
                        controller.subCategoryList[index].name??'',
                        style: mulishSemiBold.copyWith(color: MyColor.colorWhite,),
                      ),
                    ),
                  ),
                )),
              ),
            ),
            const SizedBox(height: Dimensions.spaceBetweenCategory,),
             SearchResultListWidget(searchText: '',categoryId: controller.categoryId,subCategoryId: controller.selectedSubCategoryId,),

          ],
        ),
      ),
    ));
  }
}
