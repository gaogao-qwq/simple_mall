import 'package:consumer/controller/navigation_controller.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/enum/layout_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class MallNavigationRail extends StatelessWidget {
  const MallNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.put(NavigationController());
    final scc = Get.put(ShoppingCartController());
    scc.fetchCartItems();

    return NavigationRail(
      selectedIndex: nc.currentIndex.value,
      extended: context.width > LayoutSize.tablet.maxWidth,
      labelType: context.width > LayoutSize.tablet.maxWidth
          ? null
          : NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
            icon: Obx(() => nc.isDestinationSelected(0)
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined)),
            label: const Text("主页")),
        NavigationRailDestination(
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
          label: const Text("购物车"),
        ),
        NavigationRailDestination(
            icon: Obx(() => nc.isDestinationSelected(2)
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outline)),
            label: const Text("我的")),
      ],
      onDestinationSelected: (i) => nc.changeIndex(i),
    );
  }
}
