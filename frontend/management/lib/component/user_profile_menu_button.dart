import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/controller/user_detail_controller.dart';

class UserProfileMenuButton extends StatelessWidget {
  const UserProfileMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final udc = Get.put(UserDetailController());

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () =>
            udc.removeUser(),
          child: const Row(
            children: [
              Icon(Icons.logout),
              SizedBox(width: 8),
              Text("登出"),
            ],
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(udc.username.value),
      ),
    );
  }
}
