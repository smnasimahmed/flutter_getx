import 'package:flutter/material.dart';
import 'package:yummy_app/home_screen/controllers/theme_controller.dart';
import 'package:yummy_app/route/app_route.dart';
import 'package:yummy_app/route/app_route_file.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ThemeController());
  runApp(Yummy());
}

class Yummy extends StatelessWidget {
  Yummy({super.key});

  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';

    return Obx(
      () {
        final selectedColor = themeController.colorselected.value.color;
        final themeMode = themeController.themeMode.value;
        return GetMaterialApp(
          title: appTitle,
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            colorSchemeSeed: selectedColor,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: selectedColor,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          initialRoute: AppRoute.home,
          getPages: appRoutesFile,
        );
      },
    );
  }
}
