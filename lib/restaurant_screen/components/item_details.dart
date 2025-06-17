import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:yummy_app/restaurant_screen/components/cart_control.dart';
import 'package:yummy_app/models/cart.dart';
import 'package:yummy_app/models/models.dart';

class ItemDetails extends StatelessWidget {
  final Item item;

  const ItemDetails({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final colourTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: textTheme.headlineMedium,
              ),
              // Add Liked Badge
              const SizedBox(
                height: 16.0,
              ),
              _mostLikedBadge(colourTheme),
              const SizedBox(
                height: 16.0,
              ),
              Text(item.description),
              // Add Item Image
              const SizedBox(
                height: 16.0,
              ),
              _itemImage(item.imageUrl),
              const SizedBox(
                height: 16.0,
              ),
              // Add Cart Control
              _addToCartControl(item),
            ],
          )
        ],
      ),
    );
  }
}

// Create Most Liked Badge
Widget _mostLikedBadge(ColorScheme colourTheme) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      color: colourTheme.onPrimary,
      padding: const EdgeInsets.all(4.0),
      child: const Text('#1 Most Liked'),
    ),
  );
}

// Create Item Image
Widget _itemImage(String imageUrl) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
    ),
  );
}

// Create Cart Control
Widget _addToCartControl(Item item) {
  final cartManager = Get.find<CartManager>();
  return CartControl(
    addToCart: (number) {
      const uuid = Uuid();
      final uniqueId = uuid.v4();
      final cartItem = CartItem(
          id: uniqueId, name: item.name, price: item.price, quantity: number);
      cartManager.addItem(cartItem);
      Future.microtask(() => Get.back());
    },
  );
}
