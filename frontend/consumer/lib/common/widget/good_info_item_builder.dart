import 'package:consumer/pages/good_detail_page.dart';
import 'package:consumer/type/good_info.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Widget buildWaterfallFlowGoodInfo(BuildContext ctx, GoodInfo item, int index, {bool knowSized = true}) {

  Widget imageHero = Stack(
    children: [
      ExtendedImage.network(
        item.imgUrl,
        clearMemoryCacheIfFailed: true,
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      )
    ],
  );

  return Card(
    child: InkWell(
      onTap: () => Navigator.of(ctx).push(
        MaterialPageRoute<void>(builder: (ctx) => GoodDetailPage(
          goodId: item.id,
          previewImageUrl: item.imgUrl, 
          imageHero: imageHero,
        ))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "${item.imgUrl}-preview-image-hero",
            child: imageHero
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(item.name, style: const TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("￥${item.price}", style: const TextStyle(fontSize: 16)),
                    Text("库存：${item.stock}")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}