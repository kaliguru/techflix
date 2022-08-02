import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:play_lab/core/utils/my_images.dart';

import '../../../../../../core/utils/my_color.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final IconData errorImage;
  final BoxFit boxFit;
  final double spinKitSize;
  final int duration ;
  final bool isSlider;
  final bool fromSplash;
  final bool sliderOverlay;
  final bool showPlaceHolder;
  const CustomNetworkImage({Key? key,
    this.height=110,
    this.width=320,
    this.fromSplash=false,
    this.duration=500,
    this.spinKitSize=30,
    this.isSlider=false,
    this.showPlaceHolder=true,
    this.sliderOverlay=false,
    required this.imageUrl,
    this.boxFit=BoxFit.cover,
    this.errorImage=Icons.error_outline_outlined
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSlider?OctoImage(
      height: height,
      colorBlendMode: BlendMode.overlay,
      color: !sliderOverlay?Colors.transparent:Colors.grey,
      fadeInDuration: Duration(microseconds: duration),
      width: width,
      image:  NetworkImage(imageUrl),
      placeholderBuilder:(context)=>Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.red,
          image: DecorationImage(image: AssetImage(MyImages.errorImage),fit: BoxFit.cover),
        ),
        child: showPlaceHolder?Image.asset(MyImages.placeHolderImage,height: 40,width: 40,):const SizedBox(),
      ),
      errorBuilder: OctoError.placeholderWithErrorIcon((context) => Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(MyImages.errorImage,),fit: BoxFit.cover),
        ),
      )), //O
      fit: boxFit,
    ):
    OctoImage(
      height: height,
      colorBlendMode: BlendMode.overlay,
      color: !sliderOverlay?Colors.transparent:MyColor.colorGrey1,
      fadeInDuration: Duration(microseconds: duration),
      width: width,
      image:  NetworkImage(imageUrl),
      placeholderBuilder:(context)=>Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.red,
          image: DecorationImage(image: AssetImage(MyImages.errorImage),fit: BoxFit.cover),
        ),
        child: showPlaceHolder?Image.asset(MyImages.placeHolderImage,height: 40,width: 40,):const SizedBox(),
      ),
      errorBuilder: OctoError.placeholderWithErrorIcon((context) => Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(MyImages.errorImage,),fit: BoxFit.cover),
        ),
      )), //O
      fit: boxFit,
    );
  }
}
