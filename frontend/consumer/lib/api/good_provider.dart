import 'package:consumer/api/api_response.dart';
import 'package:consumer/domain/count.dart';
import 'package:consumer/domain/good_detail.dart';
import 'package:consumer/domain/good_info.dart';
import 'package:consumer/domain/good_swiper.dart';
import 'package:get/get.dart';
import 'package:consumer/controller/user_detail_controller.dart';

class GoodProvider extends GetConnect {
  final ac = Get.put(UserDetailController());

  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8080';
    httpClient.addRequestModifier<dynamic>((request) {
      if (ac.accessToken.isEmpty) return request;
      request.headers['Authorization'] = 'Bearer ${ac.accessToken}';
      return request;
    });
  }

  Future<List<GoodInfo>> getGoods(int page, int size) async {
    var response = (await get(
      "/v1/good/list?page=$page&size=$size",
      decoder: (data) => ApiResponse.fromJson(data)
    )).body;
    if (response == null || response.data == null) {
      return [];
    }
    return (response.data as List).map((e) => GoodInfo.fromJson(e)).toList();
  }

  Future<int> getCount() async {
    var response = (await get(
      "/v1/good/count",
      decoder: (data) => ApiResponse.fromJson(data)
    )).body;
    if (response == null || response.data == null) {
      return 0;
    }
    return Count.fromJson(response.data).count;
  }

  Future<GoodDetail?> getDetail(int id) async {
    var response = (await get(
      "/v1/good/detail/$id",
      decoder: (data) => ApiResponse.fromJson(data)
    )).body;
    if (response == null || response.data == null) {
      return null;
    }
    return GoodDetail.fromJson(response.data);
  }

  Future<List<GoodSwiper>> getSwiper() async {
    var response = (await get(
      "/v1/good/swiper",
      decoder: (data) => ApiResponse.fromJson(data)
    )).body;
    if (response == null || response.data == null) {
      return [];
    }
    return (response.data as List).map((e) => GoodSwiper.fromJson(e)).toList();
  }
}
