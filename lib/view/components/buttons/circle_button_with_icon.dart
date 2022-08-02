import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../../core/utils/my_color.dart';
import '../../screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class CircleButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final Callback press;
  final double padding;
  final String imageUrl;
  final Color bg;
  final bool isIcon;
  final bool fromAsset;
  final double circleSize;
  final double imageSize;

  const CircleButtonWithIcon(
      {Key? key,
      this.imageUrl = '',
        this.fromAsset=false,
        this.circleSize=90,
        this.imageSize=50,
      this.isIcon = true,
      this.bg = MyColor.textFieldColor,
      this.padding = 5,
      required this.press,
      this.icon = Icons.clear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return isIcon
        ? GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(padding),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
              child: Icon(
                icon,
                color: MyColor.colorWhite,
                size: 20,
              ),
            ),
          )
        : GestureDetector(
            onTap: press,
            child: Container(
              height: circleSize,
              width: circleSize,
              padding: EdgeInsets.all(padding),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
              child: fromAsset?Image.asset(imageUrl,width: imageSize,height: imageSize,):CustomNetworkImage(
                imageUrl: imageUrl,
                height: imageSize,
                width: imageSize,
              ),
            ),
          );
  }
}
