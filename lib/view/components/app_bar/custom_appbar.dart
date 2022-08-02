import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_color.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool isShowBackBtn;
  final Color bgColor;

  const CustomAppBar({Key? key,this.bgColor=MyColor.colorBlack,this.isShowBackBtn=true,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading:isShowBackBtn? GestureDetector(onTap: (){
       Get.back();
      },child: const Icon(Icons.arrow_back,color: MyColor.colorWhite,),):const SizedBox(),
      backgroundColor: bgColor,
      title: Text(title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}