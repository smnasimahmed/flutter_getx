import 'package:flutter/material.dart';
import 'package:yummy_app/components/restaurant_landscape_card.dart';
import 'package:yummy_app/models/models.dart';

class RestaurantSection extends StatelessWidget {
  final List<Restaurant> restaurants;
  final CartManager cartManager;
  final OrderManager orderManager;
  const RestaurantSection(
      {super.key,
      required this.restaurants,
      required this.cartManager,
      required this.orderManager});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8.0),
            child: Text(
              'Food near me',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // TODO: Add Restaurant List View
          SizedBox(
            height: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 300,
                    child: RestaurantLandscapeCard(
                      restaurant: restaurants[index],
                      cartManager: cartManager,
                      orderManager: orderManager,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
