import 'package:consumer/api/cart_provider.dart';
import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:decimal/decimal.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListItem extends StatelessWidget {
  final ExtendedImage thumbnail;
  final String goodName;
  final String goodDescription;
  final int goodStock;
  final String goodPrice;
  final int goodCount;

  const CartListItem({
    super.key,
    required this.thumbnail,
    required this.goodName,
    required this.goodDescription,
    required this.goodStock,
    required this.goodPrice,
    required this.goodCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        child: InkWell(
          onTap: () {},
          onLongPress: () {},
          child: Padding(
          padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: thumbnail,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Text(
                              goodDescription,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            )),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove)
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Get.theme.colorScheme.primary),
                                  borderRadius: const BorderRadius.all(Radius.circular(8))
                                ),
                                child: Text("x$goodCount"),
                              )
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add)
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("单价：¥$goodPrice", style: const TextStyle(color: Colors.red)),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              const Text("总价：¥", style: TextStyle(color: Colors.red)),
                              Text(
                                "${Decimal.parse(goodPrice) * Decimal.fromInt(goodCount)}",
                                style: const TextStyle(fontSize: 24, color: Colors.red),
                              )
                            ]
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                clearMemoryCacheIfFailed: true,
              ),
              goodName: snp.data![idx].goodName,
              goodDescription: snp.data![idx].goodDescription,
              goodStock: snp.data![idx].stock,
              goodPrice: snp.data![idx].price,
              goodCount: snp.data![idx].count,
            ),
          );
        }

        return const Center(child: CircularProgressIndicator(semanticsLabel: "加载购物车信息中"));
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: Obx(() => udc.isLogin() ? cartListView : guestPlaceholder),
      bottomNavigationBar: const MallNavigationBar(),
    );
  }
}
