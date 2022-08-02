import 'package:flutter/material.dart';
import '../../core/utils/my_color.dart';
import '../../core/utils/styles.dart';
import '../../view/components/small_text.dart';

class RequiredLabelRow extends StatelessWidget {
  const RequiredLabelRow({Key? key,required this.label,this.required=true}) : super(key: key);
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SmallText(text: label,textStyle: mulishSemiBold,),
        required?Text(' *',style: mulishBold.copyWith(color: MyColor.redCancelTextColor),):const SizedBox.shrink(),
      ],
    );
  }
}
