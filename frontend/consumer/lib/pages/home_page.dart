import 'package:card_swiper/card_swiper.dart';
import 'package:consumer/api/good_provider.dart';
import 'package:consumer/common/data/good_info_repository.dart';
import 'package:consumer/common/widget/good_info_item_builder.dart';
import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/pages/search_page.dart';
import 'package:consumer/type/good_info.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

class GoodWaterfallController extends GetxController {
  var itemCount = 10.obs;
  final goods = <GoodInfo>[].obs;
  final listSourceRepository = GoodInfoRepository();

  @override
  void dispose() {
    listSourceRepository.dispose();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gwc = Get.put(GoodWaterfallController());
    final gp = Get.put(GoodProvider());

    Widget swiper = FutureBuilder(
      future: gp.getSwiper(),
      builder: (ctx, snp) {
        if (snp.hasError) {
          return const Center(
            child: Icon(Icons.close, semanticLabel: "未知错误")
          );
        }

        if (snp.hasData) {
          return Swiper(
            loop: true,
            layout: SwiperLayout.STACK,
            itemHeight: 200,
            itemWidth: 400,
            indicatorLayout: PageIndicatorLayout.NONE,
            autoplay: true,
            itemCount: snp.data!.length,
            itemBuilder: (ctx, idx) =>
              ExtendedImage.network(
                snp.data![idx].imgUrl,
                clearMemoryCacheIfFailed: false,
                shape: BoxShape.rectangle,
                fit: BoxFit.cover,
                border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("载入商品 banner 图中"),
                        ]
                      );
                    case LoadState.completed:
                      return null;
                    case LoadState.failed:
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, semanticLabel: "未知错误"),
                          Text("未知错误"),
                        ]
                      );
                  }
                }
              ),
          );
        }

        return const CircularProgressIndicator(semanticsLabel: "载入商品 banner 图中",);
      }
    );

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            decoration: const InputDecoration(
              hintText: "搜索",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              isDense: true,
              prefixIcon: Icon(Icons.search),
            ),
            onTap: () {
              Get.to(const SearchPage());
            },
          ),
        ),
      ),
      body: LoadingMoreCustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: swiper),
          LoadingMoreSliverList<GoodInfo>(
            SliverListConfig<GoodInfo>(
              extendedListDelegate:
                  const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: buildWaterfallFlowGoodInfo,
              sourceList: gwc.listSourceRepository,
              padding: const EdgeInsets.all(5),
              indicatorBuilder: (ctx, status) {
                switch (status) {
                  case IndicatorStatus.none:
                    return Container(
                      constraints: const BoxConstraints(
                        maxHeight: 0,
                        maxWidth: 0,
                      ),
                    );
                  case IndicatorStatus.loadingMoreBusying:
                    return Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxWidth: double.infinity,
                        minHeight: 35,
                      ),
                      child: const Text("加载中，别急"),
                    );
                  case IndicatorStatus.noMoreLoad:
                    return Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxWidth: double.infinity,
                        minHeight: 35,
                      ),
                      child: const Text("没有更多了"),
                    );
                  default:
                    return null;
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MallNavigationBar(),
    );
  }
}
