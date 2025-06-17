import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/constants.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  Rx<ColorSelection> colorselected = ColorSelection.pink.obs;

  void changeThemeMode(bool isLight) {
    themeMode.value = isLight ? ThemeMode.light : ThemeMode.dark;
  }

  void changeColor(int index) {
    colorselected.value = ColorSelection.values[index];
  }
}
