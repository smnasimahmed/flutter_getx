import 'package:flutter/material.dart';
import '../models/food_category.dart';

class CategoryCard extends StatelessWidget {
  final FoodCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Get text theme
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    // Replace with Card widget
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add Stack Widget
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
            child: Image.asset(category.imageUrl),
          ),
          // Add ListTile widget
          ListTile(
            title: Text(
              category.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              '${category.numberOfRastaurent} places',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
