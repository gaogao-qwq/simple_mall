import 'package:consumer/api/auth_provider.dart';
import 'package:consumer/controller/shopping_cart_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final ap = Get.put(AuthProvider());
  final udc = Get.put(UserDetailController());
  final scc = Get.put(ShoppingCartController());

  final formKey = GlobalKey<FormState>();
  var username = "".obs;
  var password = "".obs;

  void login() async {
    final userDetail = await ap.login(username.value, password.value);
    if (userDetail == null) {
      return;
    }
    udc.login(userDetail);
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

  void register() async {
    final userDetail = await ap.register(username.value, password.value, gender.value);
    if (userDetail == null) {
      return;
    }
    udc.login(userDetail);
    await scc.fetchCartItems();
    Get.back();
  }
}
