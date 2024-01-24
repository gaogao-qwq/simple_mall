import 'dart:ui';

import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:decimal/decimal.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scc = Get.put(ShoppingCartController());
    final selectedCartItem = scc.cartList.where((e) => e.selected == true).toList();

    Widget purchaseGoddListView = ListView.builder(
      itemCount: selectedCartItem.length,
      itemBuilder: (ctx, idx) => SizedBox(
        height: 180,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.network(
                      selectedCartItem[idx].previewImgUrl,
                      shape: BoxShape.rectangle,
                      fit: BoxFit.fill,
                      clearMemoryCacheIfFailed: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          selectedCartItem[idx].goodDescription,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text("¥${selectedCartItem[idx].price} x ${selectedCartItem[idx].count} = "),
                          const Text("¥", style: TextStyle(color: Colors.red)),
                          const SizedBox(width: 2),
                          Text(
                            (Decimal.parse(selectedCartItem[idx].price)
                              * Decimal.fromInt(selectedCartItem[idx].count)).toStringAsFixed(2),
                            style: const TextStyle(color: Colors.red),
                            textScaler: const TextScaler.linear(1.75),
                          )
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

    Widget purchaseBar = Positioned(
      left: 12,
      right: 12,
      bottom: 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          child: Card(
            margin: const EdgeInsets.all(0),
            color: Get.theme.colorScheme.surface.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text("共${selectedCartItem.length}件，合计："),
                  const Text("¥", style: TextStyle(color: Colors.red)),
                  const SizedBox(width: 2),
                  Text(
                    "${selectedCartItem.map((e) => Decimal.parse(e.price) * Decimal.fromInt(e.count))
                      .fold(Decimal.fromInt(0), (prev, curr) => prev + curr)}",
                    style: const TextStyle(color: Colors.red),
                    textScaler: const TextScaler.linear(2),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.square(52), 
                    ),
                    onPressed: () {},
                    child: const Text("提交订单", textScaler: TextScaler.linear(1.5)),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );

    Widget purchaseWidget = Stack(
      children: [
        purchaseGoddListView,
        purchaseBar,
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text("确认订单")),
      body: purchaseWidget,
    );
  }
}
