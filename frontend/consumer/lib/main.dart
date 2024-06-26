import 'package:consumer/api/auth_provider.dart';
import 'package:consumer/controller/app_setting_controller.dart';
import 'package:consumer/controller/user_detail_controller.dart';
import 'package:consumer/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    final asc = Get.put(AppSettingController());

    return GetMaterialApp(
      title: "简商",
      home: const HomePage(),
      locale: const Locale("zh", "CN"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en", "US"), Locale("zh", "CN")],
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
          brightness: Brightness.dark),
      themeMode: asc.themeMode.value,
      debugShowCheckedModeBanner: false,
    );
  }
}
