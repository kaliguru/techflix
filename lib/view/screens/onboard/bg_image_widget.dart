import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import '../../../core/utils/my_images.dart';



class BgImageWidget extends StatelessWidget {
  final String bgImage;
  final bool isAssetImage;
  const BgImageWidget({Key? key,this.isAssetImage=false,required this.bgImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ShaderMask(
        shaderCallback: (bound) {
          return  LinearGradient(
              end: FractionalOffset.topCenter,
              begin: FractionalOffset.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.99),
                Colors.black.withOpacity(0.5),
                Colors.transparent,
              ],
              stops: const [
                0.0,
                0.3,
                0.45
              ])
              .createShader(bound);
        },
        blendMode: BlendMode.srcOver,
        child: isAssetImage?Image.asset(
          bgImage,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ): ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOver),
          child: OctoImage(
            colorBlendMode: BlendMode.overlay,
            image:  NetworkImage(bgImage),
            placeholderBuilder:(context)=>  Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration:  const BoxDecoration(
                color: Colors.red,
                image: DecorationImage(image: AssetImage(MyImages.errorImage),fit: BoxFit.cover),
              ),
              child: Image.asset(MyImages.placeHolderImage,height: 40,width: 40,),
            ),
            errorBuilder:  OctoError.placeholderWithErrorIcon((context) => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(MyImages.errorImage,),fit: BoxFit.cover),
              ),
            )),
            fit:BoxFit.fill,
          )
        ),
      ),
    );
  }
}

