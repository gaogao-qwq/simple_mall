import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/components/mall_navigation_rail.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/enum/layout_size.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:consumer/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final udc = Get.put(UserDetailController());
    final scc = Get.put(ShoppingCartController());

    Widget myPageListView = Column(
      children: [
        Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: Image.asset("images/avatar.png").image,
                    ),
                    title: Obx(() => udc.isLogin()
                        ? Text(udc.username.value,
                            style: const TextStyle(fontSize: 24))
                        : const Text("未登录，请先登录")),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      if (!udc.isLogin()) {
                        Get.to(const AuthPage());
                      }
                    }))),
        Card(
          margin: const EdgeInsets.all(2),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("设置"),
                onTap: () => Get.to(const SettingsPage()),
              ),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("退出登录"),
                  onTap: () {
                    udc.removeUser();
                    scc.clearCartItems();
                  }),
              ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("关于"),
                  onTap: () => showAboutDialog(
                      context: context,
                      applicationName: "简单商城",
                      applicationLegalese: "CopyRight © 2023 Zhihao Zhou")),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(title: const Text("我的")),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (context.width <= LayoutSize.mobile.maxWidth) {
              return myPageListView;
            } else {
              return Row(
                children: [
                  const MallNavigationRail(),
                  Expanded(child: myPageListView),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: context.width <= LayoutSize.mobile.maxWidth
            ? const MallNavigationBar()
            : null);
  }
}
