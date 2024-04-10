import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/domain/page_info.dart';
import 'package:management/pages/good_management_page.dart';
import 'package:management/pages/overview_page.dart';
import 'package:management/pages/shipping_management_page.dart';
import 'package:management/pages/user_management_page.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  final pageInfos = <PageInfo>[
    const PageInfo(
      title: "系统概览",
      page: OverviewPage(),
      activeIcon: Icon(Icons.pie_chart),
      inactiveIcon: Icon(Icons.pie_chart_outline)
    ),
    const PageInfo(
      title: "商品管理",
      page: GoodManagementPage(),
      activeIcon: Icon(Icons.shopping_bag),
      inactiveIcon: Icon(Icons.shopping_bag_outlined)
    ),
    const PageInfo(
      title: "发货管理",
      page: ShippingManagementPage(),
      activeIcon: Icon(Icons.local_shipping),
      inactiveIcon: Icon(Icons.local_shipping_outlined)
    ),
    const PageInfo(
      title: "用户管理",
      page: UserManagementPage(),
      activeIcon: Icon(Icons.person),
      inactiveIcon: Icon(Icons.person_outline)
    ),
  ];

  void changeIndex(int idx) {
    currentIndex.value = idx;
  }

  bool isSelected(int idx) =>
    idx.isEqual(currentIndex.value);
}
