import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingController extends GetxController {
  var isDarkMode = false.obs;
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    isDarkMode.value = Get.isDarkMode;
    super.onInit();
  }

  Future<void> setMode(ThemeMode mode) async {
    Get.changeThemeMode(mode);
    switch (mode) {
    case ThemeMode.system:
      isDarkMode.value = Get.isDarkMode;
      break;
    case ThemeMode.light:
      isDarkMode.value = false;
      break;
    case ThemeMode.dark:
      isDarkMode.value = true;
      break;
    }
    await Get.forceAppUpdate();
  }

}
