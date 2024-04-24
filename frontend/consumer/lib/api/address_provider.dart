import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/domain/address.dart';
import 'package:consumer/domain/api_response.dart';
import 'package:consumer/env.dart';
import 'package:get/get.dart';

class AddressProvider extends GetConnect {
  final udc = Get.put(UserDetailController());

  Future<ApiResponse?> addAddress(Address address) async {
    return (await post("/v1/customer/address", address.toJson(),
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
  }

  Future<List<Address>> getAddresses() async {
    var response = (await get("/v1/customer/addresses",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
    if (response == null || response.data == null) {
      return [];
    }
    return (response.data as List).map((e) => Address.fromJson(e)).toList();
  }

  Future<Address?> getDefaultAddress() async {
    var response = (await get("/v1/customer/default-address",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
    if (response == null || response.data == null) {
      return null;
    }
    return (Address.fromJson(response.data));
  }

  Future<ApiResponse?> setDefaultAddress(String addressId) async {
    return (await put(
            "/v1/customer/default-address?address_id=$addressId", null,
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
  }

  Future<ApiResponse?> removeAddress(String addressId) async {
    return (await delete("/v1/customer/address?address_id=$addressId",
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
  }

  Future<ApiResponse?> removeAddresses(List<String> addressIds) async {
    return (await post("/v1/customer/address/delete", addressIds,
            decoder: (data) => ApiResponse.fromJson(data)))
        .body;
  }

  @override
  void onInit() {
    httpClient.baseUrl = Env.apiUri;
    httpClient.addRequestModifier<dynamic>((request) {
      if (udc.accessToken.isEmpty) return request;
      request.headers['Authorization'] = 'Bearer ${udc.accessToken}';
      return request;
    });
  }
}
