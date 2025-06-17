import 'package:flutter/material.dart';
import 'package:yummy_app/api/mock_yummy_service.dart';
import 'package:yummy_app/category_section_screen/category_section.dart';
import 'package:yummy_app/post_section_screen/post_section.dart';
import 'package:yummy_app/components/restaurant_section.dart';

class ExplorePage extends StatelessWidget {
  final mockService = MockYummyService();
  ExplorePage({super.key});
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
