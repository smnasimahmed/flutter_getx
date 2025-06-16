import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/controller/order_manager.dart';
import 'package:yummy_app/models/order.dart';

class MyordersPage extends StatelessWidget {
  MyordersPage({super.key});
  final orderManager = Get.find<OrderManager>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              'My Orders',
              style: textTheme.headlineMedium,
            ),
          ),
          body: ListView.builder(
            itemCount:
                orderManager.totalOrders, // widget.orderManager.totalOrders,
            itemBuilder: (context, index) {
              return OrderTile(order: orderManager.orders[index]);
            },
          ),
        );
      },
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/food/burger.webp',
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduled',
            style: textTheme.bodyLarge,
          ),
          Text(order.getFormattedOrderInfo()),
          Text("Items: ${order.items.length}"),
        ],
      ),
    );
  }
}


// class MyordersPage extends StatefulWidget {
//   // final OrderManager orderManager;
//   MyordersPage({super.key});
//   final orderManager = Get.find<OrderManager>();
//   @override
//   State<MyordersPage> createState() => _MyordersPageState();
// }

// class _MyordersPageState extends State<MyordersPage> {
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context)
//         .textTheme
//         .apply(displayColor: Theme.of(context).colorScheme.onSurface);
//     return Obx(() {
//       return Scaffold(
//         appBar: AppBar(
//           centerTitle: false,
//           title: Text(
//             'My Orders',
//             style: textTheme.headlineMedium,
//           ),
//         ),
//         body: ListView.builder(
//           itemCount: widget.orderManager.totalOrders,
//           itemBuilder: (context, index) {
//             return OrderTile(order: widget.orderManager.orders[index]);
//           },
//         ),
//       );
//     });
//   }
// }

