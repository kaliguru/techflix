import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/my_color.dart';
import '../.././../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';

class ButtonSkip extends StatelessWidget {
  final Callback press;
  const ButtonSkip({Key? key,required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap:press,
        child: Container(
          width: MediaQuery.of(context).size.width ,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
              border: Border.all(color: Colors.white54, width: 1.2)),
          child: Text(
            MyStrings.skip,
            style: mulishSemiBold.copyWith(color: MyColor.colorBlack2),
          ),
        ),
      ),
    );
  }
}
