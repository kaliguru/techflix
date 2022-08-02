import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isRating;
  final double iconSize;
  final double textSize;
  const IconWithText({Key? key,this.textSize=Dimensions.fontSmall,this.iconSize=16,this.isRating=true,required this.icon,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: isRating?Colors.yellow:MyColor.primaryColor,size: iconSize,),
        const SizedBox(width: 5,),
        Text(text,style: mulishLight.copyWith(fontSize:textSize,color: MyColor.colorWhite),overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
