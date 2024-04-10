import 'package:get/get.dart';
import 'package:management/controller/user_detail_controller.dart';
import 'package:management/domain/api_response.dart';
import 'package:management/domain/count.dart';
import 'package:management/domain/good_info.dart';
import 'package:management/env.dart';

class GoodProvider extends GetConnect {
  final ac = Get.put(UserDetailController());

  @override
  void onInit() {
    httpClient.baseUrl = Env.apiUri;
    httpClient.addRequestModifier<dynamic>((request) {
      if (ac.accessToken.isEmpty) return request;
      request.headers['Authorization'] = 'Bearer ${ac.accessToken}';
      return request;
    });
  }

  Future<List<GoodInfo>> getGoods(int page, int size) async {
    var response = (await get(
      "/v1/good-management/list?page=$page&size=$size",
      decoder: (data) => ApiResponse.fromJson(data)
    )).body;
    if (response == null || response.data == null) {
      return [];
    }
    return (response.data as List)
      .map((e) => GoodInfo.fromJson(e)).toList();
  }

  Future<int> getCount() async {
    var response = (await get(
      "/v1/good-management/count",
      decoder: (data) => ApiResponse.fromJson(data)
    )).body;
    if (response == null || response.data == null) {
      return 0;
    }
    return Count.fromJson(response.data).count;
  }
}
