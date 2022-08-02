import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../core/utils/my_color.dart';

class PlayerPreLoaderImage extends StatelessWidget {
  final VoidCallback? press;
  final bool fromLiveTv;
  final  String image;
  const PlayerPreLoaderImage({Key? key,this.fromLiveTv=true,this.press,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width - 20,
              child: CustomNetworkImage(sliderOverlay:true,height:200,width: MediaQuery.of(context).size.width - 20,imageUrl: image,showPlaceHolder: false,),
            ),
          ),
          const Positioned(top:0,bottom:0,left:0,right:0,child: Icon(Icons.lock_outline,size: 40,color: MyColor.primaryColor,)),
          Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 15,
              ),
              child: GestureDetector(
                  onTap:fromLiveTv? () {
                    Get.back();
                  }:press,
                  child: const Icon(
                    Icons.arrow_back,
                    color: MyColor.colorWhite,
                    size: 20,
                  ))),
        ],
      ),
    );
  }
}
