import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yummy_app/chekout_screen/controllers/checkout_controller.dart';
import 'package:yummy_app/home_screen/home.dart';
import 'package:yummy_app/models/models.dart';
import 'package:yummy_app/models/order.dart';
// import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({
    super.key,
  });

  final cartManager = Get.find<CartManager>();
  final orderManager = Get.find<OrderManager>();

  // Add State Properties
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text('Delivery'),
    1: Text('Self Pick-Up'),
  };

  final TextEditingController _nameController = TextEditingController();

  // Configure Date Format
  String fromatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Select Date';
    }
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  // Configure Time of Day
  String formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return 'Select Time';
    }
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Build Segmented Control
  Widget _buildOrderSegmentType() {
    return Obx(() {
      final controller = Get.find<CheckoutController>();

      return SegmentedButton<int>(
          segments: const [
            ButtonSegment(
              value: 0,
              label: Text('Delivery'),
              icon: Icon(Icons.pedal_bike),
            ),
            ButtonSegment(
              value: 1,
              label: Text('Picup'),
              icon: Icon(Icons.local_mall),
            ),
          ],
          selected: controller.selectedSegment, //selectedSegment.value,
          onSelectionChanged: controller.onSegmentSelected //onSegmentSelected,
          );
    });
  }

  // Build Name Textfield
  Widget _buildTextField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Contact Name',
      ),
    );
  }

  // Build Order Summary
  Widget _buildOrderSummary(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView.builder(
        itemCount: cartManager.items.length,
        itemBuilder: (context, index) {
          final item = cartManager.itemAt(index);
          // Wrap in a Dismissible Widget
          return Dismissible(
            direction: DismissDirection.startToEnd,
            key: Key(item.id),
            background: const SizedBox(
              child: Row(
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            secondaryBackground: const SizedBox(
              child: Row(
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            onDismissed: (direction) {
              cartManager.removeItem(item.id);
              // setState(() {

              // });
              // widget.didUpdate();
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  border: Border.all(color: colorTheme.primary, width: 2.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Text('x${item.quantity}'),
                ),
              ),
              title: Text(item.name),
              subtitle: Text('Price: \$${item.price}'),
            ),
          );
        },
      ),
    );
  }

  // Build Submit Order Button
  Widget _buildSubmitButton() {
    return Obx(() {
      final controller = Get.find<CheckoutController>();
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: cartManager.isEmpty
              ? null
              : () {
                  final selectedSegment = controller.selectedSegment.toSet();
                  final selectedTime = controller.selectedTime.value;
                  final selectedDate = controller.selectedDate.value;
                  final name = _nameController.text;
                  final items = cartManager.items;

                  final order = Order(
                      selectedSegment: selectedSegment,
                      selectedTime: selectedTime,
                      selectedDate: selectedDate,
                      name: name,
                      items: items);
                  cartManager.resetCart();
                  orderManager.addOrder(order);
                  Get.offAll(() => Home());
                },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                "Submit Order- \$${cartManager.totalCost.toStringAsFixed(2)}"),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Obx(() {
      final controller = Get.find<CheckoutController>();
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: textTheme.headlineSmall,
              ),
              // Add Segmented Control
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(width: double.infinity, child: _buildOrderSegmentType()),
              // Add Name Textfield
              _buildTextField(),
              // Add Date and Time Picker
              Row(
                children: [
                  TextButton(
                    onPressed: () => controller.selectDate(context),
                    child: Text(fromatDate(controller.selectedDate.value)),
                  ),
                  TextButton(
                    onPressed: () => {controller.selectTime(context)},
                    child: Text(
                      formatTimeOfDay(controller.selectedTime.value),
                    ),
                  ),
                ],
              ),
              const Text('Order Summary'),
              // Add Order Summary
              _buildOrderSummary(context),
              // Add Submit Order Button
              _buildSubmitButton(),
            ],
          ),
        ),
      );
    });
  }
}
