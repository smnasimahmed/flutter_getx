import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yummy_app/controller/theme_controller.dart';
import 'package:yummy_app/screens/explore_page.dart';
import 'package:yummy_app/screens/myorders_page.dart';
import 'components/theme_button.dart';
import 'components/color_button.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final colorSelected = Get.find<ThemeController>().colorselected.value.color;
  final RxInt tab = 0.obs;

  final List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(Icons.format_paint_outlined),
      label: 'Order',
      selectedIcon: Icon(Icons.format_paint_rounded),
    ),
    NavigationDestination(
      icon: Icon(Icons.account_circle_outlined),
      label: 'Account',
      selectedIcon: Icon(Icons.account_circle),
    )
  ];
  @override
  Widget build(BuildContext context) {
    final pages = [
      SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 10),
          child: ExplorePage()),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyordersPage(),
        ),
      ),
      const Center(child: Text('somethings')),
    ];
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: colorSelected,
            // backgroundColor: Theme.of(context).colorScheme.primary,
            // surfaceTintColor: colorSelected,
            title: const Text('Yummy'),
            actions: [
              ThemeButton(),
              ColorButton(),
            ],
          ),
          body: IndexedStack(
            index: tab.value,
            children: pages,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: tab.value,
            destinations: appBarDestinations,
            onDestinationSelected: (index) => tab.value = index,
          ),
        );
      },
    );
  }
}

// class Home extends StatefulWidget {
//   final ColorSelection colorselected;
//   final void Function(bool) changeTheme;
//   final void Function(int) changeColor;
//   final CartManager cartManager;
//   final OrderManager orderManager;
//   const Home({
//     super.key,
//     required this.colorselected,
//     required this.changeTheme,
//     required this.changeColor,
//     required this.cartManager,
//     required this.orderManager,
//   });

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   // Track current tab
//   int tab = 0;

//   // Define tab bar destinations
//   List<NavigationDestination> appBarDestinations = [
//     const NavigationDestination(
//       icon: Icon(Icons.home_outlined),
//       label: 'Home',
//       selectedIcon: Icon(Icons.home),
//     ),
//     // Replace with Order Page
//     const NavigationDestination(
//       icon: Icon(Icons.format_paint_outlined),
//       label: 'Order',
//       selectedIcon: Icon(Icons.format_paint_rounded),
//     ),
//     const NavigationDestination(
//       icon: Icon(Icons.account_circle_outlined),
//       label: 'Account',
//       selectedIcon: Icon(Icons.account_circle),
//     )
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final pages = [
//       SafeArea(
//         minimum: const EdgeInsets.symmetric(horizontal: 10),
//         child: ExplorePage(
//           cartManager: widget.cartManager,
//           orderManager: widget.orderManager,
//         ),
//       ),
//       Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: MyordersPage(orderManager: widget.orderManager),
//         ),
//       ),
//       Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 300),
//           child: RestaurantLandscapeCard(
//             restaurant: restaurants[0],
//             orderManager: widget.orderManager,
//             cartManager: widget.cartManager,
//           ),
//         ),
//       ),
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         surfaceTintColor: widget.colorselected.color,
//         actions: [
//           ThemeButton(changeThemeMode: widget.changeTheme),
//           ColorButton(
//               // changeColor: widget.changeColor,
//               // colorSelected: widget.colorselected,
//               ),
//         ],
//         elevation: 4.0,
//         title: const Text(
//           'Yummy',
//           style: TextStyle(fontSize: 24.0),
//         ),
//       ),
//       // Switch between pages
//       body: IndexedStack(
//         index: tab,
//         children: pages,
//         //Normally pages support cause page is a list that supports childern
//         // And controlled by tab setted from bottomNavigationBar
//       ),
//       // Add bottom navigation bar
//       bottomNavigationBar: NavigationBar(
//           selectedIndex: tab,
//           // This tab and that IndexedStack tab are controlled by same tab number
//           onDestinationSelected: (index) {
//             setState(() {
//               tab = index;
//             });
//           },
//           destinations: appBarDestinations),
//     );
//   }
// }
