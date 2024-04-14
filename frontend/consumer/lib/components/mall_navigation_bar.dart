import 'package:consumer/controller/navigation_controller.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class MallNavigationBar extends StatelessWidget {
  const MallNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.put(NavigationController());
    final scc = Get.put(ShoppingCartController());
    scc.fetchCartItems();

    return NavigationBar(
      selectedIndex: nc.currentIndex.value,
      destinations: [
        NavigationDestination(
            icon: Obx(() => nc.isDestinationSelected(0)
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined)),
            label: "主页"),
        NavigationDestination(
            icon: Obx(() => nc.isDestinationSelected(1)
                ? badges.Badge(
                    badgeContent: Obx(() => Text("${scc.cartList.length}")),
                    badgeAnimation:
                        const badges.BadgeAnimation.slide(toAnimate: false),
                    showBadge: scc.cartList.isNotEmpty,
                    child: const Icon(Icons.shopping_cart))
                : badges.Badge(
                    badgeContent: Obx(() => Text("${scc.cartList.length}")),
                    badgeAnimation:
                        const badges.BadgeAnimation.slide(toAnimate: false),
                    showBadge: scc.cartList.isNotEmpty,
                    child: const Icon(Icons.shopping_cart_outlined))),
            label: "购物车"),
        NavigationDestination(
            icon: Obx(() => nc.isDestinationSelected(2)
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outline)),
            label: "我的")
      ],
      onDestinationSelected: (i) => nc.changeIndex(i),
    );
  }
}
