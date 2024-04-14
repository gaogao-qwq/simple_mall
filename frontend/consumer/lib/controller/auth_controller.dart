import 'package:consumer/api/auth_provider.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ap = Get.put(AuthProvider());
  final udc = Get.put(UserDetailController());
  final scc = Get.put(ShoppingCartController());

  final formKey = GlobalKey<FormState>();
  var username = "".obs;
  var password = "".obs;

  Future<void> login() async {
    final userDetail = await ap.login(username.value, password.value);
    if (userDetail == null) {
      Get.rawSnackbar(title: "Oops", message: "登录失败");
      return;
    }
    udc.saveUser(userDetail);
    await scc.fetchCartItems();
    Get.back();
  }
}

class RegisterController extends GetxController {
  final ap = Get.put(AuthProvider());
  final udc = Get.put(UserDetailController());
  final scc = Get.put(ShoppingCartController());

  final formKey = GlobalKey<FormState>();
  var username = "".obs;
  var gender = 0.obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  Future<void> register() async {
    final userDetail =
        await ap.register(username.value, password.value, gender.value);
    if (userDetail == null) {
      Get.rawSnackbar(title: "Oops", message: "注册失败");
      return;
    }
    udc.saveUser(userDetail);
    await scc.fetchCartItems();
    Get.back();
  }
}
