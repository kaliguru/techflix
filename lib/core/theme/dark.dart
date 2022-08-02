import 'package:flutter/material.dart';

import '../utils/my_color.dart';


ThemeData dark = ThemeData(
  fontFamily: 'Mulish',
  primaryColor: MyColor.primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2C2C2C),
  hintColor:  MyColor.gbr,
  focusColor: MyColor.gbr,
);