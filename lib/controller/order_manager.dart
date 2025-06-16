// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:yummy_app/models/order.dart';
// import 'cart_manager.dart';

class OrderManager {
  final RxList<Order> _orders = <Order>[].obs;

  List<Order> get orders => _orders; // Getter to access teh orders

  void addOrder(Order order) {
    _orders.add(order);
  }

  void removeOrder(Order order) {
    _orders.remove(order);
  }

  int get totalOrders => _orders.length;
}
