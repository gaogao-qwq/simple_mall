import 'package:consumer/api/auth_provider.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ap = Get.put(AuthProvider());
  final udc = Get.put(UserDetailController());

  final formKey = GlobalKey<FormState>();
  var username = "".obs;
  var password = "".obs;

  void login() async {
    final userDetail = await ap.login(username.value, password.value);
    if (userDetail == null) {
      return;
    }
    udc.username.value = userDetail.username;
    udc.accessToken.value = userDetail.accessToken;
    udc.refreshToken.value = userDetail.refreshToken;
    Get.back();
  }
}

class RegisterController extends GetxController {
  final ap = Get.put(AuthProvider());
  final udc = Get.put(UserDetailController());

  final formKey = GlobalKey<FormState>();
  var username = "".obs;
  var gender = 0.obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  void register() async {
    final userDetail = await ap.register(username.value, password.value, gender.value);
    if (userDetail == null) {
      return;
    }
    udc.username.value = userDetail.username;
    udc.accessToken.value = userDetail.accessToken;
    udc.refreshToken.value = userDetail.refreshToken;
    Get.back();
  }
}