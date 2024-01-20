import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:consumer/pages/good_detail_page.dart';
import 'package:consumer/pages/purchase_page.dart';
import 'package:decimal/decimal.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Horrible indent, might fix in future?
class CartListItem extends StatelessWidget {
  final int idx;

  const CartListItem({
    super.key,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    final scc = Get.put(ShoppingCartController());
    final formKey = GlobalKey<FormState>();
    String dialogCount = "";

    return SizedBox(
      height: 180,
      child: Card(
        child: InkWell(
          onLongPress: () => scc.toggleSelect(idx, !scc.cartList[idx].selected),
          onTap: () => Get.to(GoodDetailPage(
            goodId: scc.cartList[idx].goodId,
            previewImageUrl: scc.cartList[idx].previewImgUrl,
          )),
          child: Padding(
          padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Obx(() => Checkbox(
                  value: scc.cartList[idx].selected,
                  onChanged: (value) => scc.toggleSelect(idx, value!),
                )),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Obx(() => ExtendedImage.network(
                      scc.cartList[idx].previewImgUrl,
                      shape: BoxShape.rectangle,
                      fit: BoxFit.cover,
                      clearMemoryCacheIfFailed: true,
                    )),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() => Text(
                          scc.cartList[idx].goodDescription,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
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
                                      textScaler: const TextScaler.linear(1.75),
                                      style: const TextStyle(color: Colors.red)
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => scc.setGoodCountInCart(
                                scc.cartList[idx].id, scc.cartList[idx].count - 1),
                            icon: const Icon(Icons.remove),
                          ),
                          InkWell(
                            onTap: () {
                              dialogCount = scc.cartList[idx].count.toString();
                              Get.dialog(AlertDialog(
                                title: const Text("请输入商品数量"),
                                content: Form(
                                  key: formKey,
                                  child: TextFormField(
                                    initialValue: scc.cartList[idx].count.toString(),
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "商品数量"
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return "数量不能为空";
                                      var count = int.tryParse(value);
                                      if (count == null) return "请输入有效数字";
                                      if (count <= 0) return "商品数量至少为1";
                                      return null;
                                    },
                                    onChanged: (value) => dialogCount = value,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("取消")
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      if (!formKey.currentState!.validate()) return;
                                      scc.setGoodCountInCart(scc.cartList[idx].id, int.parse(dialogCount));
                                      Get.back();
                                    },
                                    child: const Text("确认")
                                  ),
                                ],
                              ));
                            },
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
                Text("去登录"),
                Icon(Icons.login),
              ],
            )
          )
        ],
      ),
    );

    Widget cartListView = Obx(() => scc.cartList.isEmpty
      ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined),
              Text("购物车里空空如也"),
            ],
          ),
        )
      : ListView(
          children: [
            ...List.generate(scc.cartList.length, (idx) => CartListItem(idx: idx)),
            const SizedBox(height: 128),
          ],
        )
    );

    Widget cartWidget = Stack(
      children: [
        cartListView,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Card(
            margin: const EdgeInsets.all(0),
            color: Get.theme.colorScheme.surface.withOpacity(0.9),
            shape: const RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Obx(() => Checkbox(
                          value: scc.isSelectAll,
                          onChanged: (value) => scc.toggleSelectAll(),
                        )),
                        const Text("全选"),
                      ],
                    ),
                  ),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Obx(() => Text("已选${scc.cartList.where((v) => v.selected == true).length}件，合计：")),
                      const Text("¥", style: TextStyle(color: Colors.red)),
                      Obx(() => Text(
                        scc.totalPrice.toStringAsFixed(2),
                        textScaler: const TextScaler.linear(2),
                        style: const TextStyle(color: Colors.red),
                      )),
                    ],
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.square(64),
                    ),
                    onPressed: () {
                      Get.to(const PurchasePage());
                    },
                    child: const Text("结算", textScaler: TextScaler.linear(1.25))
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: Obx(() => udc.isLogin() ? cartWidget : guestPlaceholder),
      bottomNavigationBar: const MallNavigationBar(),
    );
  }
}
