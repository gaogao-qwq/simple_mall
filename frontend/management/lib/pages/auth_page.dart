import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/component/theme_mode_menu_button.dart';
import 'package:management/controller/auth_controller.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.put(AuthController());

    final appBar = AppBar(
      title: const Text("登录管理系统"),
      backgroundColor: context.theme.colorScheme.surfaceVariant,
      actions: const [
        ThemeModeMenuButton(),
      ],
    );

    final loginForm = Form(
      key: ac.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "登录",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "管理员账号",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "请输入管理员账号" : null,
              onChanged: (value) => ac.username.value = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "密码",
              ),
              obscureText: true,
              validator: (value) =>
                  value == null || value.isEmpty ? "请输入密码" : null,
              onChanged: (value) => ac.password.value = value,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () async {
                  if (!ac.formKey.currentState!.validate()) return;
                  await ac.login();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    SizedBox(width: 8),
                    Text("登录"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: const ValueKey(0),
      appBar: appBar,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(8, 8),
                color: context.theme.colorScheme.shadow.withOpacity(0.15),
                blurRadius: 8,
              ),
            ],
          ),
          constraints: BoxConstraints.loose(const Size(720, 500)),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    color: context.theme.colorScheme.primaryContainer,
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.manage_search,
                          size: 64,
                          color: context.theme.colorScheme.onPrimaryContainer,
                        ),
                        const Text(
                          "简商管理系统",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: loginForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
