import 'package:consumer/api/cart_provider.dart';
import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final udc = Get.put(UserDetailController());
    final cp = Get.put(CartProvider());

    Widget guestPlaceholder = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off),
          const SizedBox(height: 8),
          const Text("请先登录后再查看购物车"),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Get.to(const AuthPage()),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("去登录", style: TextStyle(fontSize: 16)),
                Icon(Icons.login),
              ],
            )
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: udc.isLogin() ? ListView() : guestPlaceholder,
      bottomNavigationBar: const MallNavigationBar(),
    );
  }
}