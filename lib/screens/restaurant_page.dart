import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/components/item_details.dart';
import 'package:yummy_app/components/restaurent_item.dart';
import 'package:yummy_app/models/models.dart';
import 'package:yummy_app/screens/checkout_page.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant restaurants;
  final CartManager cartManager;
  final OrderManager orderManager;
  RestaurantPage({
    super.key,
    required this.restaurants,
    required this.cartManager,
    required this.orderManager,
  });

// Add Desktop Threshold
  static const desktopThreshold = 700;

  // Add Constraint Properties
  static const largeScreenPercentage = 0.9;
  static const maxWidth = 1000;

  // Define Drawer Max Width
  static const double drawerWidth = 375.0;

  // Define Scaffold Key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Calculate Constrained Width
  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
            ? screenWidth * largeScreenPercentage
            : screenWidth)
        .clamp(0.0, maxWidth.toDouble());
  }

  // Add Calculate Column Count
  int calculateColumnCount(double screenWidth) {
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  // Build Custom Scroll View
  CustomScrollView _buildCustomScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _buildInfoSection(context),
        _buildGridViewSection(context, 'Menu'),
      ],
    );
  }

  // Build Sliver App Bar
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 64, right: 16),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                        image: AssetImage(restaurants.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: 16.0,
                  child: CircleAvatar(
                    radius: 30.0,
                    child: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Info Section
  SliverToBoxAdapter _buildInfoSection(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final restaurant = restaurants;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: textTheme.headlineLarge,
            ),
            Text(
              restaurant.address,
              style: textTheme.bodySmall,
            ),
            Text(
              restaurant.getRatingAndDistance(),
              style: textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }

  // Build Grid Item
  Widget _buildGridItem(BuildContext context, int index) {
    final item = restaurants.items[index];
    return InkWell(
      onTap: () {
        // Present Bottom Sheet in the future.
        _showBottomSheet(context, item);
      },
      child: RestaurantItem(item: item),
    );
  }

  // Build Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Build Grid View
  Widget _buildGridView(int columns) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3.5,
          crossAxisCount: columns),
      itemCount: restaurants.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildGridItem(context, index);
      },
    );
  }

  // Build Grid View Section
  SliverToBoxAdapter _buildGridViewSection(BuildContext context, String title) {
    final columns = calculateColumnCount(MediaQuery.of(context).size.width);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(title),
            _buildGridView(columns),
          ],
        ),
      ),
    );
  }

  // Show Bottom Sheet
  void _showBottomSheet(BuildContext context, Item item) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(maxWidth: 480),
      // Replace with Item Details Widget
      builder: (context) {
        return ItemDetails(
          item: item,
          // quantityUpdated: () => {
          //   a(
          //     () {},
          //   ),
          // },
        );
      },
    );
  }

  // Create Drawer
  Widget _buildEndDrawer() {
    return SizedBox(
      width: drawerWidth,
      // Replace with Checkout Page
      child: CheckoutPage(
          // cartManager: widget.cartManager,
          // didUpdate: () {
          //   setState(() {});
          // },
          // onSubmit: (order) {
          //   widget.orderManager.addOrder(order);
          //   Navigator.popUntil(context, (route) => route.isFirst);
          // },
          ),
    );
  }

  // Open Drawer
  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  // Create Floating Action Button
  Widget _buildFloatingActionButton() {
    final cartManager = Get.find<CartManager>();
    return Obx(() {
      return FloatingActionButton.extended(
        onPressed: openDrawer,
        label: Text("${cartManager.items.length} Items in cart"),
        tooltip: 'Cart',
        icon: const Icon(Icons.shopping_cart),
      );
    });
  }

  // Replace build method
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);
    return Scaffold(
      // Add Scaffold Key
      key: scaffoldKey,
      // Apply Drawer
      endDrawer: _buildEndDrawer(),
      // Apply Floating Action Button
      floatingActionButton: _buildFloatingActionButton(),
      body: Center(
        // Replace with Custom Scroll View
        child: SizedBox(
          width: constrainedWidth,
          child: _buildCustomScrollView(context),
        ),
      ),
    );
  }
}
