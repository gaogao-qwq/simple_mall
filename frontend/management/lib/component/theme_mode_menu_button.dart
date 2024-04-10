import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/controller/app_setting_controller.dart';

class ThemeModeMenuButton extends StatelessWidget {
  const ThemeModeMenuButton ({super.key});

  @override
  Widget build(BuildContext context) {
    final asc = Get.put(AppSettingController());

    return Obx(() => PopupMenuButton(
      initialValue: asc.themeMode.value,
      icon: asc.isDarkMode.value
        ? const Icon(Icons.dark_mode)
        : const Icon(Icons.light_mode),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(Icons.light_mode),
              SizedBox(width: 8),
              Text("明亮模式"),
            ],
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(Icons.dark_mode),
              SizedBox(width: 8),
              Text("黑暗模式"),
            ],
          ),
        ),
      ],
      onSelected: (value) async =>
        await asc.setMode(value),
    ));
  }
}
