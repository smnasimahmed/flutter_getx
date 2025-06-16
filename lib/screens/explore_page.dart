import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/api/mock_yummy_service.dart';
import 'package:yummy_app/components/category_section.dart';
import 'package:yummy_app/components/post_section.dart';
import 'package:yummy_app/components/restaurant_section.dart';
// import 'package:yummy_app/models/cart_manager.dart';
import 'package:yummy_app/models/models.dart';

class ExplorePage extends StatelessWidget {
  final mockService = MockYummyService();
  // final CartManager cartManager;
  // final OrderManager orderManager;
  ExplorePage({super.key});
  // Direct Calling Using GetX
  final orderManager = Get.find<OrderManager>();
  final cartManager = Get.find<CartManager>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final restaurants = snapshot.data?.restaurants ?? [];
          final categories = snapshot.data?.categories ?? [];
          final posts = snapshot.data?.friendPosts ?? [];
          // Replace this with Restaurant Section
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              RestaurantSection(
                restaurants: restaurants,
                orderManager: orderManager,
                cartManager: cartManager,
              ),
              // TODO: Add CategorySection
              CategorySection(categories: categories),
              // TODO: Add PostSection
              PostSection(posts: posts),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
