import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/domain/api_response.dart';
import 'package:consumer/domain/cart_item.dart';
import 'package:consumer/env.dart';
import 'package:get/get.dart';

class CartProvider extends GetConnect {
  final udc = Get.put(UserDetailController());
  final uc = Get.put(UserDetailController());

  @override
  void onInit() {
    httpClient.baseUrl = Env.apiUri;
    httpClient.addRequestModifier<dynamic>((request) {
      if (udc.accessToken.isEmpty) return request;
      request.headers['Authorization'] = 'Bearer ${udc.accessToken}';
      return request;
    });
  }

  Future<List<CartItem>> getCartItems() async {
    var response = (await get("/v1/customer/cart",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
    if (response == null || response.data == null) {
      return [];
    }
    return (response.data as List).map((e) => CartItem.fromJson(e)).toList();
  }

  Future<ApiResponse?> removeItemFromCart(int goodId) async {
    return (await delete("/v1/customer/cart?good_id=$goodId",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
  }

  Future<ApiResponse?> addItemToCart(int goodId) async {
    return (await put(
      "/v1/customer/cart?good_id=$goodId",
      null,
      decoder: (data) => ApiResponse.fromJson(data),
    ))
        .body;
  }

  Future<ApiResponse?> setCartItemCount(String cartItemId, int count) async {
    return (await put(
      "/v1/customer/cart-item/$cartItemId?count=$count",
      null,
      decoder: (data) => ApiResponse.fromJson(data),
    ))
        .body;
  }
}
