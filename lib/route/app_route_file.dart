import 'package:get/get.dart';
import 'package:yummy_app/chekout_screen/checkout_page.dart';
import 'package:yummy_app/home_screen/home.dart';
import 'package:yummy_app/restaurant_screen/restaurant_page.dart';
import 'package:yummy_app/route/app_route.dart';
import 'package:yummy_app/route/bindings/user_app_bindings.dart';

List<GetPage> appRoutesFile = <GetPage>[
  GetPage(
      name: AppRoute.home,
      page: () => Home(),
      binding: UserAppBindings(),
      middlewares: []),
  GetPage(
      name: AppRoute.checkOutPage,
      page: () => CheckoutPage(),
      binding: UserAppBindings(),
      middlewares: []),
  GetPage(
      name: AppRoute.rastaurentPage,
      page: () => RestaurantPage(),
      binding: UserAppBindings(),
      middlewares: []),
];
