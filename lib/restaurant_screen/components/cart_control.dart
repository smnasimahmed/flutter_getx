import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartControl extends StatelessWidget {
  final void Function(int) addToCart;
  CartControl({super.key, required this.addToCart});

  // int _cartNumber = 1;
  final RxInt _cartNumber = 1.obs;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Add Cart Control Components
        _buildMinusButton(),
        _buildCartNumberContainer(colorScheme),
        _buildPlusButton(),
        const Spacer(),
        _buildAddCartButton(colorScheme),
        // Container(
        //   color: Colors.red,
        //   height: 44.0,
        // ),
      ],
    );
  }

  // Build Minus Button
  Widget _buildMinusButton() {
    return IconButton(
      onPressed: () {
        if (_cartNumber.value > 1) {
          _cartNumber.value--;
        }
        // setState(() {
        //   if (_cartNumber > 1) {
        //     _cartNumber--;
        //   }
        // });
      },
      icon: const Icon(Icons.remove),
      tooltip: 'Decrease Cart Count',
    );
  }

  // Build Cart Number
  Widget _buildCartNumberContainer(ColorScheme colorScheme) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: colorScheme.onPrimary,
        child: Text(
          _cartNumber.value.toString(), // _cartNumber.toString(),
        ),
      );
    });
  }

  // Build Plus Button
  Widget _buildPlusButton() {
    return IconButton(
      onPressed: () {
        _cartNumber.value++;
        // setState(() {});
      },
      icon: const Icon(Icons.add),
      tooltip: 'Increase Cart Count',
    );
  }

  // Build Add Cart Button
  Widget _buildAddCartButton(ColorScheme colorScheme) {
    return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary), //colorScheme.primary
      onPressed: () {
        addToCart(_cartNumber.value);
      },
      child: const Text('Add to Cart'),
    );
  }
}
