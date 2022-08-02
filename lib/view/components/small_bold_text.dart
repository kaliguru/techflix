import 'package:flutter/material.dart';

import '../../core/utils/styles.dart';

class SmallLBoldText extends StatelessWidget {
  const SmallLBoldText({Key? key,required this.text,this.textStyle=mulishSemiBold}) : super(key: key);
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: textStyle);
  }
}