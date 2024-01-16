import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:consumer/pages/good_detail_page.dart';
import 'package:decimal/decimal.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListItem extends StatelessWidget {
  final int idx;

  const CartListItem({
    super.key,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    final scc = Get.put(ShoppingCartController());

    return SizedBox(
      height: 180,
      child: Card(
        child: InkWell(
          onTap: () {
            Get.to(GoodDetailPage(
              goodId: scc.cartList[idx].goodId,
              previewImageUrl: scc.cartList[idx].previewImgUrl,
            ));
          },
          child: Padding(
          padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                  tag: "${scc.cartList[idx].previewImgUrl}-preview-image-hero", 
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Obx(() => ExtendedImage.network(
                      scc.cartList[idx].previewImgUrl,
                      fit: BoxFit.cover,
                      clearMemoryCacheIfFailed: true,
                    )),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(() => Text(
                                scc.cartList[idx].goodDescription,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () => scc.setGoodCountInCart(
                                  scc.cartList[idx].id, scc.cartList[idx].count - 1),
                              icon: const Icon(Icons.remove),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Get.theme.colorScheme.primary),
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Obx(() => Text("x${scc.cartList[idx].count}")),
                              ),
                            ),
                            IconButton(
                              onPressed: () => scc.setGoodCountInCart(
                                  scc.cartList[idx].id, scc.cartList[idx].count + 1),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                            "单价：¥${scc.cartList[idx].price}",
                            style: const TextStyle(color: Colors.red)
                          )),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              const Text("总价：¥", style: TextStyle(color: Colors.red)),
                              Obx(() => Text(
                                (Decimal.parse(scc.cartList[idx].price) * 
                                Decimal.fromInt(scc.cartList[idx].count)).toStringAsFixed(2),
                                style: const TextStyle(fontSize: 24, color: Colors.red),
                              )),
                            ],
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
    // final cp = Get.put(CartProvider());
    final scc = Get.put(ShoppingCartController());

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
      future: scc.fetchCartItems(),
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
            itemBuilder: (ctx, idx) => CartListItem(idx: idx),
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
