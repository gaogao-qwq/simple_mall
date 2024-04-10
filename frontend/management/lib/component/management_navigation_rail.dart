import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/controller/navigation_controller.dart';

class ManagementNavigationRail extends StatelessWidget {
  const ManagementNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.put(NavigationController());

    final destinations = List.generate(
      nc.pageInfos.length,
      (idx) => NavigationRailDestination(
        icon: Obx(() => nc.isSelected(idx)
          ? nc.pageInfos[idx].activeIcon
          : nc.pageInfos[idx].inactiveIcon),
        label: Text(nc.pageInfos[idx].title),
      )
    );

    return Obx(() => NavigationRail(
      extended: true,
      destinations: destinations,
      selectedIndex: nc.currentIndex.value,
      onDestinationSelected: (value) =>
        nc.changeIndex(value),
    ));
  }
}
