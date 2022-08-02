import 'package:flutter/material.dart';

import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/dimensions.dart';

class DividerSection extends StatelessWidget {
  final double topSpace;
  const DividerSection({Key? key,this.topSpace=Dimensions.spaceBetweenCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SizedBox(
          height: topSpace,
        ),
        const Divider(
          color: MyColor.bodyTextColor,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
