import 'package:consumer/api/auth_provider.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final udc = Get.put(UserDetailController());
  final ap = Get.put(AuthProvider());
  if (udc.isLogin()) {
    final userDetail = await ap.refresh(udc.refreshToken.value);
    if (userDetail == null) {
      udc.removeUser();
    } else {
      udc.saveUser(userDetail);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '商城',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
