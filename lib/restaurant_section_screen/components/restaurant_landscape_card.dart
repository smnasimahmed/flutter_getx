import 'package:flutter/material.dart';
import 'package:yummy_app/models/models.dart';
import 'package:yummy_app/restaurant_screen/restaurant_page.dart';
import 'package:get/get.dart';
// import 'package:yummy_app/models/restaurant.dart';

class RestaurantLandscapeCard extends StatefulWidget {
  final Restaurant restaurant;
  // final CartManager cartManager;
  // final OrderManager orderManager;
  const RestaurantLandscapeCard({
    super.key,
    required this.restaurant,
    // required this.cartManager,
    // required this.orderManager,
  });

  @override
  State<RestaurantLandscapeCard> createState() =>
      _RestaurantLandscapeCardState();
}

class _RestaurantLandscapeCardState extends State<RestaurantLandscapeCard> {
  // TODO: Add _isFavorited property
  bool _isFavorite = false;
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
                    widget.restaurant.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: IconButton(
                      color: Colors.red,
                      iconSize: 30.0,
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TODO: Add Listile
          ListTile(
            title: Text(
              widget.restaurant.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              widget.restaurant.attributes,
              style: textTheme.bodySmall,
            ),
            onTap: () {
              Get.to(
                () => RestaurantPage(
                  restaurants: widget.restaurant,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
