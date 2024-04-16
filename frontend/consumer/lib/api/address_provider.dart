import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/domain/address.dart';
import 'package:consumer/domain/api_response.dart';
import 'package:consumer/env.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class AddressProvider extends GetConnect {
  final udc = Get.put(UserDetailController());

  Future<void> addAddress(Address address) async {
    await post("/v1/customer/address", address.toJson(),
        decoder: (data) => ApiResponse.fromJson(data));
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
