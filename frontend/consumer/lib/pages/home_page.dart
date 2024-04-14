import 'package:card_swiper/card_swiper.dart';
import 'package:consumer/api/good_provider.dart';
import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/components/mall_navigation_rail.dart';
import 'package:consumer/components/theme_mode_popup_menu_button.dart';
import 'package:consumer/domain/good_info.dart';
import 'package:consumer/enum/layout_size.dart';
import 'package:consumer/pages/good_detail_page.dart';
import 'package:consumer/pages/search_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

class GoodInfoRepository extends LoadingMoreBase<GoodInfo> {
  final gp = Get.put(GoodProvider());
  int page = 0;
  int size = 10;
  bool _hasMore = true;

  @override
  bool get hasMore => _hasMore;

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    if (!_hasMore) return false;
    var goodCount = await gp.getCount();
    var goodInfos = await gp.getGoods(page, size);
    for (var e in goodInfos) {
      add(e);
    }
    page++;
    _hasMore = goodCount > page * size;
    return true;
  }
}

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
                child: Icon(Icons.close, semanticLabel: "未知错误"));
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
              itemBuilder: (ctx, idx) => ExtendedImage.network(
                  snp.data![idx].imgUrl,
                  clearMemoryCacheIfFailed: false,
                  shape: BoxShape.rectangle,
                  fit: BoxFit.cover,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4), width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  loadStateChanged: (state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("载入商品 banner 图中"),
                        ]);
                  case LoadState.completed:
                    return null;
                  case LoadState.failed:
                    return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, semanticLabel: "未知错误"),
                          Text("未知错误"),
                        ]);
                }
              }),
            );
          }
          return const CircularProgressIndicator(
            semanticsLabel: "载入商品 banner 图中",
          );
        });

    Widget buildWaterfallFlowGoodInfo(
        BuildContext ctx, GoodInfo item, int index,
        {bool knowSized = true}) {
      return Card(
        child: InkWell(
          onTap: () => Navigator.of(ctx).push(MaterialPageRoute<void>(
              builder: (ctx) => GoodDetailPage(
                    goodId: item.id,
                    previewImageUrl: item.imgUrl,
                  ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "${item.imgUrl}-preview-image-hero",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ExtendedImage.network(
                    item.imgUrl,
                    fit: BoxFit.cover,
                    clearMemoryCacheIfFailed: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(item.name, style: const TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("￥${item.price}",
                            style: const TextStyle(fontSize: 16)),
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

    PreferredSizeWidget mobileAppBar = AppBar(
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
          onTap: () => Get.to(const SearchPage()),
        ),
      ),
    );

    PreferredSizeWidget desktopAppBar = AppBar(
      title: const Text("简商"),
      actions: const [
        ThemeModePopupMenu(),
      ],
    );

    Widget waterfallScrollView = LoadingMoreCustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: swiper),
        LoadingMoreSliverList<GoodInfo>(
          SliverListConfig<GoodInfo>(
            extendedListDelegate:
                SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  context.width <= LayoutSize.tablet.maxWidth ? 2 : 3,
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
    );

    return Scaffold(
        appBar: context.width <= LayoutSize.mobile.maxWidth
            ? mobileAppBar
            : desktopAppBar,
        body: context.width <= LayoutSize.mobile.maxWidth
            ? waterfallScrollView
            : Row(children: [
                const MallNavigationRail(),
                Expanded(child: waterfallScrollView),
              ]),
        bottomNavigationBar: context.width <= LayoutSize.mobile.maxWidth
            ? const MallNavigationBar()
            : null);
  }
}
