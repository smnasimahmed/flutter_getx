import 'package:get/get.dart';
import 'package:yummy_app/models/cart.dart';

enum DeliveryMode { delivery, pickup }

class CartManager extends GetxController {
  final RxList<CartItem> _items = <CartItem>[].obs;
  final Rx<DeliveryMode> _mode = DeliveryMode.pickup.obs;
  final Rx<DateTime?> _timeOfPickupOrDelivery = Rxn<DateTime>();

  // Add a new item to the cart
  void addItem(CartItem item) {
    _items.add(item);
  }

  // Remove an item from the cart by its id
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  // Reset the shopping cart
  void resetCart() {
    _items.clear();
    _mode.value = DeliveryMode.pickup;
    _timeOfPickupOrDelivery.value = null;
  }

  // Retrieve the item for a specific index.
  CartItem itemAt(int index) {
    if (index >= 0 && index < _items.length) {
      return _items[index];
    } else {
      throw IndexError.withLength(index, _items.length);
    }
  }

  // Calculate the total cost of the cart
  double get totalCost {
    return _items.fold(0.0, (sum, item) => sum + item.totalCost);
  }

  // Get list of items in the cart
  List<CartItem> get items => List.unmodifiable(_items);

  // Check if the cart is empty.
  bool get isEmpty => _items.isEmpty;

  // Set delivery or pickup mode
  void setMode(DeliveryMode mode) {
    _mode.value = mode;
  }

  // Get current mode (Delivery or Pickup)
  DeliveryMode get mode => _mode.value;

  // Set time for pickup or delivery
  void setTime(DateTime time) {
    _timeOfPickupOrDelivery.value = time;
  }

  // Get time of pickup or delivery
  DateTime? get time => _timeOfPickupOrDelivery.value;
}
