import 'package:consumer/components/theme_mode_popup_menu_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ListView settingList = ListView(
      children: const [
        ListTile(
          title: Text("显示模式"),
          trailing: ThemeModePopupMenu(),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text("设置")),
      body: settingList,
    );
  }
}
