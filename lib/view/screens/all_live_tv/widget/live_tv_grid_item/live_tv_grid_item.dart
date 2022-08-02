import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

import '../../../../../core/utils/my_color.dart';


class LiveTvGridItem extends StatelessWidget {
  final String liveTvName;
  final String imageUrl;
  final Callback press;
  final Color textColor;
  final Color bgColor;
  const LiveTvGridItem({Key? key,this.bgColor=MyColor.textFieldColor,this.textColor=MyColor.colorWhite,required this.liveTvName,required this.imageUrl,required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: press,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 75,
                minHeight: 75
              ),
              child: ClipRRect(borderRadius:BorderRadius.circular(4),
                  child: CustomNetworkImage(imageUrl: imageUrl,height: 80,width: 80,)),
            )),
      );

  }
}

