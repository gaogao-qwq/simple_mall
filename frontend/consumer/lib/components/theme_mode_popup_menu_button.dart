import 'package:consumer/controller/app_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeModePopupMenu extends StatelessWidget {
  const ThemeModePopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final asc = Get.put(AppSettingController());

    return Obx(() => PopupMenuButton(
          initialValue: asc.themeMode.value,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(Icons.monitor),
                  SizedBox(width: 8),
                  Text("跟随系统"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(Icons.light_mode),
                  SizedBox(width: 8),
                  Text("明亮模式"),
                ],
              ),
            ),
            const PopupMenuItem(
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
          icon: () {
            switch (asc.themeMode.value) {
              case ThemeMode.system:
                return const Icon(Icons.monitor);
              case ThemeMode.dark:
                return const Icon(Icons.dark_mode);
              case ThemeMode.light:
                return const Icon(Icons.light_mode);
            }
          }(),
          onSelected: (value) async => await asc.setMode(value),
        ));
  }
}
