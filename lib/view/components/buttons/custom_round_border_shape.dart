import 'package:flutter/material.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';



class RoundedBorderContainer extends StatelessWidget {
  const RoundedBorderContainer({Key? key,required this.text,this.borderColor=MyColor.primaryColor,this.bgColor=MyColor.primaryColor500,this.textColor=MyColor.primaryColor}) : super(key: key);
  final Color bgColor,textColor,borderColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border:Border.all(color: borderColor,width: 1.5)
      ),
      child: Text(
        text,
        style: mulishBold.copyWith(color:textColor,fontSize: Dimensions.fontSmall)
      ),
    );
  }
}
