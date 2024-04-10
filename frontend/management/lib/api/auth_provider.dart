import 'package:get/get.dart';
import 'package:management/controller/user_detail_controller.dart';
import 'package:management/domain/api_response.dart';
import 'package:management/domain/user_detail.dart';
import 'package:management/env.dart';

class AuthProvider extends GetConnect {
  final uc = Get.put(UserDetailController());

  @override
  void onInit() {
    httpClient.baseUrl = Env.apiUri;
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

  Future<UserDetail?> refresh(String refreshToken) async {
    var response = (await post(
      "/v1/auth/refresh",
      {"refreshToken": refreshToken},
      decoder: (data) => ApiResponse.fromJson(data),
    )).body;
    if (response == null || response.data == null) {
      return null;
    }
    return UserDetail.fromJson(response.data);
  }

  // TODO: Implement accessToken check
  Future<bool> check(String accessToken) async {
    var response = (await post(
      "/v1/auth/check",
      {"refreshToken": accessToken},
      decoder: (data) => ApiResponse.fromJson(data),
    )).body;
    throw UnimplementedError();
  }
}
