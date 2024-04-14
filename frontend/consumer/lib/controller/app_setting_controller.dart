import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppSettingController extends GetxController {
  final box = GetStorage();
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    if (box.hasData("themeMode")) {
      themeMode.value = ThemeMode.values
          .where(
              (element) => element.index.isEqual(box.read("themeMode") as int))
          .elementAt(0);
    } else {
      box.write("themeMode", themeMode.value.index);
    }
    super.onInit();
  }

  Future<void> setMode(ThemeMode mode) async {
    Get.changeThemeMode(mode);
    themeMode.value = mode;
    box.write("themeMode", themeMode.value);
    await Get.forceAppUpdate();
  }
}
