import 'package:consumer/api/good_provider.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoodDetailPage extends StatelessWidget {
  final int goodId;
  final String previewImageUrl;

  const GoodDetailPage({
    super.key,
    required this.goodId,
    required this.previewImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final udc = Get.put(UserDetailController());
    final scc = Get.put(ShoppingCartController());
    final gp = Get.put(GoodProvider());

    Widget goodDetail = FutureBuilder(
      future: gp.getDetail(goodId),
      builder: (ctx, snp) {
        if (snp.hasError) {
          return const Center(
            child: Text("未知错误"),
          );
        }

        if (snp.hasData) {
          Widget detailCard = Card(
            color: Colors.orange.shade100,
            shadowColor: null,
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const SizedBox(width: 8),
                    const Text("价格：", style: TextStyle(fontSize: 16)),
                    const Text("￥", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(snp.data!.price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(snp.data!.description),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Text("库存: ${snp.data!.stock}"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          List<Widget> detailImages = snp.data!.detailImgUrl.map((e) => ExtendedImage.network(
            e,
            clearMemoryCacheIfFailed: true,
          )).toList();

          return Column(
            children: [
              detailCard,
              ...detailImages,
            ],
          );
        }

        return const CircularProgressIndicator(semanticsLabel: "加载商品信息中");
      },
    );

    Widget bottomAppBar = BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_shopping_cart),
                Text("加入购物车"),
              ],
            ),
            onPressed: () async {
              if (!udc.isLogin()) {
                await Get.defaultDialog(
                  title: "注意",
                  content: const Text("需要登录后才能加入购物车"),
                  textCancel: "取消",
                  textConfirm: "去登录",
                  onConfirm: () => Get.to(const AuthPage()),
                );
                return;
              }
              await scc.addGoodToCart(goodId);
            },
          ),
          ElevatedButton(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_money),
                Text("立即购买"),
              ],
            ),
            onPressed: () async {
              if (!udc.isLogin()) {
                await Get.defaultDialog(
                  title: "注意",
                  content: const Text("需要登录后才能购买"),
                  textCancel: "取消",
                  textConfirm: "去登录",
                  onConfirm: () => Get.to(const AuthPage()),
                );
                return;
              }
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("商品详情"),
      ),
      body: ListView(
        children: [
          Hero(
            tag: "$previewImageUrl-preview-image-hero",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ExtendedImage.network(
                previewImageUrl,
                fit: BoxFit.cover,
                clearMemoryCacheIfFailed: true,
              ),
            ),

          ),
          goodDetail,
        ],
      ),
      bottomNavigationBar: bottomAppBar,
    );
  }
}
