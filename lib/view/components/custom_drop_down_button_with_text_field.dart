import 'package:flutter/material.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class CustomDropDownTextField extends StatefulWidget {
  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  final double paddingLeft;
  final double paddingRight;
  const CustomDropDownTextField({Key? key, this.title,this.paddingLeft=10,this.paddingRight=10, this.selectedValue, this.list, this.onChanged, }) : super(key: key);

  @override
  _CustomDropDownTextFieldState createState() => _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: MyColor.textFieldColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                  color:  MyColor.colorGrey2
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.paddingLeft,
                right: widget.paddingRight
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              hint: Text(
                widget.selectedValue??'',
                style: mulishRegular.copyWith(fontSize: Dimensions.fontExtraSmall),
              ),
              value: widget.selectedValue,
              dropdownColor: MyColor.secondaryColor2,
              iconEnabledColor: MyColor.primaryColor,
              onChanged: widget.onChanged,
              items: widget.list!.map((value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                    style: mulishLight.copyWith(color: MyColor.bodyTextColor),
                  ),
                  value: value,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
