import 'package:consumer/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MallNavigationBar extends StatelessWidget {
  const MallNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.put(NavigationBarController());

    return NavigationBar(
      selectedIndex: nc.currentIndex.value,
      destinations: [
        NavigationDestination(
          icon: Obx(() => nc.isDestinationSelected(0) 
            ? const Icon(Icons.home, color: Colors.deepPurple) 
            : const Icon(Icons.home_outlined)
          ),
          label: "主页",
        ),
        NavigationDestination(
          icon: Obx(() => nc.isDestinationSelected(1) 
            ? const Icon(Icons.shopping_cart, color: Colors.orange) 
            : const Icon(Icons.shopping_cart_outlined)
          ),
          label: "购物车",
        ),
        NavigationDestination(
          icon: Obx(() => nc.isDestinationSelected(2) 
            ? const Icon(Icons.person, color: Colors.blue) 
            : const Icon(Icons.person_outline)
          ),
          label: "我的"
        )
      ],
      onDestinationSelected: (i) => nc.changeIndex(i),
    );
  }
}