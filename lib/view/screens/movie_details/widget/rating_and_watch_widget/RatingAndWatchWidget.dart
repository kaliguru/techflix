
import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../components/row_item/IconWithText.dart';

class RatingAndWatchWidget extends StatelessWidget {
  final String watch;
  final String rating;
  final double iconSize;
  final double textSize;
  const RatingAndWatchWidget({Key? key,required this.watch,required this.rating,this.iconSize=16,this.textSize=Dimensions.fontSmall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWithText(icon: Icons.star, text: rating.toString(),iconSize: iconSize,textSize: textSize,),
        const SizedBox(width: 5,),
        Text('|',style: mulishSemiBold.copyWith(color: MyColor.bodyTextColor),),
        const SizedBox(width: 5,),
        IconWithText(icon: Icons.remove_red_eye,isRating: false, text: watch,iconSize: iconSize,textSize: textSize,)
      ],
    );
  }
}
