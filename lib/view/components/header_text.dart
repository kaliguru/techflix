
import 'package:flutter/cupertino.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class HeaderText extends StatelessWidget {
   const HeaderText({Key? key,required this.text,this.textStyle=mulishBold,this.isChange=false, }) : super(key: key);
  final String text;
  final bool isChange;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: isChange?
    mulishBold.copyWith(fontSize: Dimensions.fontLarge,color: MyColor.colorWhite):textStyle,);
  }
}
