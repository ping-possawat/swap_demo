import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFonts {
  static TextTheme textTheme = TextTheme(
    headline1: TextStyle(
      color: Get.theme.colorScheme.onPrimary,
      fontSize: 30,
    ),
    bodyText1: TextStyle(
      color: Get.theme.colorScheme.onPrimary,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      color: Get.theme.colorScheme.onSecondary,
      fontWeight: FontWeight.normal,
    ),
    subtitle1: TextStyle(
      color: Get.theme.colorScheme.onBackground,
      fontWeight: FontWeight.normal,
    ),
  );
}
