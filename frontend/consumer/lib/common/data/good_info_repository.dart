import 'package:consumer/api/good_provider.dart';
import 'package:consumer/type/good_info.dart';
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