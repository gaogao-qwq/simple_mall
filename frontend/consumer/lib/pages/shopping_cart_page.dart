import 'package:consumer/api/cart_provider.dart';
import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListItem extends StatelessWidget {
  final ExtendedImage thumbnail;
  final String goodName;
  final String goodPrice;

  const CartListItem({
    super.key,
    required this.thumbnail,
    required this.goodName,
    required this.goodPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: thumbnail,
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goodName),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      const Text("¥"),
                      Text(goodPrice, style: const TextStyle(fontSize: 18)),
                    ]
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

    Widget cartListView = FutureBuilder(
      future: cp.getCartItems(),
      builder: (ctx, snp) {
        if (snp.hasError) {
          return const Center(child: Text("获取购物车信息时出错"));
        }

        if (snp.hasData) {
          if (snp.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  Text("购物车里空空如也"),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snp.data!.length,
            itemBuilder: (ctx, idx) => CartListItem(
              thumbnail: ExtendedImage.network(
                snp.data![idx].previewImgUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                clearMemoryCacheIfFailed: true,
              ),
              goodName: snp.data![idx].goodName,
              goodPrice: snp.data![idx].price
            ),
          );
        }

        return const Center(child: CircularProgressIndicator(semanticsLabel: "加载购物车信息中"));
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: udc.isLogin() ? cartListView : guestPlaceholder,
      bottomNavigationBar: const MallNavigationBar(),
    );
  }
}
