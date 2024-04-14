import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:management/api/auth_provider.dart';
import 'package:management/controller/user_detail_controller.dart';
import 'package:management/pages/auth_page.dart';
import 'package:management/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await GetStorage.init();
  final udc = Get.put(UserDetailController());
  final ap = Get.put(AuthProvider());
  if (udc.isLogin) {
    final userDetail = await ap.refresh(udc.refreshToken.value);
    if (userDetail == null) {
      udc.removeUser();
    } else {
      udc.saveUser(userDetail);
    }
  }
  runApp(const ManagementApp());
}

class ManagementApp extends StatelessWidget {
  const ManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    final udc = Get.put(UserDetailController());

    return GetMaterialApp(
      title: "简商管理系统",
      home: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
            child: udc.isLogin ? const HomePage() : const AuthPage(),
          )),
      locale: const Locale("zh", "CN"),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en", "US"), Locale("zh", "CN")],
      theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
          brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
