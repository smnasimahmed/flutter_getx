import 'package:flutter/material.dart';
import 'package:yummy_app/chekout_screen/controllers/checkout_controller.dart';
import 'package:yummy_app/home_screen/controllers/theme_controller.dart'
    show ThemeController;
import 'package:yummy_app/home_screen/home.dart';
import 'models/models.dart';
import 'package:get/get.dart';

void main() {
  Get.put(CheckoutController());
  Get.put(OrderManager());
  Get.put(CartManager());
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
              brightness: Brightness.light),
          darkTheme: ThemeData(
            colorSchemeSeed: selectedColor,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          home: Home(),
        );
      },
    );
  }
}

// class Yummy extends StatefulWidget {
//   const Yummy({super.key});

//   @override
//   State<Yummy> createState() => _YummyState();
// }

// class _YummyState extends State<Yummy> {
//   ThemeMode themeMode = ThemeMode.light; //Manual theme toggle
//   ColorSelection colorselected = ColorSelection.pink;

//   /// Manage user's shopping cart for the items they order.
//   final CartManager _cartManager = CartManager();

//   /// Manage user's orders submitted
//   final OrderManager _orderManager = OrderManager();

//   void changeThemeMode(bool useLightMode) {
//     setState(() {
//       themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
//     });
//   }

//   void changeColor(int value) {
//     setState(() {
//       colorselected = ColorSelection.values[value];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Yummy';

//     return GetMaterialApp(
//       title: appTitle,
//       debugShowCheckedModeBanner: false,
//       themeMode: themeMode, //that upper themeMode variable
//       theme: ThemeData(
//         colorSchemeSeed: colorselected.color,
//         useMaterial3: true,
//         brightness: Brightness.light,
//       ),
//       darkTheme: ThemeData(
//           colorSchemeSeed: colorselected.color,
//           useMaterial3: true,
//           brightness: Brightness.dark),
//       home: Home(
//         colorselected: colorselected,
//         changeTheme: 
// 
// ,
//         changeColor: changeColor,
//         cartManager: _cartManager,
//         orderManager: _orderManager,
//       ),
//     );
//   }
// }
