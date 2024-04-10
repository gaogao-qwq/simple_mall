import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/component/management_navigation_rail.dart';
import 'package:management/component/theme_mode_menu_button.dart';
import 'package:management/component/user_profile_menu_button.dart';
import 'package:management/controller/navigation_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.put(NavigationController());

    final title = Obx(() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (child, animation) => 
        SlideTransition(
          position: Tween(
            begin: const Offset(0, -1),
            end: Offset.zero
          ).animate(animation),
          child: child),
      child: Text(
        nc.pageInfos[nc.currentIndex.value].title,
        key: ValueKey(nc.currentIndex.value),
      ),
    ));

    final appBar = AppBar(
      title: title,
      actions: const [
        ThemeModeMenuButton(),
        UserProfileMenuButton(),
      ],
    );

    return Scaffold(
      key: const ValueKey(1),
      appBar: appBar,
      body: Row(
        children: [
          const ManagementNavigationRail(),
          Expanded(
            child: Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 2),
                    end: Offset.zero
                  ).animate(animation),
                  child: child),
              child: nc.pageInfos[nc.currentIndex.value].page,
            )),
          ),
        ],
      ),
    );
  }
}
