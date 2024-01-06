import 'package:consumer/domain/good_info.dart';
import 'package:consumer/pages/good_detail_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Widget buildWaterfallFlowGoodInfo(BuildContext ctx, GoodInfo item, int index, {bool knowSized = true}) {

  Widget imageHero = ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: ExtendedImage.network(
      item.imgUrl,
      fit: BoxFit.cover,
      clearMemoryCacheIfFailed: true,
    ),
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
