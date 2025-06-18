import 'package:get/get.dart';
import 'package:yummy_app/chekout_screen/controllers/checkout_controller.dart';
import 'package:yummy_app/controller/cart_manager.dart';
import 'package:yummy_app/controller/order_manager.dart';
import 'package:yummy_app/home_screen/controllers/theme_controller.dart';

class UserAppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController());
    Get.lazyPut(() => OrderManager());
    Get.lazyPut(() => CartManager());
    Get.lazyPut(() => ThemeController());
  }
}
