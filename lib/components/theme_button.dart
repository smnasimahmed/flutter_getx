import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/home_screen/controllers/theme_controller.dart';

class ThemeButton extends StatelessWidget {
  ThemeButton({super.key});

  // final Function changeThemeMode;

  final ThemeController controller = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    //Theme.of(context).brightness == Brightness.light;
    return Obx(
      () {
        final isLight = controller.themeMode.value == ThemeMode.light;
        return IconButton(
            onPressed: () => controller.changeThemeMode(!isLight),
            icon: isLight
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode_outlined));
      },
    );
  }
}
