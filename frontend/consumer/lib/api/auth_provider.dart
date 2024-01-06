import 'dart:async';

import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/domain/api_response.dart';
import 'package:consumer/domain/user_detail.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  final uc = Get.put(UserDetailController());

  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8080';
  }

  Future<UserDetail?> login(String username, String password) async {
    var response = (await post(
      "/v1/auth/login",
      {'username': username, 'password': password},
      decoder: (data) => ApiResponse.fromJson(data),
    )).body;
    if (response == null || response.data == null) {
      return null;
    }
    return UserDetail.fromJson(response.data);
  }

  Future<UserDetail?> register(String username, String password, int gender) async {
    var response = (await post(
      '/v1/auth/register',
      {'username': username, 'password': password, 'gender': gender},
      decoder: (data) => ApiResponse.fromJson(data),
    )).body;
    if (response == null || response.data == null) {
      return null;
    }
    return UserDetail.fromJson(response.data);
  }
}
