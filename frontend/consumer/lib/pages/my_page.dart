import 'package:consumer/components/mall_navigation_bar.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uc = Get.put(UserDetailController());

    return Scaffold(
      appBar: AppBar(title: const Text("我的")),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: Image.asset("images/avatar.png").image,
                ),
                title: uc.isLogin() 
                  ? Text(uc.username.value, style: const TextStyle(fontSize: 24),) 
                  : const Text("未登录，请先登录"),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  if (!uc.isLogin()) {
                    Get.to(const AuthPage());
                  }
                },
              )
            )
          ),
          Card(
            margin: const EdgeInsets.all(2),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("设置"),
                  onTap: () {},
                ),
                ListTile(
                  leading:const Icon(Icons.logout),
                  title: const Text("退出登录"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("关于"),
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: "简单商城",
                    applicationLegalese: "CopyRight © 2023 Zhihao Zhou",
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MallNavigationBar(),
    );
  }
}