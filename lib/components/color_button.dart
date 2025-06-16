import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/controller/theme_controller.dart';
import '../constants.dart';

class ColorButton extends StatelessWidget {
  // final void Function(int) changeColor;
  // final ColorSelection colorSelected;
  ColorButton({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final colorSelected = themeController.colorselected.value;

      return PopupMenuButton(
        icon: Icon(
          Icons.opacity_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        itemBuilder: (context) {
          return List.generate(
            // we use List.generate for static and few dataset
            ColorSelection.values.length,
            (index) {
              final currentColor = ColorSelection.values[index];
              // zei index e click korbo oi index er shob data currentColor e zabe
              return PopupMenuItem(
                // PopupMenuItem passes the clicked data to onSelected
                value: index,
                enabled: currentColor != colorSelected,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.opacity_outlined,
                        color: currentColor.color,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(currentColor.label),
                    ),
                  ],
                ),
              );
            },
          );
        },
        onSelected: themeController.changeColor,
      );
    });
  }
}
