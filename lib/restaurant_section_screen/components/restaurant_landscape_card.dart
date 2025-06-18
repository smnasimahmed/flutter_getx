import 'package:flutter/material.dart';
import 'package:yummy_app/models/models.dart';
import 'package:get/get.dart';
import 'package:yummy_app/route/app_route.dart';
// import 'package:yummy_app/models/restaurant.dart';

// ignore: must_be_immutable
class RestaurantLandscapeCard extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantLandscapeCard({
    super.key,
    required this.restaurant,
  });

  // Add _isFavorited property
  final RxBool _isFavorite = false.obs;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add Image with ClipRRect
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    restaurant.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: IconButton(
                      color: Colors.red,
                      iconSize: 30.0,
                      onPressed: () {
                        _isFavorite.value = !_isFavorite.value;
                        // setState(() {

                        // });
                      },
                      icon: Icon(_isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add Listile
          ListTile(
            title: Text(
              restaurant.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              restaurant.attributes,
              style: textTheme.bodySmall,
            ),
            onTap: () {
              Get.toNamed(AppRoute.rastaurentPage, arguments: restaurant);
            },
          ),
        ],
      ),
    );
  }
}
