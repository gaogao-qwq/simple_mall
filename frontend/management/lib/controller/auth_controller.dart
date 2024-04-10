import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/api/auth_provider.dart';
import 'package:management/controller/user_detail_controller.dart';

class AuthController extends GetxController {
  final ap = Get.put(AuthProvider());
  final udc = Get.put(UserDetailController());
  final formKey = GlobalKey<FormState>();
  var username = "".obs;
  var password = "".obs;
  
  Future<void> login() async {
    final userDetail = await ap.login(
      username.value, password.value);
    if (userDetail == null) {
      return;
    }
    udc.saveUser(userDetail);
  }
}
