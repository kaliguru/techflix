import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../components/rounded_button.dart';

class ButtonGetStart extends StatelessWidget {
  final Callback press;
  const ButtonGetStart({Key? key,required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RoundedButton(
          text: MyStrings.getStarted,
          press: press),
    );
  }
}
