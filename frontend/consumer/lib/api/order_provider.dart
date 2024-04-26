import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/domain/api_response.dart';
import 'package:consumer/domain/good_order_detail.dart';
import 'package:consumer/domain/good_order_info.dart';
import 'package:consumer/env.dart';
import 'package:get/get.dart';

class OrderProvider extends GetConnect {
  final udc = Get.put(UserDetailController());

  @override
  void onInit() {
    httpClient.baseUrl = Env.apiUri;
    httpClient.addRequestModifier<dynamic>((request) {
      if (udc.accessToken.isEmpty) return request;
      request.headers['Authorization'] = 'Bearer ${udc.accessToken}';
      return request;
    });
  }

  Future<List<GoodOrderInfo>> getOrders() async {
    var response = (await get("/v1/customer/orders",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
    if (response == null || response.data == null) {
      return [];
    }
    return (response.data as List)
        .map((e) => GoodOrderInfo.fromJson(e))
        .toList();
  }

  Future<GoodOrderDetail?> getOrderDetail(String id) async {
    var response = (await get("/v1/customer/order/$id",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
    if (response == null || response.data == null) {
      return null;
    }
    return GoodOrderDetail.fromJson(response.data);
  }
}
