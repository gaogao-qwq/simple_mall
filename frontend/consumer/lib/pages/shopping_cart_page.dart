import 'dart:ui';

import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/components/mall_navigation_rail.dart';
import 'package:consumer/controller/address_contrller.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/enum/layout_size.dart';
import 'package:consumer/pages/address_book_page.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:consumer/pages/good_detail_page.dart';
import 'package:consumer/pages/purchase_page.dart';
import 'package:decimal/decimal.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final formKey = GlobalKey<FormState>();
    String dialogCount = "";

    Widget goodPreviewImageView = SizedBox.square(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExtendedImage.network(
          scc.cartList[idx].previewImgUrl,
          shape: BoxShape.rectangle,
          fit: BoxFit.cover,
          clearMemoryCacheIfFailed: true,
        ),
      ),
    );

    Widget priceTag = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text("单价：¥${scc.cartList[idx].price}",
              style: const TextStyle(color: Colors.red))),
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              const Text("总价：¥", style: TextStyle(color: Colors.red)),
              Obx(() => Text(
                  (Decimal.parse(scc.cartList[idx].price) *
                          Decimal.fromInt(scc.cartList[idx].count))
                      .toStringAsFixed(2),
                  textScaler: const TextScaler.linear(1.75),
                  style: const TextStyle(color: Colors.red))),
            ],
          ),
        ],
      ),
    );

    List<Widget> goodCountSelector = [
      IconButton(
        onPressed: () => scc.setGoodCountInCart(
            scc.cartList[idx], scc.cartList[idx].count - 1),
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
                    border: OutlineInputBorder(), labelText: "商品数量"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "数量不能为空";
                  }
                  var count = int.tryParse(value);
                  if (count == null) return "请输入有效数字";
                  if (count < 0) return "商品数量至少为0";
                  if (count > scc.cartList[idx].purchaseLimit) {
                    return "商品数量不得大于限购数量";
                  }
                  return null;
                },
                onChanged: (value) => dialogCount = value,
              ),
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: const Text("取消")),
              FilledButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    scc.setGoodCountInCart(
                        scc.cartList[idx], int.parse(dialogCount));
                    Get.back();
                  },
                  child: const Text("确认")),
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
            scc.cartList[idx], scc.cartList[idx].count + 1),
        icon: const Icon(Icons.add),
      ),
    ];

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
                goodPreviewImageView,
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          priceTag,
                          ...goodCountSelector,
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
    final addrc = Get.put(AddressController());

    Widget addressCard = Obx(
      () => Card(
          margin: const EdgeInsets.all(2),
          child: addrc.defaultAddress == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Text("未设置默认收货地址",
                            textScaler: TextScaler.linear(1.5)),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () => Get.to(const AddressBookPage()),
                          child: const Text("选择默认地址",
                              textScaler: TextScaler.linear(1.25)),
                        ),
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => Get.to(const AddressBookPage()),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("默认收货地址",
                            textScaler: TextScaler.linear(1.5)),
                        Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 8),
                            Text(addrc.defaultAddress!.recipient,
                                textScaler: const TextScaler.linear(1.25)),
                            const SizedBox(width: 8),
                            Text(addrc.defaultAddress!.phoneNumber)
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.local_shipping),
                            const SizedBox(width: 8),
                            Text(addrc.defaultAddress!.province.fullname),
                            const SizedBox(width: 8),
                            Text(addrc.defaultAddress!.detail),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
    );

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
              ))
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
              addressCard,
              ...List.generate(
                  scc.cartList.length, (idx) => CartListItem(idx: idx)),
              const SizedBox(height: 128),
            ],
          ));

    Widget cartBar = Positioned(
      bottom: 12,
      left: 12,
      right: 12,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          child: Card(
            margin: const EdgeInsets.all(0),
            color: Get.theme.colorScheme.surface.withOpacity(0.8),
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
                      Obx(() => Text(
                          "已选${scc.cartList.where((v) => v.selected == true).length}件，合计：")),
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
                        minimumSize: const Size.square(52),
                      ),
                      onPressed: () {
                        if (scc.selectCount == 0) {
                          Get.rawSnackbar(title: "Oops", message: "没有选择要结算的商品");
                          return;
                        }
                        Get.to(const PurchasePage());
                      },
                      child: const Text("结算",
                          textScaler: TextScaler.linear(1.25))),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Widget cartWidget = Stack(
      children: [
        cartListView,
        if (scc.cartList.isNotEmpty) cartBar,
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text("购物车")),
      body: context.width <= LayoutSize.mobile.maxWidth
          ? Obx(() => udc.isLogin() ? cartWidget : guestPlaceholder)
          : Row(children: [
              const MallNavigationRail(),
              Expanded(
                  child:
                      Obx(() => udc.isLogin() ? cartWidget : guestPlaceholder))
            ]),
      bottomNavigationBar: context.width <= LayoutSize.mobile.maxWidth
          ? const MallNavigationBar()
          : null,
    );
  }
}
